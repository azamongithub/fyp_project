import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../view_model/services/shared_preferences_helper.dart';

class HealthFormController extends ChangeNotifier {
  bool isLoading = false;
  String? selectedDisease;

  bool _isHealthCompleted = false;

  // Other health-related state or methods

  bool get isHealthCompleted => _isHealthCompleted;

  void setHealthCompleted() {
    _isHealthCompleted = true;
    notifyListeners();
  }

  void setSelectedDisease(String value) {
    selectedDisease = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> saveHealthDetails(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final healthData = {
        //'email': user!.email,
        'disease': selectedDisease,
      };

      await FirebaseFirestore.instance
          .collection('UserHealthCollection')
          .doc(user!.uid)
          .set(healthData);
      // setHealthCompleted();
      await SharedPreferencesHelper.setHealthCompleted(true);

    } catch (e) {
      print(e.toString());
    } finally {
      setIsLoading(false);
    }
  }
}
