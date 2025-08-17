import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/models/ticket.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/utils/amount_format.dart';
import 'package:project/utils/format_date.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketDetailsScreen extends StatelessWidget {
  final TicketModel ticket;
  const TicketDetailsScreen({super.key, required this.ticket});

 

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final formattedDate = formatDate(ticket.dateOfEvent);

    final qrData = {
      'eventId': ticket.eventId,
      'attendeeId': ticket.attendeeId,
      'userId': user.user!.uid,
      'ticketId': ticket.id,
      'ticketType': ticket.ticketType,
      'eventName': ticket.eventName,
      'eventOrganizer': ticket.eventOrganizer,
      'location': ticket.location,
      'price': formatCurrency(ticket.price),
      'numberOfTickets': ticket.numberOfTickets,
      'dateOfEvent': formattedDate,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ticket Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: QrImageView(
                  data: jsonEncode(qrData),
                  version: QrVersions.auto,
                  size: 250.h,
                ),
              ),
              Text(
                ticket.eventName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              Gap(10.h),
              ticketInformation('TICKET ID', ticket.id),
              Gap(5.h),
              ticketInformation('EVENT ORGANIZER', ticket.eventOrganizer),
              Gap(5.h),
              ticketInformation('EVENT LOCATION', ticket.location),
              Gap(5.h),
              ticketInformation('PRICE', formatCurrency(ticket.price)),
              Gap(5.h),
              ticketInformation('TICKET TYPE', ticket.ticketType),
              Gap(5.h),
              ticketInformation(
                  'NO. OF TICKETS', ticket.numberOfTickets.toString()),
              Gap(5.h),
              ticketInformation(
                'DATE & TIME ',
                formatDate(ticket.dateOfEvent),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }

  Column ticketInformation(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
