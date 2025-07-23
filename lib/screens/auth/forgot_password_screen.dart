import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/auth_button.dart';
import 'package:project/widgets/form_text_field.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = '/forgot_password';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isVerifying = false;

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
                  controller: _emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap(30.h),
                isVerifying
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black,
                        size: 30.sp,
                      )
                    : AuthButton(
                        text: 'Submit',
                        onPressed: () async {
                          setState(() => isVerifying = true);

                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (_emailController.text.isEmpty) {
                            showToast('Please enter your email address.',
                                ToastificationType.warning, context);
                            setState(() => isVerifying = false);

                            return;
                          }
                          if (!emailRegex
                              .hasMatch(_emailController.value.text.trim())) {
                            showToast(
                                'Password must be 8+ chars, with upper, lower, and a digit.',
                                ToastificationType.error,
                                context);
                            setState(() => isVerifying = false);

                            return;
                          }
                          try {
                            await AuthService().resetPassword(
                                _emailController.value.text.trim());
                            if (!context.mounted) return;
                            showToast(
                                'Success! Check your email for a reset link.',
                                ToastificationType.success,
                                context);
                          } catch (e) {
                            if (!mounted) return;
                            showToast('Reset Password failed: $e',
                                ToastificationType.error, context);
                          }
                          setState(() => isVerifying = false);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
