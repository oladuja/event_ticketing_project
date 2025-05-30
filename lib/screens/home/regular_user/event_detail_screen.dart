import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatelessWidget {
  static String routeName = 'event_details_screen';
  const EventDetailScreen({super.key, required this.tag});

  final dynamic tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Details',
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
                  height: 250.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15.r)
                      // image: DecorationImage(image: AssetImage())
                      ),
                ),
              ),
              Gap(15.h),
              Text(
                'Made for more Conference',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              Gap(5.h),
              Text(
                'Category - Technology',
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
              Gap(5.h),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.calendar,
                    size: 16.sp,
                  ),
                  Gap(8.w),
                  Text(
                    DateFormat.yMEd().add_jms().format(DateTime.now()),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(5.h),
               Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.locationPin,
                    size: 16.sp,
                  ),
                  Gap(8.w),
                  Text(
                    'FUTA North Gate, Nigeria',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(10.h),
              
            ],
          ),
        ),
      ),
    );
  }
}
