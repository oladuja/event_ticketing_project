import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  TextStyle get _headingStyle => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      );

  TextStyle get _bodyStyle => TextStyle(
        fontSize: 16.sp,
        height: 1.6,
        color: Colors.black87,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(16.h),
              Text(
                'By using this application, you agree to be bound by the following terms and conditions. Please review them carefully.',
                style: _bodyStyle,
              ),
              Gap(20.h),
              Text('1. Use of the App', style: _headingStyle),
              Gap(8.h),
              Text(
                'You agree to use this app only for lawful purposes and in a manner that does not violate any applicable laws or regulations.',
                style: _bodyStyle,
              ),
              Gap(20.h),
              Text('2. User Accounts', style: _headingStyle),
              Gap(8.h),
              Text(
                'You are solely responsible for maintaining the confidentiality of your login information and for all activities that occur under your account.',
                style: _bodyStyle,
              ),
              Gap(20.h),
              Text('3. Prohibited Activities', style: _headingStyle),
              Gap(8.h),
              Text(
                'The following activities are strictly prohibited:',
                style: _bodyStyle,
              ),
              Gap(6.h),
              Text(
                '• Unauthorized access to the app or its systems\n'
                '• Distribution of harmful, offensive, or illegal content\n'
                '• Attempting to interfere with or disrupt the app’s functionality',
                style: _bodyStyle,
              ),
              Gap(20.h),
              Text('4. Termination', style: _headingStyle),
              Gap(8.h),
              Text(
                'We reserve the right to suspend or terminate your access to the app at any time, without prior notice, if you violate these terms.',
                style: _bodyStyle,
              ),
              Gap(20.h),
              Text('5. Changes to Terms', style: _headingStyle),
              Gap(8.h),
              Text(
                'We may update these terms periodically. Continued use of the app after changes indicates your acceptance of the revised terms.',
                style: _bodyStyle,
              ),
              Gap(20.h),
              Text('6. Contact Us', style: _headingStyle),
              Gap(8.h),
              Text(
                'If you have any questions or concerns regarding these Terms & Conditions, please contact us at:',
                style: _bodyStyle,
              ),
              Gap(6.h),
              SelectableText(
                'event@support.com',
                style: _bodyStyle.copyWith(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
