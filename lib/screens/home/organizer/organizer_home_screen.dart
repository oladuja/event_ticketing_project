import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:project/screens/home/organizer/create_event.dart';
import 'package:project/widgets/amount_text.dart';
import 'package:project/widgets/chart.dart';
import 'package:project/widgets/details_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizerHomeScreen extends StatelessWidget {
  static String routeName = '/organizer_home_screen';

  const OrganizerHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome back',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: Color(0XFFD9D9D9),
              child: FaIcon(
                FontAwesomeIcons.solidUser,
                color: Color(0XFF6E7191),
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(25.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AmountText(
                      title: 'Total Commisions',
                      value: '₦2,690,000.00',
                    ),
                    Gap(20.h),
                    Row(
                      children: [
                        DetailsText(
                          title: 'Events Created',
                          value: '12',
                        ),
                        Spacer(),
                        DetailsText(
                          title: 'Ticket Sold',
                          value: '1,200',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(20.h),
              BarChartSample2(),
              Gap(50.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Color(0XFF518E99),
                ),
                child: Center(
                  child: Text(
                    'Scan Ticket',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(CreateEvent.routeName),
        tooltip: 'Create an event',
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 24.sp,
        ),
      ),
    );
  }
}
