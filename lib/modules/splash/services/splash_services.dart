import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/session_controller.dart';
import '../../../../routes/route_name.dart';
import '../firebase_service.dart';

class SplashServices {
  FirebaseService firebaseService = FirebaseService();
  void isLogin(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      SessionController().userId = user.uid.toString();
      //Navigator.pushReplacementNamed(context, RouteName.bottomNavBar);
      firebaseService.checkFormsFilled(context, user.uid);
    } else {
      Timer(const Duration(seconds: 2),
              () => Navigator.pushReplacementNamed(context, RouteName.loginForm));
    }
  }



}





// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../controller/session_controller.dart';
// import '../../../../routes/route_name.dart';
//
// class SplashServices {
//   void isLogin(BuildContext context) {
//     final auth = FirebaseAuth.instance;
//     final user = auth.currentUser;
//
//     if (user != null) {
//       SessionController().userId = user.uid.toString();
//       Timer(
//           const Duration(seconds: 2),
//           () =>
//               Navigator.pushReplacementNamed(context, RouteName.bottomNavBar));
//     } else {
//       Timer(const Duration(seconds: 2),
//           () => Navigator.pushReplacementNamed(context, RouteName.loginForm));
//     }
//   }
// }
