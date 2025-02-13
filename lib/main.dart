import 'package:flutter/material.dart';
import 'package:project/screens/auth/account_type_screen.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
import 'package:project/screens/auth/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      routes: {
        SignUpScreen.routeName: (_) => const SignUpScreen(),
        SignInScreen.routeName: (_) => const SignInScreen(),
        AccountTypeScreen.routeName: (_) => const AccountTypeScreen(),
      },
      initialRoute: SignUpScreen.routeName,
    );
  }
}
