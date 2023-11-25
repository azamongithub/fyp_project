import 'package:CoachBot/constants/assets_constants.dart';
import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:CoachBot/view_model/profile/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../res/component/input_text_field.dart';
import '../../helper_classes/firebase_helper.dart';
import '../../models/user_model.dart';
import '../../res/component/calender_text_field.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  String ageGroup = '';
  String? _selectedGender;
  String? errorText;
  bool _isLoading = false;
  late DateTime _selectedDate;
  RegExp nameRegExp = RegExp(r'^[a-zA-Z]{1,10}$');

  final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    nameController.dispose();
    dateOfBirthController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime? date) {
    if (date != null) {
      _selectedDate = date;
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

  void findAgeGroup() {
    int age = calculateAge(_selectedDate);
    setState(() {
      if (age >= 13 && age <= 19) {
        ageGroup = 'Teenager';
      } else if (age >= 20 && age <= 29) {
        ageGroup = 'Young Adult';
      } else if (age >= 30 && age <= 54) {
        ageGroup = 'Middle Aged Adult';
      } else if (age >= 55) {
        ageGroup = 'Older Adult';
      } else {
        ageGroup = 'Age Group Not Defined';
      }
    });
  }

  Future<void> _saveProfileDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      int age = calculateAge(_selectedDate);
      findAgeGroup();

      final profileData = {
        'name': nameController.text,
        'age': age.toString(),
        'dateOfBirth': dateOfBirthController.text,
        'ageGroup': ageGroup,
        'gender': _selectedGender,
        'email': user!.email,
      };

      await FirebaseFirestore.instance
          .collection('UserProfileCollection')
          .doc(user.uid)
          .set(profileData);
      Navigator.pushNamed(context, RouteName.FitnessAnalyzerForm);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Your Personal Details'),
              backgroundColor: const Color(0xff3140b0),
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 60.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedGender = 'Male';
                                      errorText = null;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 60.sp,
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 60.sp,
                                          backgroundImage: const AssetImage(
                                              ImageConstants.maleAvatar),
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: _selectedGender == 'Male'
                                                    ? Colors.green
                                                    : Colors.grey,
                                                width: _selectedGender == 'Male'
                                                    ? 4
                                                    : 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(height: 8),
                              const Text(
                                'Male',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedGender = 'Female';
                                      errorText = null;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 60.sp,
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 60.sp,
                                          backgroundImage: const AssetImage(
                                              ImageConstants.femaleAvatar),
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    _selectedGender == 'Female'
                                                        ? Colors.green
                                                        : Colors.grey,
                                                width:
                                                    _selectedGender == 'Female'
                                                        ? 4
                                                        : 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(height: 8),
                              const Text(
                                'Female',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      CustomTextField(
                        myController: nameController,
                        keyBoardType: TextInputType.name,
                        labelText: 'Name',
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name.';
                          }
                          else if(!nameRegExp.hasMatch(value)) {
                            return 'Invalid name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      CalendarTextField(
                        calenderController: dateOfBirthController,
                        labelText: 'Date of birth',
                        //calenderField: 'Date of birth',
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select your date of birth';
                          }
                          return null;
                        },
                        onDateSelected: _onDateSelected,
                      ),
                      SizedBox(height: 70.h),
                      CustomButton(
                        title: 'Continue',
                        loading: _isLoading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedGender != null) {
                              setState(() {
                                _isLoading = true;
                              });
                              addUserDataToFirestore(
                                UserModel(
                                  id: user!.uid,
                                  email: user!.email,
                                  name: nameController.text,
                                ),
                              );
                              _saveProfileDetails();
                            } else {
                              Utils.positiveToastMessage("Please select your gender");
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}