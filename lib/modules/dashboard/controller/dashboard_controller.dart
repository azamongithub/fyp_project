import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../notifications_services/notifications_services.dart';

class DashboardController extends ChangeNotifier {
  NotificationServices notificationServices = NotificationServices();
  double _workoutProgress = 0.0;
  double _mealProgress = 0.0;
  double get workoutProgress => _workoutProgress;
  double get mealProgress => _mealProgress;

  Future<void> fetchWeeklyProgress() async {
    try {
      double mealPercentage = await calculateWeeklyMealProgress();
      double workoutPercentage = await calculateWeeklyWorkoutProgress();
      _mealProgress = mealPercentage;
      _workoutProgress = workoutPercentage;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weekly progress: $e');
      }
    }
  }

  Future<double> calculateWeeklyMealProgress() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final mealProgressRef =
          FirebaseFirestore.instance.collection('MealProgress').doc(user.uid);
      try {
        DocumentSnapshot progressSnapshot = await mealProgressRef.get();
        if (progressSnapshot.exists) {
          int totalDaysInWeek = 7;
          // Explicitly cast to Map<String, dynamic>
          Map<String, dynamic> progressData =
              progressSnapshot.data() as Map<String, dynamic>;
          // Get the keys (days) from the map
          List<String> recordedDays = List<String>.from(progressData.keys);
          // Remove the 'totalProgress' key
          recordedDays.remove('totalProgress');
          // Calculate the progress percentage
          double progressPercentage =
              (recordedDays.length / totalDaysInWeek) * 100;
          // Print the progress percentage
          if (kDebugMode) {
            print('Meal Progress Percentage: $progressPercentage%');
          }
          return progressPercentage;
        } else {
          if (kDebugMode) {
            print('No meal progress data found.');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error calculating meal progress: $e');
        }
      }
    }

    return 0.0;
  }

  Future<double> calculateWeeklyWorkoutProgress() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final workoutProgressRef = FirebaseFirestore.instance
          .collection('WorkoutProgress')
          .doc(user.uid);
      try {
        DocumentSnapshot progressSnapshot = await workoutProgressRef.get();
        if (progressSnapshot.exists) {
          int totalDaysInWeek = 7;
          // Explicitly cast to Map<String, dynamic>
          Map<String, dynamic> progressData =
              progressSnapshot.data() as Map<String, dynamic>;
          // Get the keys (days) from the map
          List<String> recordedDays = List<String>.from(progressData.keys);
          // Remove the 'totalProgress' key
          recordedDays.remove('totalProgress');
          // Calculate the progress percentage
          double progressPercentage =
              (recordedDays.length / totalDaysInWeek) * 100;
          // Print the progress percentage
          if (kDebugMode) {
            print('Weekly Progress Percentage: $progressPercentage%');
          }
          return progressPercentage;
        } else {
          if (kDebugMode) {
            print('No weekly progress data found.');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error calculating weekly progress: $e');
        }
      }
    }
    return 0.0;
  }
}
