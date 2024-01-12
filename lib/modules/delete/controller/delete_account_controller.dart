// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../routes/route_name.dart';
import '../../../utils/utils.dart';

class DeleteAccountController extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void deleteAccount(BuildContext context) async {
    isLoading = true;
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: passwordController.text,
        );
        await user.reauthenticateWithCredential(credential);
        final setDelete = {'accountDeleted': true};
        await FirebaseFirestore.instance
            .collection('UserDataCollection')
            .doc(user.uid)
            .set(setDelete, SetOptions(merge: true));
        await user.delete();
        await FirebaseAuth.instance.signOut();
        await FirebaseFirestore.instance.terminate();
        Navigator.pushReplacementNamed(context, RouteName.loginForm);
        Utils.showLoadingSnackBar(context, 'Your Account has been deleted');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        isLoading = false;
        Utils.showLoadingSnackBar(context, 'Incorrect Current Password');
      } else if (e.code == 'too-many-requests') {
        isLoading = false;
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
      isLoading = false;
      print(e);
    }
  }
}
