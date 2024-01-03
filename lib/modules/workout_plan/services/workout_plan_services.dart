import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/utils.dart';

class WorkoutPlanServices{

  static Future<void> addProgress(String day) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final workoutProgressRef = FirebaseFirestore.instance
          .collection('WorkoutProgress')
          .doc(user.email);
      try {
        DocumentSnapshot progressSnapshot = await workoutProgressRef.get();
        Map<String, dynamic>? dayData = progressSnapshot.exists
            ? progressSnapshot.data() as Map<String, dynamic>?
            : null;
        int currentProgress = progressSnapshot.exists
            ? progressSnapshot['totalProgress'] ?? 0
            : 0;
        if (dayData == null || !dayData.containsKey(day)) {
          // Create the day field dynamically
          dayData ??= {};
          dayData[day] = FieldValue.serverTimestamp();
          await workoutProgressRef.set({
            'totalProgress': currentProgress + 1,
            ...dayData,
          });
          Utils.positiveToastMessage('Progress for $day has added.');
          if (kDebugMode) {
            print('Progress for $day added.');
          }
        } else {
          Utils.positiveToastMessage('Progress for $day has already added.');
          if (kDebugMode) {
            print('Progress for $day already added.');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error updating progress: $e');
        }
      }
    }
  }
}
