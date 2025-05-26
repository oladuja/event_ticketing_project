import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/screens/auth/account_type_screen.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
import 'package:project/screens/auth/sign_up_screen.dart';
import 'package:project/screens/home/create_event.dart';
import 'package:project/screens/home/edit_event_scree.dart';
import 'package:project/screens/home/event_screen.dart';
import 'package:project/screens/home/home.dart';
import 'package:project/screens/home/organizer_home_screen.dart';
import 'package:project/screens/home/profile_screen.dart';

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
          OrganizerHomeScreen.routeName: (_) => const OrganizerHomeScreen(),
          CreateEvent.routeName: (_) => const CreateEvent(),
          Home.routeName: (_) => const Home(),
          EventScreen.routeName: (_) => const EventScreen(),
          EditEvent.routeName: (_) => const EditEvent(),
          ProfileScreen.routeName: (_) => const ProfileScreen(),
        },
        initialRoute: SignUpScreen.routeName,
      ),
    );
  }
}
