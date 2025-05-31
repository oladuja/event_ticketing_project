import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:project/widgets/auth_button.dart';

class TicketDetailsScreen extends StatelessWidget {
  final dynamic tag;
  const TicketDetailsScreen({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
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
              Hero(
                tag: tag,
                child: Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15.r)
                      // image: DecorationImage(image: AssetImage())
                      ),
                ),
              ),
              Gap(10.h),
              Text(
                'Ife & Temi Live Concert',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              Gap(10.h),
              ticketInformation('ORGANIZER', 'Taiwo Ifeoluwa'),
              Gap(5.h),
              ticketInformation('PRICE', '₦5,000.00'),
              Gap(5.h),
              ticketInformation('TICKET TYPE', 'Regular'),
              Gap(5.h),
              ticketInformation('NO. OF TICKETS', '2'),
              Gap(5.h),
              ticketInformation('DATE & TIME',
                  DateFormat.yMEd().add_jms().format(DateTime.now())),
              Gap(20.h),
              AuthButton(
                text: 'SHOW QR CODE',
                backgroundColor: Colors.black,
                width: double.infinity,
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
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
