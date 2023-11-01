import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HealthController with ChangeNotifier {
  // final TextEditingController healthController = TextEditingController();
 // final HealthController healthController = HealthController();
  final user = FirebaseAuth.instance.currentUser;

 // bool _isLoading = false;
  List<String> selectedHealthIssues = [];
  bool cardiovascularConditions = false;
  bool jointProblems = false;
  bool diabetes = false;


  // void _updateDisease() {
  //   selectedHealthIssues = [];
  //   if (cardiovascularConditions) selectedHealthIssues.add('Cardiovascular Conditions');
  //   if (jointProblems) selectedHealthIssues.add('Joint Problems');
  //   if (diabetes) selectedHealthIssues.add('Diabetes');
  // }

  // Future<void> _saveHealthDetails() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     final healthData = {
  //       'disease': selectedHealthIssues,
  //     };
  //
  //     await FirebaseFirestore.instance
  //         .collection('UserHealthCollection')
  //         .doc(user!.uid)
  //         .update(healthData);
  //
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  Future<void> userHealthStatusDialogAlert(
      BuildContext context,
      List<String> initialHealthStatus,
      ) {
    List<String> selectedHealthStatus = List.from(initialHealthStatus);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Medical Conditions'),
          content: Column(
            children: [
              CheckboxListTile(
                title: const Text('Cardiovascular Conditions'),
                value: selectedHealthStatus.contains('Cardiovascular Conditions'),
                onChanged: (value) {
                  if (value!) {
                    selectedHealthStatus.add('Cardiovascular Conditions');
                  } else {
                    selectedHealthStatus.remove('Cardiovascular Conditions');
                  }
                  notifyListeners();
                },
              ),
              CheckboxListTile(
                title: const Text('Joint Problems'),
                value: selectedHealthStatus.contains('Joint Problems'),
                onChanged: (value) {
                  if (value!) {
                    selectedHealthStatus.add('Joint Problems');
                  } else {
                    selectedHealthStatus.remove('Joint Problems');
                  }
                  notifyListeners();
                },
              ),
              CheckboxListTile(
                title: const Text('Diabetes'),
                value: selectedHealthStatus.contains('Diabetes'),
                onChanged: (value) {
                  if (value!) {
                    selectedHealthStatus.add('Diabetes');
                  } else {
                    selectedHealthStatus.remove('Diabetes');
                  }
                  notifyListeners();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('UserHealthCollection')
                    .doc(user!.uid)
                    .update({
                  'disease': selectedHealthStatus,
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
