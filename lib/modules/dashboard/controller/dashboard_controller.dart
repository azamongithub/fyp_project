import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DashboardController extends ChangeNotifier {
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
          FirebaseFirestore.instance.collection('MealProgress').doc(user.email);
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
          .doc(user.email);
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

  Future<void> reNewProgressIfMonday() async {
    final user = FirebaseAuth.instance.currentUser;
    DateTime now = DateTime.now();

    // Get the last execution date from Firestore
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('execution_dates').doc(user!.email).get();
    if (snapshot.exists) {
      DateTime lastExecutionDate = (snapshot.data() as Map)['date'].toDate();
      Duration difference = now.difference(lastExecutionDate);
      if (difference.inDays >= 7) {
        await FirebaseFirestore.instance.collection('MealProgress').doc(user.email).delete();
        await FirebaseFirestore.instance.collection('WorkoutProgress').doc(user.email).delete();
        await FirebaseFirestore.instance.collection('execution_dates').doc(user.email).set({
          'date': now,
        });
        if (kDebugMode) {
          print('Document with ID 123 deleted because 7 days have passed since the last execution.');
        }
      } else {
        if (kDebugMode) {
          print('It has not been 7 days since the last execution. No action taken.');
        }
      }
      fetchWeeklyProgress();
    } else {
      // If the document doesn't exist, create it with the current date
      await FirebaseFirestore.instance.collection('execution_dates').doc(user.email).set({
        'date': now,
      });
      if (kDebugMode) {
        print('First time execution. Document with ID 123 not deleted.');
      }
    }
  }
}
