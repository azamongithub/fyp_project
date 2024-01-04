import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWorkout({
    required String workoutName,
    required String youtubeLink,
    required List<String> steps,
    required String time,
    required int reps,
    required String difficultyLevel,
    required List<String> equipments,
    required String instructions,
  }) async {
    try {
      await _firestore.collection('WorkoutsDetails').add({
        'workoutName': workoutName,
        'youtubeLink': youtubeLink,
        'steps': steps,
        'time': time,
        'reps': reps,
        'difficultyLevel': difficultyLevel,
        'equipments': equipments,
        'instructions': instructions,
      });
    } catch (e) {
      print('Error adding workout: $e');
    }
  }
}
