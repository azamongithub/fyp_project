import 'package:CoachBot/res/component/trailing_list_tile.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:CoachBot/view_model/fitness/fitness_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FitnessDetails extends StatelessWidget {
  const FitnessDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String bmiCategory = '';

    final user = FirebaseAuth.instance.currentUser;
    final userFitnessStream = FirebaseFirestore.instance
        .collection('UserFitnessCollection')
        .doc(user!.uid)
        .snapshots();


    return StreamBuilder<DocumentSnapshot>(
      stream: userFitnessStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            // appBar: AppBar(
            //   title: Text('Fitness Details'),
            // ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return const Scaffold(
            // appBar: AppBar(
            //   title: Text('Fitness Details'),
            // ),
            body: Center(child: Text('No data available')),
          );
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
            bmiCategory = 'Underweight';
          } else if (bmi >= 18.5 && bmi < 25) {
            bmiCategory = 'Normal weight';
          } else if (bmi >= 25 && bmi < 30) {
            bmiCategory = 'Overweight';
          } else if (bmi >= 30) {
            bmiCategory = 'Obesity';
          }
          FirebaseFirestore.instance
              .collection('UserFitnessCollection')
              .doc(user!.uid)
              .update({
            'bmi': bmi,
            'bmiCategory': bmiCategory,
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
              create: (_) => FitnessController(),
              child: Consumer<FitnessController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.userHeightDialogAlert(
                                  context, userData!['height']);
                            },
                            child: TrailingListTile(
                              title: 'Height',
                              trailing: Text(userData!['height'] + ' cm' ?? ''),
                              iconData: FontAwesomeIcons.rulerVertical,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.userWeightDialogAlert(
                                  context, userData!['weight']);
                            },
                            child: TrailingListTile(
                              title: 'Weight',
                              trailing: Text(userData!['weight'] + ' kg' ?? ''),
                              iconData: FontAwesomeIcons.gaugeHigh,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Utils.positiveToastMessage('You can change your weight or height to update the BMI');
                            },
                            child: TrailingListTile(
                              title: 'BMI',
                              trailing: Text(userData!['bmi'].toStringAsFixed(2) ?? ''),
                              iconData: FontAwesomeIcons.calculator,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Utils.positiveToastMessage('You can change your weight or height to update the BMI Category');
                            },
                            child: TrailingListTile(
                              title: 'Category',
                              trailing: Text(userData!['bmiCategory'] ?? ''),
                              iconData: FontAwesomeIcons.chartLine,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.userFitnessGoalDialogAlert(
                                  context, userData!['fitnessGoal'] ?? '');
                            },
                            child: TrailingListTile(
                              title: 'Fitness Goal',
                              trailing: Text(userData!['fitnessGoal'] ?? ''),
                              iconData: FontAwesomeIcons.manatSign,
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
