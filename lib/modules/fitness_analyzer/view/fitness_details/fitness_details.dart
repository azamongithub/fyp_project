import 'package:CoachBot/utils/toast_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    //String fitnessLevel = '';
    final user = FirebaseAuth.instance.currentUser;
    final userFitnessStream = FirebaseFirestore.instance
        .collection('UserDataCollection')
        .doc(user!.uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: userFitnessStream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // void updateBMI() {
        //   final userData = snapshot.data!.data() as Map<String, dynamic>?;
        //   final user = FirebaseAuth.instance.currentUser;
        //   final double? weight = userData?['weight'] != null
        //       ? double.tryParse(userData?['weight'])
        //       : null;
        //   final double? height = userData?['height'] != null
        //       ? double.tryParse(userData?['height'])
        //       : null;
        //
        //   double bmi =
        //   (weight != null && height != null && weight != 0 && height != 0)
        //       ? weight / ((height / 100) * (height / 100))
        //       : 0;
        //   if (bmi>=1 && bmi < 18.5) {
        //     fitnessLevel = AppStrings.underWeight;
        //   } else if (bmi >= 18.5 && bmi < 25) {
        //     fitnessLevel = AppStrings.normalWeight;
        //   } else if (bmi >= 25 && bmi < 30) {
        //     fitnessLevel = AppStrings.overWeight;
        //   } else if (bmi >= 30) {
        //     fitnessLevel = AppStrings.obesity;
        //   }
        //   else {
        //     bmi = 0; // or any default value you want to set when BMI is not calculable
        //     fitnessLevel = AppStrings.fitnessCategoryNotDefined;
        //   }
        //   FirebaseFirestore.instance
        //       .collection('UserFitnessCollection')
        //       .doc(user!.uid)
        //       .update({
        //     'bmi': bmi,
        //     'fitnessLevel': fitnessLevel,
        //   });
        // }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        if (userData!['weight'] == null) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(40.sp),
              color: ColorUtil.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('It looks like you have not provided your Fitness details'),
                  TextButton(
                    onPressed: () {
                      print('Weight is: ${userData?['weight']}');
                      userData!['weight'] == null ?
                      Navigator.pushNamed(context, RouteName.fitnessAnalyzerForm):
                      userData!['fitnessGoal'] == null ?
                      Navigator.pushNamed(context, RouteName.fitnessGoalForm) : null;
                    },
                    child: Text('Complete your Fitness Details', style: CustomTextStyle.textStyle18(color: ColorUtil.themeColor)),
                  ),
                ],
              ),
            ),
          );
        }
        //updateBMI();
        return Scaffold(
            // appBar: AppBar(
            //   title: Text('Fitness Details'),
            // ),
            resizeToAvoidBottomInset: false,
            body: ChangeNotifierProvider(
              create: (_) => FitnessFormController(),
              child: Consumer<FitnessFormController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomListTile(
                            title: 'Height',
                            trailing: Text('${userData!['heightInFeet']} ft'),
                            iconData: FontAwesomeIcons.rulerVertical,
                            onTap: (){
                              Navigator.pushNamed(context, RouteName.fitnessAnalyzerForm);
                            },
                          ),
                          CustomListTile(
                            title: 'Weight',
                            trailing: Text('${userData?['weight']} kg'),
                            iconData: FontAwesomeIcons.gaugeHigh,
                            onTap: (){
                              Navigator.pushNamed(context, RouteName.fitnessAnalyzerForm);
                            },
                          ),
                          CustomListTile(
                            title: 'BMI',
                            trailing: Text(userData?['bmi'].toString() ?? 'Not Calculated'),
                            iconData: FontAwesomeIcons.calculator,
                          ),
                          CustomListTile(
                            title: 'Fitness Level',
                            trailing: Text(userData!['fitnessLevel'] ?? 'Not Calculated'),
                            iconData: FontAwesomeIcons.chartLine,
                            onTap: () {
                              ToastUtils.positiveToastMessage('You can change your weight or height to update the BMI Category');
                            },
                          ),
                          CustomListTile(
                            title: 'Fitness Goal',
                            trailing: Text(userData!['fitnessGoal'] ?? 'Not Selected'),
                            iconData: FontAwesomeIcons.manatSign,
                            onTap: (){
                              Navigator.pushNamed(context, RouteName.fitnessGoalForm);
                              // userData!['fitnessGoal'] == null ?
                              // Navigator.pushNamed(context, RouteName.fitnessGoalForm): null;
                            },
                          ),
                          CustomListTile(
                            title: 'Required Calories',
                            trailing: Text(userData!['calories'].toString()),
                            iconData: FontAwesomeIcons.rulerVertical,
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
