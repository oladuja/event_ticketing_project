import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/screens/home/regular_user/list_of_event_screeen.dart';
import 'package:project/screens/home/regular_user/regular_user_home_screen.dart';
import 'package:project/screens/home/regular_user/user_profile_screen.dart';

class RegularUserHome extends StatefulWidget {
  static String routeName = '/regular_user_home';
  const RegularUserHome({super.key});

  @override
  State<RegularUserHome> createState() => _RegularUserHomeState();
}

class _RegularUserHomeState extends State<RegularUserHome> {
  int selectedPageIndex = 0;

  final List<Widget> pages = const [
    RegularHomeScreen(),
    ListOfEventScreeen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle:
            TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
        selectedItemColor: const Color(0XFF518E99),
        currentIndex: selectedPageIndex,
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.ticket),
            label: 'My Tickets',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCalendar),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
