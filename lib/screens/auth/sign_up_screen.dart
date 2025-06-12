import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
import 'package:project/screens/home/organizer/home.dart';
import 'package:project/screens/home/regular_user/regular_user_home.dart';
import 'package:project/widgets/auth_button.dart';
import 'package:project/widgets/form_text_field.dart';
import 'package:project/widgets/password_text_field.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/sign_up';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkboxStatus = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String selectedType = 'Individual';
  final List<String> accountTypes = ['Individual', 'Organization'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
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
                  'You can register on our platform',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Gap(30.h),
                FormTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap(15.h),
                FormTextField(
                  controller: phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                Gap(15.h),

                // DropdownButton for user type
                DropdownButtonFormField<String>(
                  value: selectedType,
                  items: accountTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 14.sp),
                    contentPadding: EdgeInsets.only(left: 15.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    labelText: 'Registering as',
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                ),
                Gap(15.h),

                if (selectedType == 'Organization')
                  Column(
                    children: [
                      FormTextField(
                        controller: businessNameController,
                        hintText: 'Register business name',
                        keyboardType: TextInputType.text,
                      ),
                      Gap(15.h),
                    ],
                  ),

                PasswordTextField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                Gap(15.h),
                PasswordTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                ),
                Gap(30.h),
                CheckboxListTile(
                  value: checkboxStatus,
                  side: BorderSide(color: Colors.black, width: 2.w),
                  fillColor: WidgetStateProperty.all(Colors.black),
                  checkColor: Colors.white,
                  onChanged: (v) {
                    setState(() {
                      checkboxStatus = v!;
                    });
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'I agree to the Terms of service & Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                AuthButton(
                  onPressed: () {
                    final targetRoute = selectedType == 'Organization'
                        ? Home.routeName
                        : RegularUserHome.routeName;

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      targetRoute,
                      (_) => false,
                    );
                  },
                  text: 'Sign Up',
                ),
                Gap(20.h),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(SignInScreen.routeName),
                  child: Text(
                    'Already have an account? Sign In',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
