import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/home/regular_user/ticket_details_screen.dart';

class RegularHomeScreen extends StatelessWidget {
  static String routeName = '/regular_user_home_screen';

  const RegularHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tickets',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TicketDetailsScreen(tag: i),
                ),
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
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                trailing: Text('Ticket Type: \nRegular'),
                subtitle: Text(
                  'Date Purchased ${DateFormat.yMEd().add_jms().format(DateTime.now())}',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
