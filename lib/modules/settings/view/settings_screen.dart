import 'package:CoachBot/common_components/custom_button.dart';
import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/modules/delete/components/delete_account_bottom_sheet.dart';
import 'package:CoachBot/modules/delete/view/delete_account_screen.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common_components/custom_list_tile.dart';
import '../../../routes/route_name.dart';
import '../../../theme/text_style_util.dart';
import '../components/logout_bottom_sheet.dart';

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
                title: Text('Privacy Policy', style: CustomTextStyle.textStyle18()),
                iconData: FontAwesomeIcons.shieldHalved,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.privacyPolicyScreen);
                },
              ),
              CustomListTile(
                title: Text('Terms & Conditions', style: CustomTextStyle.textStyle18()),
                iconData: FontAwesomeIcons.file,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.termsAndConditionsScreen);
                },
              ),
              CustomListTile(
                title: Text('Logout', style: CustomTextStyle.textStyle18()),
                iconData: FontAwesomeIcons.rightFromBracket,
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const LogoutConfirmationBottomSheet();
                    },
                  );
                },
              ),
              CustomListTile(
                title: Text('Delete Account', style: CustomTextStyle.textStyle18()),
                iconData: Icons.delete,
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const DeleteAccountBottomSheet();
                    },
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );
  }

}



