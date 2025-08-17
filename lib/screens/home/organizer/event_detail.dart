import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/models/user.dart';
import 'package:project/models/event.dart';
import 'package:project/services/database_service.dart';

class EventDetail extends StatelessWidget {
  final EventModel event;

  const EventDetail({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Event Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          bottom: TabBar(
            overlayColor:
                WidgetStateColor.resolveWith((_) => Colors.transparent),
            tabs: [
              Tab(
                icon: Icon(Icons.people),
                text: 'Attendees',
              ),
              Tab(
                icon: Icon(Icons.location_on),
                text: 'Locations',
              ),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: TabBarView(
          children: [
            _buildAttendeesTab(),
            _buildLocationsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeesTab() {
    return event.attendees.isEmpty
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
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            itemCount: event.attendees.length,
            itemBuilder: (BuildContext context, int index) {
              final attendee = event.attendees[index];
              return FutureBuilder<UserModel?>(
                future: DatabaseService().getUser(attendee.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('An error has occured'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      child: ListTile(
                        title: Container(
                          height: 20.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        subtitle: Container(
                          height: 15.h,
                          width: 100.w,
                          margin: EdgeInsets.only(top: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    );
                  }

                  final user = snapshot.data!;
                  return Container(
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text(
                          user.name[0].toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.email,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Gap(2.h),
                          Text(
                            'Ticket ID: ${attendee.id}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color:
                              attendee.isChecked ? Colors.green : Colors.orange,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          attendee.isChecked ? 'Checked In' : 'Not Checked',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
  }

  Widget _buildLocationsTab() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      itemCount: event.location.length,
      itemBuilder: (BuildContext context, int index) {
        final location = event.location[index];
        final address = location['address'];
        final name = location['name'];
        final ticketCount = location['ticketCount'];

        return Container(
          margin: EdgeInsets.all(8.w),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.place,
                    color: Colors.grey[600],
                    size: 16.sp,
                  ),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      address,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: ticketCount > 10 ? Colors.green[50] : Colors.red[50],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: ticketCount > 10 ? Colors.green : Colors.red,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.confirmation_number,
                      color: ticketCount > 10 ? Colors.green : Colors.red,
                      size: 16.sp,
                    ),
                    Gap(6.w),
                    Text(
                      '$ticketCount tickets remaining',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: ticketCount > 10
                            ? Colors.green[700]
                            : Colors.red[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
