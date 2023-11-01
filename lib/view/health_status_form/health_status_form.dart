import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HealthStatusForm extends StatefulWidget {
  const HealthStatusForm({super.key});

  @override
  _HealthStatusFormState createState() => _HealthStatusFormState();
}

class _HealthStatusFormState extends State<HealthStatusForm> {
  //List<String> _options = [];
  // bool _optionA = false;
  // bool _optionB = false;
  // bool _optionC = false;

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  List<String> selectedHealthIssues = [];


  bool cardiovascularConditions = false;
  bool jointProblems = false;
  bool diabetes = false;


  void _updateDisease() {
    selectedHealthIssues = [];
    if (cardiovascularConditions) selectedHealthIssues.add('Cardiovascular Conditions');
    if (jointProblems) selectedHealthIssues.add('Joint Problems');
    if (diabetes) selectedHealthIssues.add('Diabetes');
  }

  Future<void> _saveHealthDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final healthData = {
        'email': user!.email,
        'disease': selectedHealthIssues,
      };

      await FirebaseFirestore.instance
          .collection('UserHealthCollection')
          .doc(user!.uid)
          .set(healthData);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => BottomNavBar()),
      // );
      Navigator.pushNamed(context, RouteName.BottomNavBar);
    } catch (e) {
      print(e.toString());
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Any Medical Conditions'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CheckboxListTile(
              title: Text('Cardiovascular Conditions'),
              value: cardiovascularConditions,
              onChanged: (value) {
                setState(() {
                  cardiovascularConditions = value!;
                  _updateDisease();
                });
              },
            ),
            CheckboxListTile(
              title: Text('Joint Problems'),
              value: jointProblems,
              onChanged: (value) {
                setState(() {
                  jointProblems = value!;
                  _updateDisease();
                });
              },
            ),
            CheckboxListTile(
              title: Text('Diabetes'),
              value: diabetes,
              onChanged: (value) {
                setState(() {
                  diabetes = value!;
                  _updateDisease();
                });
              },
            ),
            SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: _saveHealthDetails,
            //   child: Text('Next'),
            // ),
            // RoundButton(
            //   title: 'Continue',
            //   loading: loading,
            //   onTap: () {
            //       _saveHealthDetails();
            //
            //   },
            // ),
            CustomButton(
              title: 'Continue',
              loading: _isLoading,
              onTap: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _saveHealthDetails();
              },
            )
          ],
        ),
      ),
    );
  }
}
