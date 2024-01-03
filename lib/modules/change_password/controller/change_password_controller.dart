import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../utils/utils.dart';

class ChangePasswordController extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


  changePassword(BuildContext context,String currentPassword, String newPassword) async {
    setLoading(true);
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: currentPassword,
          );
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(newPassword);
          setLoading(false);
          Utils.positiveToastMessage('Password changed successfully');
          Navigator.pop(context);
        }
      } catch (e) {
        print('Error: $e');
        if (e is FirebaseAuthException && e.code == 'wrong-password') {
          Utils.negativeToastMessage('Incorrect Current Password');
        } else {
          Utils.positiveToastMessage(
              'We have blocked all requests from this device due to unusual activity. Try again later.');
        }
        setLoading(false);
      }
  }
}