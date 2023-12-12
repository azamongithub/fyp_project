import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../routes/route_name.dart';

class LoginController with ChangeNotifier {
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
      //authCredential!.uid;
      if (authCredential!.uid.isNotEmpty) {
        setLoading(false);
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.bottomNavBar,
              (route) => false,
        );
      } else {
        setLoading(false);
        Fluttertoast.showToast(msg: "Something is wrong");
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
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}
