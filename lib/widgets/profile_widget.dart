import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class ProfileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final IconData icon;
  const ProfileWidget({
    super.key,
    required this.onTap,
    required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        width: double.infinity,
        padding: EdgeInsets.all(8.0.w),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white70,
        ),
        child: Row(
          children: [
            FaIcon(icon),
            Gap(10.h),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
