import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helper_classes/firebase_helper.dart';
import '../../models/user_model.dart';
import '../../res/component/custom_card.dart';
import '../../utils/utils.dart';

class FitnessGoalForm extends StatefulWidget {
  const FitnessGoalForm({super.key});

  @override
  _FitnessGoalFormState createState() => _FitnessGoalFormState();
}

class _FitnessGoalFormState extends State<FitnessGoalForm> {
  bool _isLoading = false;
  String? _selectedGoal;
  String? errorText;

  Future<void> _saveFitnessGoalDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final FitnessGoalData = {
        'email': user!.email,
        'fitnessGoal': _selectedGoal,
      };

      await FirebaseFirestore.instance
          .collection('UserGoalCollection')
          .doc(user!.uid)
          .set(FitnessGoalData);
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.yourMedicalCondition),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Center(
                child: Text(
                  'Select your Fitness Goal',
                  style: MyTextStyle.textStyle22(
                    fontWeight: FontWeight.w600,
                  ),
                )),
            SizedBox(height: 30.h),
            CustomCard(
                title: 'Muscle Building',
                isSelected: _selectedGoal == 'Muscle Building',
                onTap: () {
                  setState(() {
                    _selectedGoal = 'Muscle Building';
                    errorText = null;
                  });
                }),
            CustomCard(
                title: 'Weight Loss',
                isSelected: _selectedGoal == 'Weight Loss',
                onTap: () {
                  setState(() {
                    _selectedGoal = 'Weight Loss';
                    errorText = null;
                  });
                }),
            CustomCard(
                title: 'Weight Gain',
                isSelected: _selectedGoal == 'Weight Gain',
                onTap: () {
                  setState(() {
                    _selectedGoal = 'Weight Gain';
                    errorText = null;
                  });
                }),
            SizedBox(height: 30.h),
            CustomButton(
              title: 'Continue',
              loading: _isLoading,
              onTap: () {
                if (_selectedGoal != null) {
                  setState(() {
                    _isLoading = true;
                  });
                  addUserDataToFirestore(
                    UserModel(
                      fitnessGoal: _selectedGoal,
                    ),
                  );
                  _saveFitnessGoalDetails();
                  Navigator.pushNamed(context, RouteName.HealthStatusForm);
                } else {
                  Utils.positiveToastMessage("Please select your Fitness Goal");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
