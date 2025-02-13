import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project/screens/auth/account_type_screen.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
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
                'Tell us more about your organization',
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
              FormTextField(
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              Gap(15),
              FormTextField(
                hintText: 'Register business name',
                keyboardType: TextInputType.text,
              ),
              Gap(15),
              PasswordTextField(hintText: 'Password'),
              Gap(15),
              PasswordTextField(hintText: 'Confirm Password'),
              Gap(30),
              CheckboxListTile(
                value: checkboxStatus,
                side: BorderSide(color: Colors.black, width: 2),
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
                  ),
                ),
              ),
              AuthButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(AccountTypeScreen.routeName),
                text: 'Sign Up',
              ),
              Gap(20),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
