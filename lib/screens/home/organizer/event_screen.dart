import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/home/organizer/attendees_screen.dart';
import 'package:project/screens/home/organizer/edit_event_screen.dart';

class EventScreen extends StatefulWidget {
  static String routeName = '/event_screen';
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListView.builder(
          itemCount: 10,
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  subtitle: Text(
                    '${DateFormat.yMEd().add_jms().format(DateTime.now())}\nPrice: ₦5,000\nNumber of Tickets: 100\nAvailable Tickets: 50',
                    style: TextStyle(fontSize: 12.sp),
                  ),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
