import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../res/component/password_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _currentPasswordError = '';
  String _newPasswordError = '';
  String _confirmPasswordError = '';

  Future<void> _changePassword(BuildContext context) async {
    final String currentPassword = _currentPasswordController.text.trim();
    final String newPassword = _newPasswordController.text.trim();
    final String? confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _currentPasswordError = '';
      _newPasswordError = '';
      _confirmPasswordError = '';
    });

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(
              email: user.email!, password: currentPassword!);
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(newPassword!);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Password Changed'),
                content:
                    const Text('Your password has been changed successfully.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print('Error: $e');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            if (_currentPasswordController.text !=
                _currentPasswordController.text) {
              Utils.negativeToastMessage('Incorrecr Current Password');
            }
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('An error occurred. Please try again later.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
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
        title: const Text('Change Password'),
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
                  labelText: 'Current Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your current password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                PasswordTextField(
                  controller: _newPasswordController,
                  labelText: 'New Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your New password.';
                    } else if (_currentPasswordController.text ==
                        _newPasswordController.text) {
                      return 'New password should not same as Current Password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                PasswordTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your new password.';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                CustomButton(
                    title: 'Change Password',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _changePassword(context);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
