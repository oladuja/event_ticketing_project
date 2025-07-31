import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/screens/home/organizer/contact_us_screen.dart';
import 'package:project/screens/home/organizer/edit_profile.dart';
import 'package:project/screens/home/organizer/privacy_screen.dart';
import 'package:project/screens/home/organizer/tc_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/profile_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toastification/toastification.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() {
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

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
      body: user == null
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 30.sp,
              ),
            )
          : SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              header: CustomHeader(
                builder: (context, mode) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.black,
                      size: 30.sp,
                    ),
                  );
                },
              ),
              child: SingleChildScrollView(
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
                            user.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(user.email),
                          leading: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: Colors.grey.shade500,
                            child: Text(
                              user.name.isNotEmpty
                                  ? user.name[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () async {
                              final shouldRefresh =
                                  await Navigator.of(context).push<bool>(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const EditProfileScreen(isOrg: false),
                                ),
                              );

                              if (shouldRefresh == true) {}
                            },
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
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(20.h),
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
                        onTap: () async {
                          try {
                            await AuthService().signOut();
                            userProvider.clearUser();
                          } catch (e) {
                            if (!context.mounted) return;
                            showToast(
                                'An error occurred while logging out. Please try again.',
                                ToastificationType.error,
                                context);
                          }
                        },
                        icon: Icons.logout,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
