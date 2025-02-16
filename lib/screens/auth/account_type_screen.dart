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
  bool individual = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              height: size.height / 2,
              width: size.width / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      height: constraints.maxHeight / 2,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: individual ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/individual.png',
                            height: 120,
                          ),
                          Text(
                            'Individual',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: individual ? Colors.white : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    //
                    Container(
                      height: constraints.maxHeight / 2,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: !individual ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/organization.png',
                            height: 120,
                          ),
                          Text(
                            'Orgainzation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: !individual ? Colors.white : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(50),
            AccountTypeButton(
              title: 'Go back',
              isBack: false,
            ),
            Gap(15),
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
