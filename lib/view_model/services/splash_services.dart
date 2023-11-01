import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/component/bottom_nav_bar.dart';
import '../../view/login/login_screen.dart';
import 'session_controller.dart';

class SplashServices {

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null) {
      SessionController().userId = user.uid.toString();
      Timer(const Duration(seconds: 2),()=>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>
              const BottomNavBar())));

    }
    else {
      Timer(const Duration(seconds: 2),()=>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>
                  const LoginForm())));
    }


  }
}