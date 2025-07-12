import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.all(15.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Gap(16.w),
              Text(
                'By using this app, you agree to the following terms and conditions. Please read them carefully.',
                style: TextStyle(fontSize: 16.sp),
              ),
              Gap(16.h),
              Text(
                '1. Use of the App',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                'You must use the app in compliance with all applicable laws and regulations.',
                style: TextStyle(fontSize: 16.sp),
              ),
              Gap(16.h),
              Text(
                '2. User Accounts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                'You are responsible for maintaining the confidentiality of your login credentials and all activities under your account.',
                style: TextStyle(fontSize: 16.sp),
              ),
              Gap(8.h),
              Text(
                '3. Prohibited Activities',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                '- Engaging in unauthorized access\n'
                '- Distributing harmful or illegal content\n'
                '- Attempting to disrupt the app’s operation',
                style: TextStyle(fontSize: 16.sp),
              ),
              Gap(8.h),
              Text(
                '4. Termination',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                'We reserve the right to terminate or suspend access to the app immediately for violations.',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 16.sp),
              Text(
                '5. Changes to Terms',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                'We may update these terms from time to time. Continued use of the app constitutes acceptance of the new terms.',
                style: TextStyle(fontSize: 16.sp),
              ),
              Gap(8.h),
              Text(
                '6. Contact Us',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                'If you have any questions about these Terms & Conditions, contact us at support@example.com.',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
