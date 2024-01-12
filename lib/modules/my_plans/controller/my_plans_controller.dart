import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../models/all_plan_model.dart';
import '../../../services/api_repository.dart';

class MyPlansController extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  late PredictionModel _apiData;
  PredictionModel get apiData => _apiData;
  Map<String, dynamic> _responseData = {};
  Map<String, dynamic> get responseData => _responseData;
  double retrievedCalories = 0;
  String mealPlan = '';
  String workoutPlan = '';
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchAllData() async {
    await Future.wait([
      fetchAllPlans(),
    ]);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAndPassUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    print('fetchAndPassUserDetails is called');
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserDataCollection')
        .doc(user!.uid)
        .get();

    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        fetchDataAndStore({
          "Age": userData['age'],
          "Gender": userData['gender'],
          "Height": userData['heightInFeet'],
          "Weight": userData['weight'],
          "Fitness_Level": userData['fitnessLevel'],
          "Fitness_Goal": userData['fitnessGoal'],
          "Medical_History": userData['disease'] == 'other'
              ? userData['disease'] = 'none'
              : userData['disease'],
        });
      }
    } else {
      if (kDebugMode) {
        print('Document does not exist');
      }
    }
    notifyListeners();
  }

  Future<void> fetchDataAndStore(Map<String, dynamic> requestData) async {
    try {
      _responseData = await _apiRepository.fetchData(requestData);
      await storeUserData(_responseData);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> fetchAllPlans() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      CollectionReference userFitnessCollection =
          FirebaseFirestore.instance.collection('UserDataCollection');
      DocumentSnapshot userSnapshot =
          await userFitnessCollection.doc(user!.uid).get();
      retrievedCalories = userSnapshot['calories'] ?? 'Not Found';
      mealPlan = userSnapshot['meal_plan'] ?? 'Not Found';
      workoutPlan = userSnapshot['workout_plan'] ?? 'Not Found';

      if (kDebugMode) {
        print('Fetched Calories: $retrievedCalories');
        print('Fetched Meal Plan: $mealPlan');
        print('Fetched Workout Plan: $workoutPlan');
      }
      notifyListeners();
    } catch (e) {
      retrievedCalories = 0.0;
      mealPlan = 'Not Found';
      workoutPlan = 'Not Found';
      if (kDebugMode) {
        print('Error fetching all plans data: $e');
      }
    }
  }

  Future<void> storeUserData(Map<String, dynamic> data) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user!.uid.isNotEmpty) {
        await FirebaseFirestore.instance.collection('UserDataCollection').doc(user!.uid).set(data, SetOptions(merge: true));
      } else {
        throw Exception('User not authenticated');
      }
    } catch (e) {
      print('Error storing data: $e');
      throw Exception('Failed to store data');
    }
  }
}
