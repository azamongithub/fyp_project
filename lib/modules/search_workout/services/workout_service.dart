import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWorkout({
    required String workoutName,
    required String gifImageLink,
    required List<String> steps,
    required String difficultyLevel,
    required List<String> equipments,
    required List<String> primaryMuscles,
    required List<String> secondaryMuscles,
    required String instructions,
    required List<String> commonMistakes,
  }) async {
    try {
      await _firestore.collection('WorkoutsDetails').doc(workoutName).set({
        'workoutName': workoutName,
        'gifImageLink': gifImageLink,
        'primaryMuscles' : primaryMuscles,
        'secondaryMuscles' : secondaryMuscles,
        'steps': steps,
        'difficultyLevel': difficultyLevel,
        'equipments': equipments,
        'instructions': instructions,
        'commonMistakes': commonMistakes,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error adding workout: $e');
      }
    }
  }
}
