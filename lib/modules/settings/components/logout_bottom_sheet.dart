// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../common_components/custom_button.dart';
import '../../../routes/route_name.dart';
import '../../../theme/color_util.dart';
import '../../../theme/text_style_util.dart';
import '../../../utils/utils.dart';
import '../../my_plans/controller/my_plans_controller.dart';

class LogoutConfirmationBottomSheet extends StatelessWidget {
  const LogoutConfirmationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Wrap(
          children: <Widget>[
            Center(
              child: Container(
                width: 50.0,
                height: 7.0,
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Center(child: Text('Logout', style: CustomTextStyle.textStyle24(fontWeight: FontWeight.w600))),
            SizedBox(height: 50.h),
            Center(child: Icon(FontAwesomeIcons.rightFromBracket, size: 60.sp)),
            SizedBox(height: 90.h),
            Center(child: Text('Are you sure you want to logout?', style: CustomTextStyle.textStyle18())),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  title: 'Logout',
                  height: 40.h,
                  width: 150.w,
                  onTap: () async{
                    Utils.positiveToastMessage('Logging out...');
                    await FirebaseAuth.instance.signOut();
                    // await GoogleSignIn().disconnect();
                    await FirebaseFirestore.instance.terminate();
                    Navigator.pushReplacementNamed(context, RouteName.loginForm);
                  },
                ),

                // SizedBox(width: 20.w),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      //color: AppColors.themeColor,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 2.w, color: AppColors.themeColor),
                    ),
                    child: Center(child: Text('Cancel', style:
                    CustomTextStyle.textStyle20(color: AppColors.themeColor),)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}