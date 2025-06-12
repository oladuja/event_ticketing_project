import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/widgets/auth_button.dart';
import 'package:project/widgets/form_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = '/forgot_password';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(30.h),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                Gap(10.h),
                Text(
                  'Have no worries, we will send you a link to reset your password.',
                  textAlign: TextAlign.center,
                ),
                Gap(10.h),
                FormTextField(
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap(30.h),
                AuthButton(
                  text: 'Submit',
                  // onPressed: () => Navigator.of(context)
                  //     .pushReplacementNamed(ForgotPasswordScreen.routeName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
