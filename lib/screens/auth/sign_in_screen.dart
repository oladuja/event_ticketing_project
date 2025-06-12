import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/screens/auth/forgot_password_screen.dart';
import 'package:project/screens/auth/sign_up_screen.dart';
import 'package:project/widgets/auth_button.dart';
import 'package:project/widgets/form_text_field.dart';
import 'package:project/widgets/password_text_field.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = '/sign_in';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                Text(
                  'Hello Friend!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Gap(30.h),
                FormTextField(
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap(15.h),
                PasswordTextField(hintText: 'Password'),
                Gap(10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ForgotPasswordScreen.routeName),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                Gap(30.h),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                      SignUpScreen.routeName, (_) => false),
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                Gap(20.h),
                AuthButton(
                  text: 'Log In',
                  // onPressed: () => Navigator.of(context)
                  //     .pushReplacementNamed(SignInScreen.routeName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
