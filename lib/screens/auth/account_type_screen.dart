import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/screens/home/organizer/home.dart';
import 'package:project/widgets/account_type_button.dart';

class AccountTypeScreen extends StatefulWidget {
  static String routeName = '/account_type';

  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  int individual = -1;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          children: [
            Gap(50.h),
            Center(
              child: Text(
                'Choose your account type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
            ),
            Gap(50.h),
            Container(
              height: size.height / 2,
              width: size.width / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2.r,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 2.r,
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        individual = 1;
                      }),
                      child: Container(
                        height: constraints.maxHeight / 2,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: individual == 1 ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/individual.png',
                              height: 120.h,
                            ),
                            Text(
                              'Individual',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: individual == 1
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        individual = 0;
                      }),
                      child: Container(
                        height: constraints.maxHeight / 2,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: individual == 0 ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.r),
                            bottomRight: Radius.circular(25.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/organization.png',
                              height: 120.h,
                            ),
                            Text(
                              'Orgainzation',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: individual == 0
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(50.h),
            AccountTypeButton(
              title: 'Go back',
              isBack: false,
              onTap: () => Navigator.of(context).pop(),
            ),
            Gap(15.h),
            AccountTypeButton(
              title: 'Proceed',
              isBack: true,
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  Home.routeName, (_) => false),
            )
          ],
        ),
      ),
    );
  }
}
