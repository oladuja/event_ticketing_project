import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Gap(30),
              Text(
                'Hello Friend!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                'Welcome back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(30),
              FormTextField(
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              Gap(15),
              PasswordTextField(hintText: 'Password'),
              Gap(10),
               Align(
                alignment: Alignment.centerRight,
                 child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                               ),
               ),
              Gap(30),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.black),
                ),
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(SignUpScreen.routeName),
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Gap(20),
              AuthButton(
                text: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
