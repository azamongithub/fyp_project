import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      await FirebaseFirestore.instance
          .collection('UserDataCollection')
          .doc(user.uid)
          .set(profileData, SetOptions(merge: true));
      Navigator.pushNamed(context, RouteName.fitnessAnalyzerForm);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }
}
