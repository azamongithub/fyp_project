import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../../routes/route_name.dart';

class FirebaseService {

  Future<void> checkFormsFilled(BuildContext context, String userId) async {
    try {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('UserDataCollection').doc(userId).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      // if (!userDoc.exists) {
      //   Navigator.pushReplacementNamed(context, RouteName.profileForm);
      // }

      if (!userData.containsKey('name')) {
        Navigator.pushReplacementNamed(context, RouteName.profileForm);
      }
      else if (!userData.containsKey('weight')) {
        Navigator.pushReplacementNamed(context, RouteName.fitnessAnalyzerForm);
      }
      else if (!userData.containsKey('fitnessGoal')) {
        Navigator.pushReplacementNamed(context, RouteName.fitnessGoalForm);
      }
      else if (!userData.containsKey('disease')) {
        Navigator.pushReplacementNamed(context, RouteName.healthStatusForm);
      }
      else {
        Navigator.pushReplacementNamed(context, RouteName.bottomNavBar);

      }
    } catch (error) {
      print('Error checking forms in Firestore: $error');
      // Handle errors if needed
    }
  }

}