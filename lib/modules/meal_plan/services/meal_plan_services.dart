import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/utils.dart';

class MealPlanServices{

  static Future<void> addProgress(String day) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final mealProgressRef =
      FirebaseFirestore.instance.collection('MealProgress').doc(user.email);
      try {
        DocumentSnapshot progressSnapshot = await mealProgressRef.get();
        Map<String, dynamic>? dayData = progressSnapshot.exists
            ? progressSnapshot.data() as Map<String, dynamic>?
            : null;
        int currentProgress = progressSnapshot.exists
            ? progressSnapshot['totalProgress'] ?? 0
            : 0;
        if (dayData == null || !dayData.containsKey(day)) {
          dayData ??= {};
          dayData[day] = FieldValue.serverTimestamp();
          await mealProgressRef.set({
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
