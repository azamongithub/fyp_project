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
  double _calculatedBmi = 0.0;
  String? _fitnessLevel;
  bool isLoading = false;

  double? get calculatedBmi => _calculatedBmi;
  String? get fitnessLevel => _fitnessLevel;

  bool _isFitnessCompleted = false;
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
  void findFitnessLevel(double weight, double heightInCm) {
    //double weight = double.tryParse(weightController.text) ?? 0;
    if (weight != 0 && heightInCm != 0) {
      double _bmi = weight / ((heightInCm / 100) * (heightInCm / 100));
      _calculatedBmi = double.tryParse(_bmi.toStringAsFixed(2))!;
      if (_calculatedBmi>=1 && _calculatedBmi < 18.5) {
        _fitnessLevel = 'Underweight';
      } else if (_calculatedBmi >= 18.5 && _calculatedBmi < 25) {
        _fitnessLevel = 'Normal weight';
      } else if (_calculatedBmi >= 25 && _calculatedBmi < 30) {
        _fitnessLevel = 'Overweight';
      } else if (_calculatedBmi >= 30) {
        _fitnessLevel = 'Obesity';
      }
      notifyListeners();
    } else {
      _calculatedBmi = 0; // or any default value you want to set when BMI is not calculable
      _fitnessLevel = AppStrings.fitnessLevelNotDefined;
      notifyListeners();
    }
  }

  Future<void> saveFitnessDetails(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      int totalInches = selectedFeet * 12 + selectedInch;
      double totalFeet = totalInches / 12;
      double heightInCm = totalFeet * 30.48;

      double? calculatedHeightInFeet = double.tryParse(totalFeet.toStringAsFixed(2));
      double? calculatedWeight = double.tryParse(weightController.text);

      findFitnessLevel(calculatedWeight!, heightInCm);

      final fitnessData = {
        'weight': calculatedWeight,
        'heightInFeet': calculatedHeightInFeet,
        'heightInCm': heightInCm,
        'bmi': calculatedBmi,
        'fitnessLevel': fitnessLevel,
        'fitnessGoal': selectedFitnessGoal ?? '', // Null check added here
        'calories': caloriesController.text,
        'workout': workoutController.text,
      };

      await FirebaseFirestore.instance
          .collection('UserFitnessCollection')
          .doc(user!.uid)
          .set(fitnessData);

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


  // void calculateBMI(double heightInCm) {
  //   double weight = double.tryParse(weightController.text) ?? 0;
  //
  //   if (weight != 0 && heightInCm != 0) {
  //     _bmi = weight / ((heightInCm / 100) * (heightInCm / 100));
  //     if (_bmi < 18.5) {
  //       fitnessLevel = 'Underweight';
  //     } else if (_bmi >= 18.5 && _bmi < 25) {
  //       fitnessLevel = 'Normal weight';
  //     } else if (_bmi >= 25 && _bmi < 30) {
  //       fitnessLevel = 'Overweight';
  //     } else if (_bmi >= 30) {
  //       fitnessLevel = 'Obesity';
  //     }
  //     notifyListeners();
  //     //return _bmi;
  //   } else {
  //     _bmi = 'Not Found' as double;
  //     fitnessLevel = AppStrings.fitnessCategoryNotDefined;
  //     notifyListeners();
  //   }
  // }
  //
  // Future<void> saveFitnessDetails(BuildContext context) async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //
  //     int totalInches = selectedFeet * 12 + selectedInch;
  //     double totalFeet = totalInches / 12;
  //     double heightInCm = totalFeet * 30.48;
  //
  //     final fitnessData = {
  //       //'email': user!.email,
  //       'weight': weightController.text,
  //       'heightInFeet': totalFeet.toString(),
  //       'heightInCm': heightInCm.toString(),
  //       //'bmi': calculateBMI(heightInCm),
  //       'bmi': bmi,
  //       'fitnessLevel': fitnessLevel,
  //       'fitnessGoal': selectedFitnessGoal,
  //       'calories': caloriesController.text,
  //       'workout': workoutController.text,
  //     };
  //     calculateBMI(heightInCm);
  //     await FirebaseFirestore.instance
  //         .collection('UserFitnessCollection')
  //         .doc(user!.uid)
  //         .set(fitnessData);
  //     //setFitnessCompleted();
  //
  //     await SharedPreferencesHelper.setFitnessCompleted(true);
  //     Navigator.pushNamed(context, RouteName.healthStatusForm);
  //   } catch (e) {
  //     Utils.negativeToastMessage('Error');
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
