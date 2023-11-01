import 'package:CoachBot/res/component/reusable_list_tile.dart';
import 'package:CoachBot/view/change_password/change_password_screen.dart';
import 'package:CoachBot/view/login/login_screen.dart';
import 'package:CoachBot/view/temp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../account_details/profile_details_screen12.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  //final bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableListTile(
                title: "Profile",
                iconData: FontAwesomeIcons.user,
                onTap: () {
                  // Navigator.pushNamed(context, RouteName.AccountDetailsScreen);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileDetailsScreen12()));
                },
              ),
              ReusableListTile(
                title: 'Workouts',
                iconData: FontAwesomeIcons.shieldHalved,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YoutubeVideoPlayerScreen()));
                },
              ),
              ReusableListTile(
                title: 'Get Premium',
                iconData: FontAwesomeIcons.crown,
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SubscriptionScreen())
                  // );
                },
              ),
              ReusableListTile(
                title: 'Change Password',
                iconData: Icons.lock_outline,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                },
              ),
              ReusableListTile(
                title: 'Send Feedback',
                iconData: Icons.feedback_outlined,
                onTap: () {},
              ),
              ReusableListTile(
                title: 'Terms & Conditions',
                iconData: FontAwesomeIcons.file,
                onTap: () {},
              ),
              ReusableListTile(
                title: 'Privacy Policy',
                iconData: FontAwesomeIcons.shieldHalved,
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.rightFromBracket),
                title: const Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance
                      .signOut(); // Sign out the user from Firebase Auth
                  FirebaseFirestore.instance.terminate();
                  Fluttertoast.showToast(msg: "You are Logged Out");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginForm()),
                    (route) => false,
                  );
                },
              ),
              // ListTile(
              //   leading: const Icon(FontAwesomeIcons.signOutAlt),
              //   title: const Text('Delete Account'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => DeleteAccountScreen()),
              //     );
              //     FirebaseAuth.instance.signOut(); // Sign out the user from Firebase Auth
              //     FirebaseFirestore.instance.terminate();
              //   },
              // ),
              // ListTile(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   tileColor: _isTapped ? Colors.red : null,
              //   textColor: _isTapped ? Colors.white : null,
              //   iconColor: _isTapped ? Colors.white : null,
              //   leading: const Icon(FontAwesomeIcons.trashAlt),
              //   title: const Text('Delete Account'),
              //   onTap: () {
              //     // Action when Delete Account is tapped
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
