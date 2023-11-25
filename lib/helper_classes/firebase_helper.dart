import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

void addUserDataToFirestore(UserModel user) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    String userId = currentUser.uid;

    CollectionReference userCollection =
    FirebaseFirestore.instance.collection('usersCollection');

    await userCollection.doc(userId).set({
      'id': user!.id,
      'email': user!.email,
      'name': user!.name,
      'age': user!.age,
      'gender': user!.gender,
      'weight': user!.weight,
      'height': user!.height,
      'calories': user!.calories,
      'workoutName': user!.workoutName,
      'fitnessGoal': user!.fitnessGoal,
      'disease': user!.disease,
    });
  } else {
    // Handle the case where the user is not authenticated
    //Fluttertoast();
    print('User not authenticated.');
  }
}

