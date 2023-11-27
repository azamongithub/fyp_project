import 'dart:async';
import 'package:CoachBot/view_model/services/shared_preferences_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/route_name.dart';
import 'session_controller.dart';


class SplashServices {
  Future<void> isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      SessionController().userId = user.uid.toString();

      if (!await SharedPreferencesHelper.isProfileCompleted()) {
        Navigator.pushReplacementNamed(context, RouteName.ProfileForm);
        return;
      }

      if (!await SharedPreferencesHelper.isFitnessCompleted()) {
        Navigator.pushReplacementNamed(context, RouteName.FitnessAnalyzerForm);
        return;
      }

      if (!await SharedPreferencesHelper.isHealthCompleted()) {
        Navigator.pushReplacementNamed(context, RouteName.HealthStatusForm);
        return;
      }

      Navigator.pushReplacementNamed(context, RouteName.BottomNavBar);
    } else {
      Timer(const Duration(seconds: 2),
              () => Navigator.pushReplacementNamed(context, RouteName.LoginForm));
    }
  }
}