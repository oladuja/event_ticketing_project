import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:project/models/attendee.dart';
import 'package:project/utils/show_toast.dart';
import 'package:toastification/toastification.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanned = false;

   String formatDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().add_jm().format(date);
  }


  @override
  void dispose() {
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (scanned) return;
      scanned = true;
      controller.pauseCamera();

      try {
        final data = json.decode(scanData.code ?? '');
        final String eventId = data['eventId'];
        final String attendeeId = data['attendeeId'];

        final attendeeRef = FirebaseDatabase.instance
            .ref('events/$eventId/attendees/$attendeeId');

        final snapshot = await attendeeRef.get();

        if (!snapshot.exists) {
          if (mounted) {
            showToast("Attendee not found", ToastificationType.error, context);
            controller.resumeCamera();
          }
          scanned = false;
          return;
        }

        final attendeeData = Map<String, dynamic>.from(snapshot.value as Map);
        final attendee = AttendeeModel.fromJson(attendeeData);

        await attendeeRef.update({'isChecked': true});

        if (!mounted) return;

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Check-In Successful "),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Event ID: $eventId"),
                Text("Attendee ID: ${attendee.id}"),
                Text("User ID: ${attendee.uid}"),
                Text("Tickets Bought: ${attendee.ticketsBought}"),
                Text("Checked In: true"),
                Text("Timestamp: ${formatDate(attendee.timestamp)}"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Close scanner
                },
                child: const Text("Done"),
              )
            ],
          ),
        );
      } catch (e) {
        if (mounted) {
          showToast("Invalid QR code", ToastificationType.error, context);
          controller.resumeCamera();
        }
        scanned = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Attendee QR")),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }
}
