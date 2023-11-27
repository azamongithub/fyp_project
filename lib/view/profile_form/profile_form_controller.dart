import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/services/shared_preferences_helper.dart';

class ProfileFormController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
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
      return 'Teenager';
    } else if (age >= 20 && age <= 29) {
      return 'Young Adult';
    } else if (age >= 30 && age <= 54) {
      return 'Middle Aged Adult';
    } else if (age >= 55) {
      return 'Older Adult';
    } else {
      return 'Age Group Not Defined';
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
          .collection('UserProfileCollection')
          .doc(user.uid)
          .set(profileData);

      await SharedPreferencesHelper.setProfileCompleted(true);
      //setProfileCompleted();
      //Provider.of<ProfileFormController>(context, listen: false).setProfileCompleted();
      Navigator.pushNamed(context, RouteName.FitnessAnalyzerForm);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setProfileCompleted() {
    _isProfileCompleted = true;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }
}


// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../utils/routes/route_name.dart';
//
// class ProfileFormController extends ChangeNotifier {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController dateOfBirthController = TextEditingController();
//   bool isLoading = false;
//   String selectedGender = '';
//   RegExp nameRegExp = RegExp(r'^[a-zA-Z]{1,10}$');
//
//   late DateTime selectedDate;
//
//
//   void setLoading(bool loading) {
//     isLoading = loading;
//     notifyListeners();
//   }
//
//   void setSelectedGender(String gender) {
//     selectedGender = gender;
//     notifyListeners();
//   }
//
//   void onDateSelected(DateTime? date) {
//     if (date != null) {
//       selectedDate = date;
//     }
//   }
//
//   int calculateAge(DateTime dateOfBirth) {
//     DateTime currentDate = DateTime.now();
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
//   String findAgeGroup() {
//     int age = calculateAge(selectedDate);
//
//     if (age >= 13 && age <= 19) {
//       return 'Teenager';
//     } else if (age >= 20 && age <= 29) {
//       return 'Young Adult';
//     } else if (age >= 30 && age <= 54) {
//       return 'Middle Aged Adult';
//     } else if (age >= 55) {
//       return 'Older Adult';
//     } else {
//       return 'Age Group Not Defined';
//     }
//   }
//
//   Future<void> saveProfileDetails(BuildContext context) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       int age = calculateAge(selectedDate);
//       String ageGroup = findAgeGroup();
//
//       final profileData = {
//         'name': nameController.text,
//         'age': age.toString(),
//         'dateOfBirth': dateOfBirthController.text,
//         'ageGroup': ageGroup,
//         'gender': selectedGender,
//         'email': user!.email,
//       };
//
//       isLoading = true;
//       notifyListeners();
//
//       await FirebaseFirestore.instance
//           .collection('UserProfileCollection')
//           .doc(user.uid)
//           .set(profileData);
//
//       Navigator.pushNamed(context, RouteName.FitnessAnalyzerForm);
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     dateOfBirthController.dispose();
//     super.dispose();
//   }
// }
