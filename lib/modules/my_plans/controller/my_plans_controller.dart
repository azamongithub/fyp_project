import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MyPlansController extends ChangeNotifier {
  double retrievedCalories = 0;
  String mealPlan = '';
  String workoutPlan = '';
  bool _dataFetched = false;
  bool get isDataFetched => _dataFetched;

  Future<void> fetchData() async {
    print("fetchData called");
    if (_dataFetched) {
      return;
    }
    try {
      print("fetchData called2");
      final user = FirebaseAuth.instance.currentUser;
      CollectionReference userFitnessCollection =
      FirebaseFirestore.instance.collection('UserDataCollection');
      DocumentSnapshot userSnapshot =
      await userFitnessCollection.doc(user!.uid).get();

      retrievedCalories = userSnapshot['calories'];
      mealPlan = userSnapshot['meal_plan'];
      workoutPlan = userSnapshot['workout_plan'];

      if (kDebugMode) {
        print('Calories: $retrievedCalories');
        print('Calories: $mealPlan');
        print('Calories: $workoutPlan');
      }

      _dataFetched = true; // Set the flag to indicate that data has been fetched
      notifyListeners(); // Notify listeners when data is updated
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching calories: $e');
      }
    }
  }
}
