import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../routes/route_name.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  bool _acceptPrivacyPolicyAndTermsAndConditions = false;

  bool get acceptPrivacyPolicyAndTermsAndConditions => _acceptPrivacyPolicyAndTermsAndConditions;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context, String email, String password) async {
    setLoading(true);
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var authCredential = userCredential.user;
      final userAccountInfo = {
        'id': authCredential!.uid,
        'email': email,
        'joiningDate': DateTime.now(),
      };
      print(authCredential.uid);
      //Navigator.pushReplacementNamed(context, RouteName.profileForm);
      await authCredential.sendEmailVerification();
      await FirebaseFirestore.instance
          .collection('UserDataCollection')
          .doc(authCredential.uid)
          .set(userAccountInfo , SetOptions(merge: true));
      await FirebaseAuth.instance.signOut();

      setLoading(false);
      Fluttertoast.showToast(msg: "Account created successfully. Please check your email for verification.");
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.");
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (!emailRegex.hasMatch(email)) {
        Fluttertoast.showToast(msg: "Invalid email format");
      } else {
        Fluttertoast.showToast(msg: "An error occurred: ${e.message}");
      }
    } catch (e) {
      setLoading(false);
      Fluttertoast.showToast(msg: "Something went wrong");
      if (kDebugMode) {
        print(e);
      }
    }
  }


  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    try {

      final GoogleSignInAccount? googleSignInAccount =
      await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final userAccountInfo = {
          'id': googleSignInAccount.id,
          'email': googleSignInAccount.email,
          'joiningDate': DateTime.now(),
        };
        await FirebaseFirestore.instance
            .collection('UserDataCollection')
            .doc(user!.uid)
            .set(userAccountInfo , SetOptions(merge: true));
        setLoading(false);
        Fluttertoast.showToast(msg: "Your Account Created Successfully");
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.profileForm,
              (route) => false,
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e, stack) {
      print("Error signing in with Google: $e  : $stack");
      return null;
    }
  }

  void setAcceptPrivacyPolicyAndTermsAndConditions(bool value) {
    _acceptPrivacyPolicyAndTermsAndConditions = value;
    notifyListeners();
  }
}
