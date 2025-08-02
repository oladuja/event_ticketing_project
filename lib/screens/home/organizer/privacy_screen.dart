import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        title: const Text('Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.all(15.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(16.h),
              Text(
                'Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information.',
                style: TextStyle(fontSize: 16.sp),
              ),
              Gap(16.h),
              Text(
                'Information We Collect',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                '- Personal information (e.g., name, email address)\n'
                '- Usage data (e.g., app interactions)\n',
                style: TextStyle(fontSize: 16.sp),
              ),
              Gap(16.h),
              Text(
                'How We Use Information',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                '- To provide and maintain our services\n'
                '- To improve user experience\n'
                '- To send important updates',
                style: TextStyle(fontSize: 16.sp),
              ),
              Gap(16.h),
              Text(
                'Data Protection',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              Gap(8.h),
              Text(
                'We take reasonable measures to protect your information from unauthorized access.',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              Gap(16.h),
              Text(
                'If you have any questions about this Privacy Policy, contact us at event@support.com.',
                style: TextStyle(fontSize: 16.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
