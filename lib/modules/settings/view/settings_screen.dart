import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/modules/fitness/controller/fitness_form_controller.dart';
import 'package:CoachBot/modules/profile/controller/profile_form_controller.dart';
import 'package:CoachBot/modules/select_fitness_goal/view/fitness_goal._screen.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../common_components/custom_list_tile.dart';
import '../../../routes/route_name.dart';
import '../../../theme/text_style_util.dart';
import '../../login/view/login_screen.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.settings, style: CustomTextStyle.appBarStyle()),
        backgroundColor: const Color(0xff3140b0),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListTile(
                title: const Text("Profile"),
                iconData: FontAwesomeIcons.user,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.profileDetailsScreen);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ProfileDetailsScreen()));
                },
              ),
              CustomListTile(
                title: const Text('Change Password'),
                iconData: Icons.lock_outline,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.changePasswordScreen);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ChangePasswordScreen()));
                },
              ),
              CustomListTile(
                title: const Text('Send Feedback'),
                iconData: Icons.feedback_outlined,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.sendFeedbackScreen);
                },
              ),
              CustomListTile(
                title: const Text('Terms & Conditions'),
                iconData: FontAwesomeIcons.file,
                onTap: () {},
              ),
              CustomListTile(
                title: const Text('Privacy Policy'),
                iconData: FontAwesomeIcons.shieldHalved,
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.rightFromBracket),
                title: const Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance
                      .signOut();
                 await FirebaseFirestore.instance.terminate();
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => const LoginForm()),
                    (route) => false,
                  );
                  Utils.showLoadingSnackBar(context, 'Logging out....');
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
