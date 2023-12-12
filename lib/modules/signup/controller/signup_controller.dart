import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../routes/route_name.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  signUp(BuildContext context, String email, String password) async {
    setLoading(true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        setLoading(false);
        Fluttertoast.showToast(msg: "Your Account Created Successfully");

        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.profileForm,
              (route) => false,
        );


        // Navigator.pushReplacementNamed(context, RouteName.ProfileForm);
      } else {
        setLoading(false);
        Fluttertoast.showToast(msg: "Something is wrong");
        setLoading(false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setLoading(false);
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
        setLoading(false);
      }
      else if (e.code == 'weak-password') {
        setLoading(false);
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      }
      else if (!emailRegex.hasMatch(email)) {
        setLoading(false);
        Fluttertoast.showToast(
            msg: "Invalid email format");
    }
      else {
        Fluttertoast.showToast(
            msg: "An error occurred: ${e.message}");
      }
    } catch (e) {
      setLoading(false);
      Fluttertoast.showToast(

          msg: "Some thing went wrong");
      print(e);
    }
  }
}
