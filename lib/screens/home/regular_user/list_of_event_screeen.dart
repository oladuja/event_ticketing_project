import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/home/regular_user/event_detail_screen.dart';

class ListOfEventScreeen extends StatefulWidget {
  static String routeName = '/lis_of_event_screen';
  const ListOfEventScreeen({super.key});

  @override
  State<ListOfEventScreeen> createState() => _ListOfEventScreeenState();
}

class _ListOfEventScreeenState extends State<ListOfEventScreeen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Available Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  builder: (_) => EventDetailScreen(tag: index),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  subtitle: Text(
                    '${DateFormat.yMEd().add_jms().format(DateTime.now())}\nPrice: ₦5,000\n100 Ticket(s) Left',
                    style: TextStyle(fontSize: 12.sp),
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
