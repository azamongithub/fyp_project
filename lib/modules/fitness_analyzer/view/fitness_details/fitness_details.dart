import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../common_components/custom_list_tile.dart';
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
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
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
                          GestureDetector(
                            onTap: () {
                              // provider.userHeightDialogAlert(
                              //     context, userData!['height']);
                            },
                            child: CustomListTile(
                              title: 'Height',
                              trailing: Text('${userData!['heightInFeet']} ft'),
                              iconData: FontAwesomeIcons.rulerVertical,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // provider.userWeightDialogAlert(
                              //     context, userData!['weight']);
                            },
                            child: CustomListTile(
                              title: 'Weight',
                              trailing: Text('${userData!['weight'].toString()} kg'),
                              iconData: FontAwesomeIcons.gaugeHigh,
                            ),
                          ),
                          InkWell(
                            // onTap: () {
                            //   Utils.positiveToastMessage('You can change your weight or height to update the BMI');
                            // },
                            child: CustomListTile(
                              title: 'BMI',
                              trailing: Text(userData!['bmi'].toString() ?? ''),
                              iconData: FontAwesomeIcons.calculator,
                            ),
                          ),
                          InkWell(
                            // onTap: () {
                            //   Utils.positiveToastMessage('You can change your weight or height to update the BMI Category');
                            // },
                            child: CustomListTile(
                              title: 'Fitness Level',
                              trailing: Text(userData!['fitnessLevel'] ?? ''),
                              iconData: FontAwesomeIcons.chartLine,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // provider.userFitnessGoalDialogAlert(
                              //     context, userData!['fitnessGoal'] ?? '');
                            },
                            child: CustomListTile(
                              title: 'Fitness Goal',
                              trailing: Text(userData!['fitnessGoal'] ?? ''),
                              iconData: FontAwesomeIcons.manatSign,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // provider.userHeightDialogAlert(
                              //     context, userData!['calories']);
                            },
                            child: CustomListTile(
                              title: 'Required Calories',
                              trailing: Text(userData!['calories'].toString() ?? ''),
                              iconData: FontAwesomeIcons.rulerVertical,
                            ),
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
