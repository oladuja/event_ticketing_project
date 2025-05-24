import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/screens/auth/account_type_screen.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
import 'package:project/screens/auth/sign_up_screen.dart';
import 'package:project/screens/home/create_event.dart';
import 'package:project/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 683),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project',
        routes: {
          SignUpScreen.routeName: (_) => const SignUpScreen(),
          SignInScreen.routeName: (_) => const SignInScreen(),
          AccountTypeScreen.routeName: (_) => const AccountTypeScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          CreateEvent.routeName: (_) => const CreateEvent(),
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
