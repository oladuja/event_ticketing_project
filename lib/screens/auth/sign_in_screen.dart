import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/screens/auth/forgot_password_screen.dart';
import 'package:project/screens/auth/sign_up_screen.dart';
import 'package:project/screens/auth/verify_email.dart';
import 'package:project/screens/home/organizer/organizer_home_screen.dart';
import 'package:project/screens/home/regular_user/regular_user_home_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/database_service.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/auth_button.dart';
import 'package:project/widgets/form_text_field.dart';
import 'package:project/widgets/password_text_field.dart';
import 'package:toastification/toastification.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = '/sign_in';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVerifying = false;

  Future<void> _handleSignIn() async {
    final email = emailController.value.text.trim();
    final password = passwordController.value.text;

    if (email.isEmpty || password.isEmpty) {
      showToast('Please enter both email and password',
          ToastificationType.error, context);
      return;
    }

    setState(() => isVerifying = true);
    try {
      final userCredential =
          await AuthService().signIn(email: email, password: password);
      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        if (!mounted) return;
        showToast(
            'Please verify your email. A new verification link has been sent.',
            ToastificationType.warning,
            context);
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const VerifyEmailScreen()),
          (_) => false,
        );
        return;
      }

      final userData = await DatabaseService().getUser(user!.uid);
      final route = userData?.role == 'organizer'
          ? OrganizerHomeScreen.routeName
          : RegularHomeScreen.routeName;

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
    } on AuthException catch (e) {
      showToast(e.message, ToastificationType.error, context);
    } catch (e) {
      showToast('An error occurred: $e', ToastificationType.error, context);
    } finally {
      if (mounted) setState(() => isVerifying = false);
    }
  }

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
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
                ),
                Text('Welcome back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    )),
                Gap(30.h),
                FormTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap(15.h),
                PasswordTextField(
                    controller: passwordController, hintText: 'Password'),
                Gap(10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ForgotPasswordScreen.routeName),
                    child: Text('Forgot Password?',
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                  ),
                ),
                Gap(30.h),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          SignUpScreen.routeName, (_) => false),
                  child: Text('Don\'t have an account? Sign Up',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp)),
                ),
                Gap(20.h),
                isVerifying
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black,
                        size: 30.sp,
                      )
                    : AuthButton(text: 'Log In', onPressed: _handleSignIn),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
