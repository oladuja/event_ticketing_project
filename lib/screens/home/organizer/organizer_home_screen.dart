import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/home/organizer/attendees_screen.dart';
import 'package:project/screens/home/organizer/create_event.dart';
import 'package:project/widgets/amount_text.dart';
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
            overflow: TextOverflow.visible,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.all(8.0.w),
        //     child: CircleAvatar(
        //       radius: 20.r,
        //       backgroundColor: Color(0XFFD9D9D9),
        //       child: FaIcon(
        //         FontAwesomeIcons.solidUser,
        //         color: Color(0XFF6E7191),
        //         size: 24.sp,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      value: '₦90,000.00',
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
              // Gap(20.h),
              // BarChartSample2(),
              Gap(30.h),
              Text(
                'Live Events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AttendeesScreen(),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50.h,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        title: Text(
                          'Ife & Temi Live Concert \nLocation: Lagos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                        subtitle: Text(
                          '${DateFormat.yMEd().add_jms().format(DateTime.now())}\nPrice: ₦5,000\nNumber of Tickets: 100\nAvailable Tickets: 50',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        foregroundColor: Colors.white,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: Colors.black,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.qrcode, color: Colors.white),
            backgroundColor: Colors.black,
            onTap: () => Navigator.of(context).pushNamed(CreateEvent.routeName),
            label: 'Scan QR Code',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16.0,
            ),
            labelShadow: [BoxShadow(color: Colors.transparent)],
            labelBackgroundColor: Colors.transparent,
          ),
          SpeedDialChild(
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.plus, color: Colors.white),
            backgroundColor: Colors.black,
            onTap: () => Navigator.of(context).pushNamed(CreateEvent.routeName),
            label: 'Create Event',
            labelShadow: [BoxShadow(color: Colors.transparent)],
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
