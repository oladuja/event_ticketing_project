import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendeesScreen extends StatelessWidget {
  const AttendeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Attendees',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: ListView.builder(
            itemCount: 100,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(
                'Danny Willson',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '#NSDFI23NINSDKNSDNFI33',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              trailing: Checkbox(
                value: true,
                fillColor: WidgetStateColor.resolveWith((_) => Colors.black),
                onChanged: (_) {},
              ),
            ),
          ),
        ));
  }
}
