import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../routes/route_name.dart';

class FitnessGoalController extends ChangeNotifier {
  bool isLoading = false;
  String? selectedFitnessGoal;
  bool _isFitnessGoalCompleted = false;
  bool get isFitnessGoalCompleted => _isFitnessGoalCompleted;

  void setFitnessGoalCompleted() {
    _isFitnessGoalCompleted = true;
    notifyListeners();
  }

  void setSelectedFitnessGoal(String value) {
    selectedFitnessGoal = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> saveFitnessGoalDetails(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final fitnessGoalData = {
        'fitnessGoal': selectedFitnessGoal,
      };
      await FirebaseFirestore.instance
          .collection('UserDataCollection')
          .doc(user!.uid)
          .set(fitnessGoalData, SetOptions(merge: true));
      Navigator.pushNamed(context, RouteName.healthStatusForm);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      setIsLoading(false);
    }
  }
}
