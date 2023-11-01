// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
//
// class ProfileFormController extends ChangeNotifier{
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController dateOfBirthController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   late int age;
//   String ageGroup = '';
//   String? _selectedGender;
//   late DateTime _selectedDate;
//   bool _isLoading = false;
//
//   get _age => age;
//   get selectedDate => _selectedDate;
//   get selectedGender => _selectedGender;
//   get _ageGroup => ageGroup;
//
//
//   ProfileFormController(){
//     onDateSelected(_selectedDate);
//     saveProfileDetails();
//   }
//
//
//   void onDateSelected(DateTime? date) {
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
//     notifyListeners();
//     return age;
//   }
//
//   void findAgeGroup() {
//     age = calculateAge(_selectedDate);
//       if (age >= 13 && age <= 19) {
//         ageGroup = 'Teenager';
//       } else if (age >= 20 && age <= 29) {
//         ageGroup = 'Young Adult';
//       } else if (age >= 30 && age <= 54) {
//         ageGroup = 'Middle Aged Adult';
//       } else if (age >= 55) {
//         ageGroup = 'Older Adult';
//       } else {
//         ageGroup = 'Age Group Not Defined';
//       }
//       notifyListeners();
//   }
//
//   Future<void> saveProfileDetails() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       int age = calculateAge(_selectedDate);
//       findAgeGroup();
//
//       final profileData = {
//         'name': nameController.text,
//         'age': age.toString(),
//         'dateOfBirth': dateOfBirthController.text,
//         'ageGroup': ageGroup,
//         'gender': _selectedGender,
//         'email': user!.email,
//       };
//
//       await FirebaseFirestore.instance
//           .collection('UserProfileCollection')
//           .doc(user.uid)
//           .set(profileData);
//
//       //Navigator.pushNamed(context, RouteName.FitnessAnalyzerForm);
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//     } finally {
//         _isLoading = false;
//     }
//     notifyListeners();
//   }
//
//
// }