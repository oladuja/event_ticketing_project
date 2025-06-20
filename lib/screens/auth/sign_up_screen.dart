import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/web.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
import 'package:project/screens/auth/verify_email.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/database_service.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/auth_button.dart';
import 'package:project/widgets/form_text_field.dart';
import 'package:project/widgets/password_text_field.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/sign_up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkboxStatus = false;
  bool isVerifying = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final businessNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String selectedType = 'Individual';
  final accountTypes = ['Individual', 'Organization'];

  void _signUp() async {
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    final phoneRegex = RegExp(r'^(?:\+234|0)[789][01]\d{8}$');
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    setState(() => isVerifying = true);
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phoneNumber = phoneController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final organizationName = businessNameController.text.trim();
    final isOrganizer = selectedType == 'Organization';

    Logger().i({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'confirmPassword': confirmPassword,
      'organizationName': organizationName,
      'isOrganizer': isOrganizer
    });

    if ([name, email, phoneNumber, password, confirmPassword]
            .any((e) => e.isEmpty) ||
        (isOrganizer && organizationName.isEmpty)) {
      showToast('Please fill all fields', ToastificationType.error, context);
      setState(() => isVerifying = false);
      return;
    }

    if (!passwordRegex.hasMatch(password)) {
      showToast('Password must be 8+ chars, with upper, lower, and a digit.',
          ToastificationType.error, context);
      setState(() => isVerifying = false);
      return;
    }
    if (!emailRegex.hasMatch(email)) {
      showToast('Password must be 8+ chars, with upper, lower, and a digit.',
          ToastificationType.error, context);
      setState(() => isVerifying = false);
      return;
    }
    if (password != confirmPassword) {
      showToast('Passwords do not match', ToastificationType.error, context);
      setState(() => isVerifying = false);
      return;
    }
    if (!phoneRegex.hasMatch(phoneNumber)) {
      showToast('Enter valid Nigerian phone number', ToastificationType.error,
          context);
      setState(() => isVerifying = false);
      return;
    }
    if (!checkboxStatus) {
      showToast(
          'Agree to Terms & Privacy Policy', ToastificationType.error, context);
      setState(() => isVerifying = false);
      return;
    }

    try {
      final userCredential =
          await AuthService().signUp(email: email, password: password);
      final firebaseUser = userCredential.user!;
      await firebaseUser.sendEmailVerification();

      final newUser = UserModel(
        uid: firebaseUser.uid,
        email: email,
        name: name,
        phoneNumber: phoneNumber,
        role: isOrganizer ? 'organizer' : 'regular',
        organizationName: isOrganizer ? organizationName : null,
        totalEventsCreated: isOrganizer ? 0 : null,
        ticketsSold: isOrganizer ? 0.0 : null,
        totalCommission: isOrganizer ? 0.0 : null,
      );

      await DatabaseService().saveUser(newUser);
      if (!mounted) return;

      showToast('Verify your email before logging in.',
          ToastificationType.success, context);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const VerifyEmailScreen(),
        ),
        (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      showToast('Sign up failed: $e', ToastificationType.error, context);
    }
    setState(() => isVerifying = false);
  }

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
                Text('Hello Friend!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24.sp)),
                Text('You can register on our platform',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
                Gap(30.h),
                FormTextField(
                    controller: nameController,
                    hintText: 'Name',
                    keyboardType: TextInputType.name),
                Gap(15.h),
                FormTextField(
                    controller: emailController,
                    hintText: 'Email Address',
                    keyboardType: TextInputType.emailAddress),
                Gap(15.h),
                FormTextField(
                    controller: phoneController,
                    hintText: 'Phone Number',
                    keyboardType: TextInputType.phone),
                Gap(15.h),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  items: accountTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 14.sp),
                    contentPadding: EdgeInsets.only(left: 15.w),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                    labelText: 'Registering as',
                  ),
                  onChanged: (value) => setState(() => selectedType = value!),
                ),
                Gap(15.h),
                if (selectedType == 'Organization')
                  Column(children: [
                    FormTextField(
                        controller: businessNameController,
                        hintText: 'Register business name',
                        keyboardType: TextInputType.text),
                    Gap(15.h),
                  ]),
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
                  onChanged: (v) => setState(() => checkboxStatus = v!),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                      'I agree to the Terms of service & Privacy Policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.sp)),
                ),
                isVerifying
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black,
                        size: 30.sp,
                      )
                    : AuthButton(onPressed: _signUp, text: 'Sign Up'),
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
                        fontSize: 14.sp),
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
