import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../routes/route_name.dart';

class FitnessFormController extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController workoutController = TextEditingController();
  List<int> feetOptions = [3, 4, 5, 6, 7, 8];
  List<int> inchesOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  int selectedFeet = 4;
  int selectedInch = 9;
  double calculatedWeight = 0.0;
  double? calculatedHeightInFeet = 0.0;
  double? get weight => calculatedWeight;
  double? get height => calculatedHeightInFeet;
  double _calculatedBmi = 0.0;
  String? _fitnessLevel;
  bool isLoading = false;
  double? get calculatedBmi => _calculatedBmi;
  String? get fitnessLevel => _fitnessLevel;

  FitnessFormController() {
    loadFitnessData();
  }

  Future<void> loadFitnessData() async {
    try {
      if (user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('UserDataCollection')
            .doc(user!.uid)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          weightController.text =
              data['weight'] == null ? '' : data['weight'].toString();
          selectedFeet = data['feet'] ?? '';
          selectedInch = data['inch'] ?? '';
          notifyListeners();
        } else {
          print('Fitness data not found');
          print('Fitness data not found');
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void setSelectedFeet(int value) {
    selectedFeet = value;
    notifyListeners();
  }

  void setSelectedInch(int value) {
    selectedInch = value;
    notifyListeners();
  }

  void findFitnessLevel(double weight, double heightInCm) {
    if (weight != 0 && heightInCm != 0) {
      double _bmi = weight / ((heightInCm / 100) * (heightInCm / 100));
      _calculatedBmi = double.tryParse(_bmi.toStringAsFixed(2))!;
      if (_calculatedBmi >= 1 && _calculatedBmi < 18.5) {
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
      _calculatedBmi =
          0; // or any default value you want to set when BMI is not calculable
      _fitnessLevel = AppStrings.fitnessLevelNotDefined;
      notifyListeners();
    }
  }

  Future<void> saveFitnessDetails(BuildContext context) async {
    try {
      int totalInches = selectedFeet * 12 + selectedInch;
      double totalFeet = totalInches / 12;
      double heightInCm = totalFeet * 30.48;

      calculatedHeightInFeet = double.tryParse(totalFeet.toStringAsFixed(2));
      calculatedWeight = double.tryParse(weightController.text) ?? 0;
      findFitnessLevel(calculatedWeight, heightInCm);

      final fitnessData = {
        'weight': calculatedWeight,
        'feet': selectedFeet,
        'inch': selectedInch,
        'heightInFeet': calculatedHeightInFeet,
        'heightInCm': heightInCm,
        'bmi': calculatedBmi,
        'fitnessLevel': fitnessLevel,
      };
      await FirebaseFirestore.instance
          .collection('UserDataCollection')
          .doc(user!.uid)
          .set(fitnessData, SetOptions(merge: true));

      Navigator.pushNamed(context, RouteName.fitnessGoalForm);
    } catch (e) {
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
