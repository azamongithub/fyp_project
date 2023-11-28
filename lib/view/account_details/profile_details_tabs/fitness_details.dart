import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/res/component/trailing_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../fitness_analyzer_form/fitness_form_controller.dart';

class FitnessDetails extends StatelessWidget {
  const FitnessDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fitnessLevel = '';
    final user = FirebaseAuth.instance.currentUser;
    final userFitnessStream = FirebaseFirestore.instance
        .collection('UserFitnessCollection')
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
        void updateBMI() {
          final userData = snapshot.data!.data() as Map<String, dynamic>?;
          final user = FirebaseAuth.instance.currentUser;
          final double? weight = userData?['weight'] != null
              ? double.tryParse(userData?['weight'])
              : null;
          final double? height = userData?['height'] != null
              ? double.tryParse(userData?['height'])
              : null;

          final double bmi =
          (weight != null && height != null && weight != 0 && height != 0)
              ? weight / ((height / 100) * (height / 100))
              : 0;
          if (bmi < 18.5) {
            fitnessLevel = AppStrings.underWeight;
          } else if (bmi >= 18.5 && bmi < 25) {
            fitnessLevel = AppStrings.normalWeight;
          } else if (bmi >= 25 && bmi < 30) {
            fitnessLevel = AppStrings.overWeight;
          } else if (bmi >= 30) {
            fitnessLevel = AppStrings.obesity;
          }
          FirebaseFirestore.instance
              .collection('UserFitnessCollection')
              .doc(user!.uid)
              .update({
            'bmi': bmi,
            'fitnessLevel': fitnessLevel,
          });
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        updateBMI();
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
                            child: TrailingListTile(
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
                            child: TrailingListTile(
                              title: 'Weight',
                              trailing: Text('${userData!['weight']} kg'),
                              iconData: FontAwesomeIcons.gaugeHigh,
                            ),
                          ),
                          InkWell(
                            // onTap: () {
                            //   Utils.positiveToastMessage('You can change your weight or height to update the BMI');
                            // },
                            child: TrailingListTile(
                              title: 'BMI',
                              trailing: Text(userData!['bmi'].toStringAsFixed(2) ?? ''),
                              iconData: FontAwesomeIcons.calculator,
                            ),
                          ),
                          InkWell(
                            // onTap: () {
                            //   Utils.positiveToastMessage('You can change your weight or height to update the BMI Category');
                            // },
                            child: TrailingListTile(
                              title: 'Category',
                              trailing: Text(userData!['fitnessLevel'] ?? ''),
                              iconData: FontAwesomeIcons.chartLine,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // provider.userFitnessGoalDialogAlert(
                              //     context, userData!['fitnessGoal'] ?? '');
                            },
                            child: TrailingListTile(
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
                            child: TrailingListTile(
                              title: 'Calories',
                              trailing: Text(userData!['calories'] ?? ''),
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
