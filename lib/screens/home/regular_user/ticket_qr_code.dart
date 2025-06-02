import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorScreen extends StatelessWidget {
  final String data = "Hello, this is QR data!";

  const QRGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 0.8.sh,
        ),
      ),
    );
  }
}
