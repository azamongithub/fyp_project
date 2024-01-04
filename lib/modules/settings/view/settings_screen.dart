import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../common_components/custom_list_tile.dart';
import '../../../routes/route_name.dart';
import '../../../theme/text_style_util.dart';
import '../../search_workout/view/workouts_list_screen.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.settings, style: CustomTextStyle.appBarStyle()),
        backgroundColor: AppColors.themeColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListTile(
                title: Text("Profile", style: CustomTextStyle.textStyle18()),
                iconData: FontAwesomeIcons.user,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.profileDetailsScreen);
                },
              ),
              CustomListTile(
                title: Text('Change Password', style: CustomTextStyle.textStyle18()),
                iconData: Icons.lock_outline,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.changePasswordScreen);
                },
              ),
              CustomListTile(
                title: Text('Send Feedback', style: CustomTextStyle.textStyle18()),
                iconData: Icons.feedback_outlined,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.sendFeedbackScreen);
                },
              ),
              CustomListTile(
                title: Text('Terms & Conditions', style: CustomTextStyle.textStyle18()),
                iconData: FontAwesomeIcons.file,
                onTap: () {},
              ),
              CustomListTile(
                title: Text('Privacy Policy', style: CustomTextStyle.textStyle18()),
                iconData: FontAwesomeIcons.shieldHalved,
                onTap: () {},
              ),
              CustomListTile(
                title: Text('Search Workout', style: CustomTextStyle.textStyle18()),
                iconData: FontAwesomeIcons.shieldHalved,
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => WorkoutListScreen()));
                },
              ),
              CustomListTile(
                title: Text('Logout', style: CustomTextStyle.textStyle18()),
                iconData: FontAwesomeIcons.rightFromBracket,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().disconnect();
                  await FirebaseFirestore.instance.terminate();
                  Navigator.pushReplacementNamed(context, RouteName.loginForm);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   CupertinoPageRoute(builder: (context) => const LoginForm()),
                  //   (route) => false,
                  // );
                  Utils.showLoadingSnackBar(context, 'Logging out....');
                },
              ),
              // ListTile(
              //   leading: const Icon(FontAwesomeIcons.plus),
              //   title: const Text('Add Disease'),
              //   onTap: () {
              //     Navigator.push(context,
              //         CupertinoPageRoute(builder: (context) => DiseaseForm()));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
