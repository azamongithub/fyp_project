import 'package:CoachBot/modules/fitness/view/fitness_analyzer_form/fitness_analyzer_form.dart';
import 'package:CoachBot/modules/select_fitness_goal/view/fitness_goal._screen.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../common_components/custom_list_tile.dart';
import '../../../../routes/route_name.dart';
import '../../../../theme/color_util.dart';
import '../../../../theme/text_style_util.dart';
import '../../controller/fitness_form_controller.dart';

class FitnessDetails extends StatelessWidget {
  const FitnessDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userFitnessStream = FirebaseFirestore.instance
        .collection('UserDataCollection')
        .doc(user!.uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: userFitnessStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        if (userData == null) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(40.sp),
              color: AppColors.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'It looks like you have not provided your Fitness details'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteName.fitnessAnalyzerForm);
                    },
                    child: Text('Complete your Fitness Details',
                        style: CustomTextStyle.textStyle18(
                            color: AppColors.themeColor)),
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: ChangeNotifierProvider(
              create: (_) => FitnessFormController(),
              child: Consumer<FitnessFormController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 14.h, horizontal: 5.w),
                      child: Column(
                        children: [
                          CustomListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Height',
                                    style: CustomTextStyle.textStyle18()),
                                Text('Editable',
                                    style: CustomTextStyle.textStyle10(
                                        color: AppColors.themeColor,
                                        underline: true)),
                              ],
                            ),
                            trailing: Text('${userData['heightInFeet']} ft',
                                style: CustomTextStyle.textStyle14()),
                            iconData: FontAwesomeIcons.rulerVertical,
                            onTap: () async {
                              Utils.showLoadingSnackBar(context, 'Loading...');
                              await Future.delayed(
                                  const Duration(milliseconds: 400));
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const FitnessAnalyzerForm(
                                            isEdit: true,
                                          )));
                            },
                          ),
                          CustomListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Weight',
                                    style: CustomTextStyle.textStyle18()),
                                Text('Editable',
                                    style: CustomTextStyle.textStyle10(
                                        color: AppColors.themeColor,
                                        underline: true)),
                              ],
                            ),
                            trailing: Text('${userData['weight']} kg',
                                style: CustomTextStyle.textStyle14()),
                            iconData: FontAwesomeIcons.gaugeHigh,
                            onTap: () async {
                              Utils.showLoadingSnackBar(context, 'Loading...');
                              await Future.delayed(
                                  const Duration(milliseconds: 400));
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const FitnessAnalyzerForm(
                                            isEdit: true,
                                          )));
                            },
                          ),
                          CustomListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Fitness Goal',
                                    style: CustomTextStyle.textStyle18()),
                                Text('Editable',
                                    style: CustomTextStyle.textStyle10(
                                        color: AppColors.themeColor,
                                        underline: true)),
                              ],
                            ),
                            trailing: Text(
                                userData['fitnessGoal'] ?? 'Not Selected',
                                style: CustomTextStyle.textStyle14()),
                            iconData: FontAwesomeIcons.manatSign,
                            onTap: () async {
                              Utils.showLoadingSnackBar(context, 'Loading...');
                              await Future.delayed(
                                  const Duration(milliseconds: 400));
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const FitnessGoalForm(
                                            isEdit: true,
                                          )));
                            },
                          ),
                          CustomListTile(
                            title: Text('BMI',
                                style: CustomTextStyle.textStyle18()),
                            trailing: Text(userData['bmi'].toString(),
                                style: CustomTextStyle.textStyle14()),
                            iconData: FontAwesomeIcons.calculator,
                            onTap: () {
                              Utils.positiveToastMessage(
                                  'You can change your weight or height to update the BMI');
                            },
                          ),
                          CustomListTile(
                            title: Text('Fitness Level',
                                style: CustomTextStyle.textStyle18()),
                            trailing: Text(
                                userData['fitnessLevel'] ?? 'Not Calculated',
                                style: CustomTextStyle.textStyle14()),
                            iconData: FontAwesomeIcons.chartLine,
                            onTap: () {
                              Utils.positiveToastMessage(
                                  'You can change your weight or height to update the Fitness Level');
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
      },
    );
  }
}
