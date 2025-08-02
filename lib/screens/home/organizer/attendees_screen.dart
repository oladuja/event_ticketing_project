import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/models/attendee.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database_service.dart';

class AttendeesScreen extends StatelessWidget {
  final List<AttendeeModel> attendees;

  const AttendeesScreen({super.key, required this.attendees});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendees',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: attendees.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Text(
                  "No attendees yet.",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemCount: attendees.length,
              itemBuilder: (BuildContext context, int index) {
                final attendee = attendees[index];
                return FutureBuilder<UserModel?>(
                  future: DatabaseService().getUser(attendee.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text(
                        'An error occurred',
                        style: TextStyle(color: Colors.red),
                      );
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text(
                        'An error occurred',
                        style: TextStyle(color: Colors.red),
                      );
                    }

                    final user = snapshot.data!;
                    return ListTile(
                      title: Text(
                        'Email: ${user.email}\nName: ${user.name}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'TIcket ID: ${attendee.id}',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      trailing: Checkbox(
                        value: attendee.isChecked,
                        fillColor:
                            WidgetStateColor.resolveWith((_) => Colors.black),
                        onChanged: null,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
