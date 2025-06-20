import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/auth/forgot_password_screen.dart';
import 'package:project/screens/auth/sign_in_screen.dart';
import 'package:project/screens/auth/sign_up_screen.dart';
import 'package:project/screens/home/regular_user/list_of_event_screeen.dart';
import 'package:project/screens/home/organizer/create_event.dart';
import 'package:project/screens/home/organizer/edit_event_screen.dart';
import 'package:project/screens/home/organizer/edit_profile.dart';
import 'package:project/screens/home/organizer/event_screen.dart';
import 'package:project/screens/home/organizer/home.dart';
import 'package:project/screens/home/organizer/organizer_home_screen.dart';
import 'package:project/screens/home/organizer/profile_screen.dart';
import 'package:project/screens/home/regular_user/regular_user_home.dart';
import 'package:project/screens/home/regular_user/regular_user_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/services/database_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
          ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
          OrganizerHomeScreen.routeName: (_) => const OrganizerHomeScreen(),
          CreateEvent.routeName: (_) => const CreateEvent(),
          Home.routeName: (_) => const Home(),
          EventScreen.routeName: (_) => const EventScreen(),
          EditEvent.routeName: (_) => const EditEvent(),
          ProfileScreen.routeName: (_) => const ProfileScreen(),
          EditProfileScreen.routeName: (_) => const EditProfileScreen(),
          RegularUserHome.routeName: (_) => const RegularUserHome(),
          RegularHomeScreen.routeName: (_) => const RegularHomeScreen(),
          ListOfEventScreeen.routeName: (_) => const ListOfEventScreeen(),
        },
        // initialRoute: SignInScreen.routeName,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Container());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const SignInScreen();
            }

            final uid = snapshot.data!.uid;
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);

            return FutureBuilder<UserModel?>(
              future: DatabaseService().getUser(uid),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Scaffold(),
                  );
                }

                if (userSnapshot.hasError || userSnapshot.data == null) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Failed to load user. Please try again.'),
                    ),
                  );
                }

                final userModel = userSnapshot.data!;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  userProvider.setUser(userModel);
                });
                return userModel.role == 'organizer'
                    ? const Home()
                    : const RegularUserHome();
              },
            );
          },
        ),
      ),
    );
  }
}
