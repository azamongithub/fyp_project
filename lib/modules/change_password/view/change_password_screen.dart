import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:CoachBot/utils/utils.dart';
import '../../../common_components/custom_button.dart';
import '../../../common_components/password_text_field.dart';
import '../../../theme/text_style_util.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _changePassword(BuildContext context) async {
    final String currentPassword = _currentPasswordController.text.trim();
    final String newPassword = _newPasswordController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: currentPassword,
          );
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(newPassword);
          Utils.positiveToastMessage('Password changed successfully');
          Navigator.pop(context);
        }
      } catch (e) {
        print('Error: $e');

        if (e is FirebaseAuthException && e.code == 'wrong-password') {
          Utils.negativeToastMessage('Incorrect Current Password');
        } else {
          Utils.positiveToastMessage('We have blocked all requests from this device due to unusual activity. Try again later.');

        }
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(AppStrings.changePassBtn, style: CustomTextStyle.appBarStyle()),
        backgroundColor: const Color(0xff3140b0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16.0),
                PasswordTextField(
                  controller: _currentPasswordController,
                  labelText: AppStrings.currentPassLabel,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return AppStrings.enterCurrentPass;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                PasswordTextField(
                  controller: _newPasswordController,
                  labelText: AppStrings.newPassLabel,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return AppStrings.enterNewPass;
                    } else if (_currentPasswordController.text == _newPasswordController.text) {
                      return AppStrings.newPassNotEqualCurrentPass;
                    } else if (value!.length < 6) {
                      return AppStrings.passValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                PasswordTextField(
                  controller: _confirmPasswordController,
                  labelText: AppStrings.confirmPassLabel,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return AppStrings.confirmNewPass;
                    }
                    if (value != _newPasswordController.text) {
                      return AppStrings.passNotMatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                CustomButton(
                  title: AppStrings.changePassBtn,
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _changePassword(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// import 'package:CoachBot/res/component/custom_button.dart';
// import 'package:CoachBot/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../res/component/password_text_field.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});
//
//   @override
//   _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final TextEditingController _currentPasswordController =
//       TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//
//   Future<void> _changePassword(BuildContext context) async {
//     final String currentPassword = _currentPasswordController.text.trim();
//     final String newPassword = _newPasswordController.text.trim();
//
//     if (_formKey.currentState != null && _formKey.currentState!.validate()) {
//       try {
//         User? user = FirebaseAuth.instance.currentUser;
//         if (user != null) {
//           AuthCredential credential = EmailAuthProvider.credential(
//               email: user.email!, password: currentPassword!);
//           await user.reauthenticateWithCredential(credential);
//           await user.updatePassword(newPassword!);
//
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return  AlertDialog(
//                 title: const Text('Password Changed'),
//                 content:
//                     const Text('Your password has been changed successfully.'),
//                 actions: <Widget>[
//                   TextButton(
//                     child: const Text('OK'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       } catch (e) {
//         print('Error: $e');
//
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             if (_currentPasswordController.text !=
//                 _currentPasswordController.text) {
//               Utils.negativeToastMessage('Incorrect Current Password');
//             }
//             return  AlertDialog(
//               title: const Text('Error'),
//               content:
//               const Text('An error occurred. Please try again later.'),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//
//             // return Utils.negativeToastMessage('An error occurred. Please try again later.');
//           },
//         );
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Change Password'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const SizedBox(height: 16.0),
//                 PasswordTextField(
//                   controller: _currentPasswordController,
//                   labelText: 'Current Password',
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your current password.';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 25.0),
//                 PasswordTextField(
//                   controller: _newPasswordController,
//                   labelText: 'New Password',
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your New password.';
//                     } else if (_currentPasswordController.text ==
//                         _newPasswordController.text) {
//                       return 'New password should not same as Current Password';
//                     } else if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 25.0),
//                 PasswordTextField(
//                   controller: _confirmPasswordController,
//                   labelText: 'Confirm Password',
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please confirm your new password.';
//                     }
//                     if (value != _newPasswordController.text) {
//                       return 'Passwords do not match.';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 25.0),
//                 CustomButton(
//                     title: 'Change Password',
//                     onTap: () {
//                       if (_formKey.currentState!.validate()) {
//                         _changePassword(context);
//                       }
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
