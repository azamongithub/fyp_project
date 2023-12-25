import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controller/session_controller.dart';
import '../../../../routes/route_name.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      SessionController().userId = user.uid.toString();
      Timer(
          const Duration(seconds: 2),
          () =>
              Navigator.pushReplacementNamed(context, RouteName.bottomNavBar));
    } else {
      Timer(const Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, RouteName.loginForm));
    }
  }
}
