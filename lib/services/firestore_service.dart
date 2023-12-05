import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUserId() async {
    final user = _auth.currentUser;
    return user?.uid ?? '';
  }

  Future<void> storeUserData(Map<String, dynamic> data) async {
    try {
      final userId = await getCurrentUserId();
      if (userId.isNotEmpty) {
        // Use SetOptions(merge: true) to merge the new data with existing data
        await _firestore.collection('UserDataCollection').doc(userId).set(data, SetOptions(merge: true));
      } else {
        throw Exception('User not authenticated');
      }
    } catch (e) {
      print('Error storing data: $e');
      throw Exception('Failed to store data');
    }
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<String> getCurrentUserId() async {
//     final user = _auth.currentUser;
//     return user?.uid ?? '';
//   }
//
//   Future<void> storeUserData(Map<String, dynamic> data) async {
//     try {
//       final userId = await getCurrentUserId();
//       if (userId.isNotEmpty) {
//         await _firestore.collection('AllUserCollection').doc(userId).set(data);
//       } else {
//         throw Exception('User not authenticated');
//       }
//     } catch (e) {
//       print('Error storing data: $e');
//       throw Exception('Failed to store data');
//     }
//   }
// }
