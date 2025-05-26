import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile_screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50.h),
              Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r)),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Taiwo Ife',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('theife@gmail.com'),
                  leading: CircleAvatar(
                    radius: 25.r,
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              Gap(20.h),
              Text(
                'Personal Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Gap(10.h),
              profileText('First Name', 'Taiwo'),
              Gap(10.h),
              profileText('Last Name', 'Ife'),
              Gap(10.h),
              profileText('Email Address', 'theife@gmail.com'),
              Gap(10.h),
              profileText('Phone', '+2348123456789'),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileText(String title, String data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
          ),
          Gap(5.h),
          Text(
            data,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ],
      );
}
