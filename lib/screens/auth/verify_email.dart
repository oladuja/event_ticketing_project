import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/web.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
import 'package:project/screens/home/organizer/home.dart';
import 'package:project/screens/home/regular_user/regular_user_home.dart';
import 'package:project/services/database_service.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/auth_button.dart';
import 'dart:async';

import 'package:toastification/toastification.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isVerifying = false;
  int _resendCooldown = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  void _startCooldown() {
    _resendCooldown = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCooldown > 0) {
          _resendCooldown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _checkEmailVerified() async {
    setState(() => isVerifying = true);
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    final refreshedUser = FirebaseAuth.instance.currentUser;

    if (refreshedUser != null && refreshedUser.emailVerified) {
      final userData = await DatabaseService().getUser(refreshedUser.uid);
      final route = userData?.role == 'organizer'
          ? Home.routeName
          : RegularUserHome.routeName;

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
    } else {
      if (!mounted) return;

      showToast('Please verify your email to continue.',
          ToastificationType.warning, context);
    }
    setState(() => isVerifying = false);
  }

  Future<void> _resendEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    Logger().i(user);
    await user?.sendEmailVerification();
    if (!mounted) return;

    showToast('Verification email resent. Please check your inbox.',
        ToastificationType.success, context);
    _startCooldown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify Email',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(15.h),
                const Text(
                  'A verification link has been sent to your email. Please verify it to continue.',
                  textAlign: TextAlign.center,
                ),
                Gap(30.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF518E99),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _resendCooldown == 0 ? _resendEmail : null,
                  child: Text(
                    _resendCooldown == 0
                        ? 'Resend Verification Email'
                        : 'Resend in $_resendCooldown sec',
                  ),
                ),
                Gap(10.h),
                isVerifying
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black,
                        size: 30.sp,
                      )
                    : AuthButton(
                        onPressed: _checkEmailVerified,
                        text: 'Continue',
                      ),
                Gap(20.h),
                AuthButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (!context.mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      SignInScreen.routeName,
                      (_) => false,
                    );
                  },
                  text: 'Back to Sign In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
