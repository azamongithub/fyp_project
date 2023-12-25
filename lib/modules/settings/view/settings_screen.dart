import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../add_diseases/view/add_disease_screen.dart';
import '../../../common_components/custom_list_tile.dart';
import '../../../routes/route_name.dart';
import '../../../theme/text_style_util.dart';
import '../../health_status/view/health_status_details/health_details_screen.dart';
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
                },
              ),
              CustomListTile(
                title: const Text('Change Password'),
                iconData: Icons.lock_outline,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.changePasswordScreen);
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
                  await FirebaseAuth.instance.signOut();
                  await FirebaseFirestore.instance.terminate();
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => const LoginForm()),
                    (route) => false,
                  );
                  Utils.showLoadingSnackBar(context, 'Logging out....');
                },
              ),

              ListTile(
                leading: const Icon(FontAwesomeIcons.plus),
                title: const Text('Add Disease'),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => DiseaseForm()));
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.plus),
                title: const Text('Health Details'),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => HealthDetailsScreen()));
                },
              ),
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
