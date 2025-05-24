import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EventDetailsField extends StatelessWidget {
  final String title;
  final Widget child;
  const EventDetailsField({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(25.h),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0XFF828282),
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: child,
        ),
      ],
    );
  }
}
