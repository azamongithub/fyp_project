// import 'package:CoachBot/res/component/input_text_field.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import '../../utils/utils.dart';
//
// class FitnessController with ChangeNotifier {
//   final TextEditingController heightController = TextEditingController();
//   final TextEditingController weightController = TextEditingController();
//   String? _selectedValue;
//
//
//
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _caloriesController = TextEditingController();
//   final TextEditingController _workoutController = TextEditingController();
//   final List<String> _fitnessGoal = ['Muscle Building', 'Weight Gain', 'Weight Loss'];
//   String? _selectedFitnessGoal;
//
//   List<int> feetOptions = [3, 4, 5, 6, 7, 8];
//   List<int> inchesOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
//   int selectedFeet = 4;
//   int selectedInch = 9;
//   double bmi = 0;
//   bool _isLoading = false;
//   String? bmiCategory;
//
//
//
//   final user = FirebaseAuth.instance.currentUser;
//
//   void _updateWeight(BuildContext context) async {
//     final double newWeight = double.tryParse(weightController.text) ?? 0.0;
//
//     if (newWeight > 24 && newWeight < 500) {
//       FirebaseFirestore.instance
//           .collection('UserFitnessCollection')
//           .doc(user!.uid)
//           .update({
//         'weight': weightController.text.toString(),
//       }).then((value) {
//         weightController.clear();
//       });
//       Utils.positiveToastMessage('Weight updated successfully');
//       Navigator.pop(context);
//     } else {
//       Utils.negativeToastMessage('Please enter a valid weight.');
//     }
//   }
//
//   void _updateHeight(BuildContext context) async {
//     final double newHeight = double.tryParse(heightController.text) ?? 0.0;
//
//     if (newHeight > 50 && newHeight < 280) {
//       FirebaseFirestore.instance
//           .collection('UserFitnessCollection')
//           .doc(user!.uid)
//           .update({
//         'height': heightController.text.toString(),
//       }).then((value) {
//         heightController.clear();
//       });
//       Utils.positiveToastMessage('Height updated successfully');
//
//       Navigator.pop(context);
//     } else {
//       Utils.negativeToastMessage('Please enter a valid height.');
//     }
//   }
//
//   Future<void> userHeightDialogAlert(BuildContext context, String height) {
//     heightController.text = height;
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Update Height(cm)'),
//             content: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   CustomTextField(
//                     myController: heightController,
//                     keyBoardType: TextInputType.number,
//                     labelText: 'Height',
//                     onValidator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your height.';
//                       }
//                       double? height = double.tryParse(value);
//                       if (height == null || height < 50 || height > 280) {
//                         return 'Please enter a valid height.';
//                       }
//                       return null;
//                     },
//                   )
//                 ],
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//               TextButton(
//                   onPressed: () {
//                     _updateHeight(context);
//                   },
//                   child: const Text(
//                     'Save',
//                     style: TextStyle(
//                       color: Colors.green,
//                     ),
//                   ))
//             ],
//           );
//         });
//   }
//
//   Future<void> userWeightDialogAlert(BuildContext context, String weight) {
//     weightController.text = weight;
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Update Weight(kg)'),
//             content: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   CustomTextField(
//                       myController: weightController,
//                       keyBoardType: TextInputType.number,
//                       labelText: 'Weight',
//                       onValidator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your weight.';
//                         }
//                         double? weight = double.tryParse(value);
//                         if (weight == null || weight < 10 || weight > 500) {
//                           return 'Please enter a valid weight.';
//                         }
//                         return null;
//                       })
//                 ],
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//               TextButton(
//                   onPressed: () {
//                     _updateWeight(context);
//                   },
//                   child: const Text(
//                     'Save',
//                     style: TextStyle(
//                       color: Colors.green,
//                     ),
//                   ))
//             ],
//           );
//         });
//   }
//
//   Future<void> userFitnessGoalDialogAlert(
//       BuildContext context, String? initialFitnessGoal,
//       {String? gender}) {
//     _selectedValue = initialFitnessGoal;
//
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Update Fitness Goal'),
//           content: DropdownButtonFormField<String>(
//             decoration: const InputDecoration(
//               labelText: 'Select Fitness Goal',
//             ),
//             value: _selectedValue,
//             onChanged: (newValue) {
//               _selectedValue = newValue;
//               notifyListeners();
//             },
//             items: const [
//               DropdownMenuItem<String>(
//                 value: 'muscleBuilding',
//                 child: Text('Muscle Building'),
//               ),
//               DropdownMenuItem<String>(
//                 value: 'weightGain',
//                 child: Text('Weight Gain'),
//               ),
//               DropdownMenuItem<String>(
//                 value: 'weightLoss',
//                 child: Text('Weight Loss'),
//               ),
//             ],
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select your fitness goal.';
//               }
//               return null;
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 FirebaseFirestore.instance
//                     .collection('UserFitnessCollection')
//                     .doc(user!.uid)
//                     .update({
//                   'fitnessGoal': _selectedValue,
//                 });
//
//                 Navigator.pop(context);
//                 Utils.positiveToastMessage('Fitness Goal updated successfully');
//               },
//
//               child: const Text(
//                 'Save',
//                 style: TextStyle(
//                   color: Colors.green,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
