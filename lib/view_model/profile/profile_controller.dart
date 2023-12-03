// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../res/component/custom_text_field.dart';
// import '../../utils/utils.dart';
//
// class ProfileController with ChangeNotifier {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController dateOfBirthController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   String? _selectedValue;
//   String? ageGroup;
//   late DateTime _selectedDate;
//
//   final user = FirebaseAuth.instance.currentUser;
//
//   void _onDateSelected(DateTime? date) {
//     if (date != null) {
//       _selectedDate = date;
//     }
//   }
//
//   int calculateAge(DateTime dateOfBirth) {
//     DateTime currentDate = DateTime.now();
//
//     int age = currentDate.year - dateOfBirth.year;
//
//     if (currentDate.month < dateOfBirth.month ||
//         (currentDate.month == dateOfBirth.month &&
//             currentDate.day < dateOfBirth.day)) {
//       age--;
//     }
//     return age;
//   }
//
//   void findAgeGroup(int age) {
//     if (age > 15 && age < 20) {
//       ageGroup = 'Teenager';
//     } else if (age > 19 && age < 30) {
//       ageGroup = 'Young Adult';
//     } else if (age > 29 && age < 55) {
//       ageGroup = 'Middle Aged Adult';
//     } else if (age > 54) {
//       ageGroup = 'Older Adult';
//     } else {
//       ageGroup = 'You are NOT Eligible for any exercise';
//     }
//   }
//
//   Future<void> userNameDialogAlert(BuildContext context, String name) {
//     nameController.text = name;
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Update Name'),
//             content: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Form(
//                     key: _formKey,
//                     child: CustomTextField(
//                       myController: nameController,
//                       keyBoardType: TextInputType.name,
//                       labelText: 'Name',
//                       onValidator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your name.';
//                         }
//                         return null;
//                       },
//                     ),
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
//                     if (_formKey.currentState!.validate()) {
//                       FirebaseFirestore.instance
//                           .collection('UserProfileCollection')
//                           .doc(user!.uid)
//                           .update({
//                         'name': nameController.text.toString(),
//                       }).then((value) {
//                         nameController.clear();
//                       });
//                       Navigator.pop(context);
//                       Utils.positiveToastMessage('Name updated successfully');
//                     }
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
//   Future<void> userDateOfBirthDialogAlert(
//       BuildContext context, String dateOfBirth) {
//     final TextEditingController dateController =
//     TextEditingController(text: dateOfBirth);
//
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Update Date of Birth'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     final DateTime? selectedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.parse(dateController.text),
//                       firstDate: DateTime(1933, 1, 1),
//                       lastDate: DateTime(2007, 1, 1),
//                     );
//
//                     if (selectedDate != null) {
//                       dateController.text =
//                           DateFormat('yyyy-MM-dd').format(selectedDate);
//
//                       // Update the age and age group
//                       int age = calculateAge(selectedDate);
//                       ageController.text = age.toString();
//                       findAgeGroup(age);
//                     }
//                   },
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       controller: dateController,
//                       decoration: const InputDecoration(
//                         labelText: 'Date of Birth',
//                         suffixIcon: Icon(Icons.calendar_today),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please select a date of birth';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
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
//                 final String newDateOfBirth = dateController.text;
//
//                 FirebaseFirestore.instance
//                     .collection('UserProfileCollection')
//                     .doc(user!.uid)
//                     .update({
//                   'dateOfBirth': newDateOfBirth,
//                   'age': ageController.text,
//                   'ageGroup': ageGroup,
//                 }).then((value) {
//                   Utils.positiveToastMessage('Date of Birth updated successfully');
//
//                   Navigator.pop(context);
//                 }).catchError((error) {
//                   Utils.negativeToastMessage('Failed to update Date of Birth');
//                 });
//               },
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
//
//   Future<void> userGenderDialogAlert(
//       BuildContext context, String? initialGender,
//       {String? gender}) {
//     _selectedValue = initialGender;
//
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Update Gender'),
//           content: DropdownButtonFormField<String>(
//             decoration: const InputDecoration(
//               labelText: 'Select Gender',
//             ),
//             value: _selectedValue,
//             onChanged: (newValue) {
//               _selectedValue = newValue;
//               notifyListeners();
//             },
//             items: [
//               const DropdownMenuItem<String>(
//                 value: 'Male',
//                 child: Text('Male'),
//               ),
//               const DropdownMenuItem<String>(
//                 value: 'Female',
//                 child: Text('Female'),
//               ),
//             ],
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select your Gender';
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
//                     .collection('UserProfileCollection')
//                     .doc(user!.uid)
//                     .update({
//                   'gender': _selectedValue,
//                 });
//                 Navigator.pop(context);
//               },
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
