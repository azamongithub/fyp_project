import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../../view_model/services/shared_preferences_helper.dart';

class FitnessFormController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController workoutController = TextEditingController();
  List<int> feetOptions = [3, 4, 5, 6, 7, 8];
  List<int> inchesOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  int selectedFeet = 4;
  int selectedInch = 9;
  String? selectedFitnessGoal;
  List<String> fitnessGoal = [
    AppStrings.muscleBuilding,
    AppStrings.weightGain,
    AppStrings.weightLoss
  ];
  double bmi = 0;
  String? fitnessLevel;
  bool isLoading = false;

  bool _isFitnessCompleted = false;

  // Other fitness-related state or methods

  bool get isFitnessCompleted => _isFitnessCompleted;

  void setFitnessCompleted() {
    _isFitnessCompleted = true;
    notifyListeners();
  }

  void setSelectedFeet(int value) {
    selectedFeet = value;
    notifyListeners();
  }

  void setSelectedInch(int value) {
    selectedInch = value;
    notifyListeners();
  }

  void setSelectedFitnessGoal(String value) {
    selectedFitnessGoal = value;
    notifyListeners();
  }

  void calculateBMI(double heightInCm) {
    double weight = double.tryParse(weightController.text) ?? 0;

    if (weight != 0 && heightInCm != 0) {
      bmi = weight / ((heightInCm / 100) * (heightInCm / 100));
      if (bmi < 18.5) {
        fitnessLevel = AppStrings.underWeight;
      } else if (bmi >= 18.5 && bmi < 25) {
        fitnessLevel = AppStrings.normalWeight;
      } else if (bmi >= 25 && bmi < 30) {
        fitnessLevel = AppStrings.overWeight;
      } else if (bmi >= 30) {
        fitnessLevel = AppStrings.obesity;
      }
      notifyListeners();
    } else {
      bmi = 0;
      fitnessLevel = AppStrings.fitnessCategoryNotDefined;
      notifyListeners();
    }
  }

  Future<void> saveFitnessDetails(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      int totalInches = selectedFeet * 12 + selectedInch;
      double totalFeet = totalInches / 12;
      double heightInCm = totalFeet * 30.48;

      final fitnessData = {
        //'email': user!.email,
        'weight': weightController.text,
        'heightInFeet': totalFeet.toString(),
        'heightInCm': heightInCm.toString(),
        'bmi': bmi,
        'fitnessLevel': fitnessLevel,
        'fitnessGoal': selectedFitnessGoal,
        'calories': caloriesController.text,
        'workout': workoutController.text,
      };
      calculateBMI(heightInCm);
      await FirebaseFirestore.instance
          .collection('UserFitnessCollection')
          .doc(user!.uid)
          .set(fitnessData);
      //setFitnessCompleted();

      await SharedPreferencesHelper.setFitnessCompleted(true);
      Navigator.pushNamed(context, RouteName.healthStatusForm);
    } catch (e) {
      Utils.negativeToastMessage('Error');
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
