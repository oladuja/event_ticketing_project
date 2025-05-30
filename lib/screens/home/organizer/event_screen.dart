import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/home/organizer/edit_event_scree.dart';

class EventScreen extends StatelessWidget {
  static String routeName = '/event_screen';
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                  '${DateFormat.yMEd().add_jms().format(DateTime.now())}\nPrice: ₦5,000'),
              trailing: PopupMenuButton<String>(
                color: Colors.white,
                icon: FaIcon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    Navigator.of(context).pushNamed(EditEvent.routeName);
                  } else if (value == 'delete') {
                    // Handle delete action
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
