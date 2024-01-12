// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../splash/firebase_service.dart';

class LoginController with ChangeNotifier {
  FirebaseService firebaseService = FirebaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  login(BuildContext context, String email, String password) async {
    setLoading(true);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var authCredential = userCredential.user;
      if (authCredential!.emailVerified) {
        setLoading(true);
        firebaseService.checkFormsFilled(context, authCredential.uid);
      } else {
        await authCredential.sendEmailVerification();
        setLoading(false);
        Fluttertoast.showToast(
          msg: "Please verify your email before logging in.",
        );
        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setLoading(false);
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        setLoading(false);
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
      else if (!emailRegex.hasMatch(email)) {
        setLoading(false);
        Fluttertoast.showToast(msg: "Invalid email format");
      }
      else if(e.code == 'too-many-requests'){
        setLoading(false);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: const Text('Warning'),
              content: const Text(
                  'We have blocked all requests from this device due to unusual activity. Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                )
              ]),
        );
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}
