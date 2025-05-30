import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/home/regular_user/event_detail_screen.dart';

class ListOfEventScreeen extends StatelessWidget {
  static String routeName = '/lis_of_event_screen';
  const ListOfEventScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Available Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EventDetailScreen(tag: index),
                ),
              ),
              child: ListTile(
                leading: Hero(
                  tag: index,
                  child: Container(
                    width: 50.h,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                title: Text(
                  'Ife & Temi Live Concert \nLocation: Lagos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    '${DateFormat.yMEd().add_jms().format(DateTime.now())}\nPrice: ₦5,000'),
              ),
            ),
          );
        },
      ),
    );
  }
}
