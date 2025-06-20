import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
import 'package:project/screens/home/organizer/contact_us_screen.dart';
import 'package:project/screens/home/organizer/edit_profile.dart';
import 'package:project/screens/home/organizer/privacy_screen.dart';
import 'package:project/screens/home/organizer/tc_screen.dart';
import 'package:project/widgets/profile_widget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r)),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Taiwo Ife',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('theife@gmail.com'),
                  leading: CircleAvatar(
                    radius: 25.r,
                    backgroundColor: Colors.black,
                  ),
                  trailing: GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(EditProfileScreen.routeName),
                    child: Container(
                      padding: EdgeInsets.all(8.0.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0.r),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(20.h),
              // ProfileWc
              ProfileWidget(
                text: 'Privacy Policy',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyScreen(),
                  ),
                ),
                icon: Icons.policy,
              ),
              ProfileWidget(
                text: 'Terms & Conditions',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const TermsConditionsScreen(),
                  ),
                ),
                icon: Icons.rule,
              ),
              ProfileWidget(
                text: 'Contact Us',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ContactUsScreen(),
                  ),
                ),
                icon: Icons.contacts,
              ),
              ProfileWidget(
                text: 'Logout',
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                  (_) => false,
                ),
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
