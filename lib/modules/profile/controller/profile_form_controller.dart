import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../services/shared_preferences_helper.dart';
import '../../../routes/route_name.dart';

class ProfileFormController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  String selectedGender = '';
  String? nameError;
  String? dateOfBirthError;
  String? genderError;
  late DateTime selectedDate;

  bool _isProfileCompleted = false;
  bool get isProfileCompleted => _isProfileCompleted;

  RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]{1,50}$');

  void setSelectedGender(String gender) {
    selectedGender = gender;
    genderError = null;
    notifyListeners();
  }

  void onDateSelected(DateTime? date) {
    if (date != null) {
      selectedDate = date;
    }
  }

  int calculateAge(DateTime dateOfBirth) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dateOfBirth.year;

    if (currentDate.month < dateOfBirth.month ||
        (currentDate.month == dateOfBirth.month &&
            currentDate.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  String findAgeGroup() {
    int age = calculateAge(selectedDate);

    if (age >= 13 && age <= 19) {
      return AppStrings.teenager;
    } else if (age >= 20 && age <= 29) {
      return AppStrings.youngAdult;
    } else if (age >= 30 && age <= 54) {
      return AppStrings.middleAgedAdult;
    } else if (age >= 55) {
      return AppStrings.olderAdult;
    } else {
      return AppStrings.ageGroupNotDefined;
    }
  }

  Future<void> saveProfileDetails(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      int age = calculateAge(selectedDate);
      String ageGroup = findAgeGroup();
      final profileData = {
        'id': user!.uid,
        'name': nameController.text,
        'age': age.toString(),
        'dateOfBirth': dateOfBirthController.text,
        'ageGroup': ageGroup,
        'gender': selectedGender,
        'email': user.email,
      };
      isLoading = true;
      notifyListeners();

      await FirebaseFirestore.instance.collection('UserDataCollection').doc(user.uid).set(profileData, SetOptions(merge: true));

      // await FirebaseFirestore.instance
      //     .collection('UserProfileCollection')
      //     .doc(user.uid)
      //     .set(profileData);

      await SharedPreferencesHelper.setProfileCompleted(true);
      Navigator.pushNamed(context, RouteName.fitnessAnalyzerForm);

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setProfileCompleted() {
    _isProfileCompleted = true;
    notifyListeners();
  }


  // //For Update Profile
  // Future<void> userNameDialogAlert(BuildContext context, String name) {
  //   nameController.text = name;
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Update Name'),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 Form(
  //                   key: formKey,
  //                   child: CustomTextField(
  //                     myController: nameController,
  //                     keyBoardType: TextInputType.name,
  //                     labelText: 'Name',
  //                     onValidator: (value) {
  //                       if (value!.isEmpty) {
  //                         return 'Please enter your name.';
  //                       }
  //                       return null;
  //                     },
  //                   ),
  //                 )
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
  //                 onPressed: () {
  //                   if (formKey.currentState!.validate()) {
  //                     FirebaseFirestore.instance
  //                         .collection('UserProfileCollection')
  //                         .doc(user!.uid)
  //                         .update({
  //                       'name': nameController.text.toString(),
  //                     }).then((value) {
  //                       nameController.clear();
  //                     });
  //                     Navigator.pop(context);
  //                     Utils.positiveToastMessage('Name updated successfully');
  //                   }
  //                 },
  //                 child: const Text(
  //                   'Save',
  //                   style: TextStyle(
  //                     color: Colors.green,
  //                   ),
  //                 ))
  //           ],
  //         );
  //       });
  // }
  // Future<void> userDateOfBirthDialogAlert(
  //     BuildContext context, String dateOfBirth) {
  //   final TextEditingController dateController =
  //   TextEditingController(text: dateOfBirth);
  //
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Update Date of Birth'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               GestureDetector(
  //                 onTap: () async {
  //                   final DateTime? selectedDate = await showDatePicker(
  //                     context: context,
  //                     initialDate: DateTime.parse(dateController.text),
  //                     firstDate: DateTime(1933, 1, 1),
  //                     lastDate: DateTime(2007, 1, 1),
  //                   );
  //
  //                   if (selectedDate != null) {
  //                     dateController.text =
  //                         DateFormat('yyyy-MM-dd').format(selectedDate);
  //                     // Update the age and age group
  //                     findAgeGroup();
  //                   }
  //                 },
  //                 child: AbsorbPointer(
  //                   child: TextFormField(
  //                     controller: dateController,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Date of Birth',
  //                       suffixIcon: Icon(Icons.calendar_today),
  //                     ),
  //                     validator: (value) {
  //                       if (value!.isEmpty) {
  //                         return 'Please select a date of birth';
  //                       }
  //                       return null;
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text(
  //               'Cancel',
  //               style: TextStyle(
  //                 color: Colors.red,
  //               ),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               final String newDateOfBirth = dateController.text;
  //
  //               FirebaseFirestore.instance
  //                   .collection('UserProfileCollection')
  //                   .doc(user!.uid)
  //                   .update({
  //                 'dateOfBirth': newDateOfBirth,
  //                 'age': age.toString(),
  //                 'ageGroup': ageGroup,
  //               }).then((value) {
  //                 Utils.positiveToastMessage('Date of Birth updated successfully');
  //
  //                 Navigator.pop(context);
  //               }).catchError((error) {
  //                 Utils.negativeToastMessage('Failed to update Date of Birth');
  //               });
  //             },
  //             child: const Text(
  //               'Save',
  //               style: TextStyle(
  //                 color: Colors.green,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Future<void> userGenderDialogAlert(
  //     BuildContext context, String? initialGender,
  //     {String? gender}) {
  //   _selectedValue = initialGender;
  //
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Update Gender'),
  //         content: DropdownButtonFormField<String>(
  //           decoration: const InputDecoration(
  //             labelText: 'Select Gender',
  //           ),
  //           value: _selectedValue,
  //           onChanged: (newValue) {
  //             _selectedValue = newValue;
  //             notifyListeners();
  //           },
  //           items: [
  //             const DropdownMenuItem<String>(
  //               value: 'Male',
  //               child: Text('Male'),
  //             ),
  //             const DropdownMenuItem<String>(
  //               value: 'Female',
  //               child: Text('Female'),
  //             ),
  //           ],
  //           validator: (value) {
  //             if (value == null) {
  //               return 'Please select your Gender';
  //             }
  //             return null;
  //           },
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text(
  //               'Cancel',
  //               style: TextStyle(
  //                 color: Colors.red,
  //               ),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               FirebaseFirestore.instance
  //                   .collection('UserProfileCollection')
  //                   .doc(user!.uid)
  //                   .update({
  //                 'gender': _selectedValue,
  //               });
  //               Navigator.pop(context);
  //             },
  //             child: const Text(
  //               'Save',
  //               style: TextStyle(
  //                 color: Colors.green,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  @override
  void dispose() {
    nameController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }
}