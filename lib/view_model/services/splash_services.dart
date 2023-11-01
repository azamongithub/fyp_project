import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/route_name.dart';
import 'session_controller.dart';

class SplashServices {

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null) {
      SessionController().userId = user.uid.toString();
      Timer(const Duration(seconds: 2),()=>
      Navigator.pushReplacementNamed(context, RouteName.BottomNavBar));
    }
    else {
      Timer(const Duration(seconds: 2),()=>
          Navigator.pushReplacementNamed(context, RouteName.LoginForm));
    }
  }
}