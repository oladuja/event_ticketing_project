import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project/widgets/account_type_button.dart';

class AccountTypeScreen extends StatefulWidget {
  static String routeName = '/account_type';

  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Gap(50),
            Center(
              child: Text(
                'Choose your account type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Gap(50),
            Container(
              // height: Mediaq,
            ),
            Gap(50),
            AccountTypeButton(
              title: 'Go back',
              isBack: false,
            ),
            Gap(20),
            AccountTypeButton(
              title: 'Proceed',
              isBack: true,
            )
          ],
        ),
      ),
    );
  }
}
