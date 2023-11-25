import 'package:CoachBot/res/component/input_text_field.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:CoachBot/view_model/fitness/fitness_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../helper_classes/firebase_helper.dart';
import '../../models/user_model.dart';
import '../../res/component/custom_button.dart';
import '../../theme/text_style_util.dart';

class FitnessAnalyzerForm extends StatefulWidget {
  const FitnessAnalyzerForm({super.key});

  @override
  _FitnessAnalyzerFormState createState() => _FitnessAnalyzerFormState();
}

class _FitnessAnalyzerFormState extends State<FitnessAnalyzerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _workoutController = TextEditingController();
  final List<String> _fitnessGoal = ['Muscle Building', 'Weight Gain', 'Weight Loss'];
  String? _selectedFitnessGoal;

  List<int> feetOptions = [3, 4, 5, 6, 7, 8];
  List<int> inchesOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  int selectedFeet = 4;
  int selectedInch = 9;
  double bmi = 0;
  bool _isLoading = false;
  String? bmiCategory;


  void calculateBMI(double heightInCm) {
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (weight != 0 && heightInCm != 0) {
      setState(() {
        bmi = weight / ((heightInCm / 100) * (heightInCm / 100));
        if (bmi < 18.5) {
          bmiCategory = 'Underweight';
        } else if (bmi >= 18.5 && bmi < 25) {
          bmiCategory = 'Normal weight';
        } else if (bmi >= 25 && bmi < 30) {
          bmiCategory = 'Overweight';
        } else if (bmi >= 30) {
          bmiCategory = 'Obesity';
        }
      });
    } else {
      setState(() {
        bmi = 0;
        bmiCategory = 'Not Found';
      });
    }
  }

  Future<void> saveFitnessDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      int totalInches = selectedFeet * 12 + selectedInch;
      double totalFeet = totalInches / 12;
      double heightInCm = totalFeet * 30.48;


      final fitnessData = {
        'email': user!.email,
        'weight': _weightController.text,
        'height': totalFeet.toString(),
        'heightInCm': heightInCm.toString(),
        'bmi': bmi,
        'bmiCategory': bmiCategory,
        'fitnessGoal': _selectedFitnessGoal,
        'calories': _caloriesController.text,
        'workout': _workoutController.text,
      };
      calculateBMI(heightInCm);
      await FirebaseFirestore.instance
          .collection('UserFitnessCollection')
          .doc(user!.uid)
          .set(fitnessData);
      Navigator.pushNamed(context, RouteName.HealthStatusForm);
    } catch (e) {
      if (kDebugMode) {
        Utils.negativeToastMessage('Error');
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Fitness Details'),
        backgroundColor: const Color(0xff3140b0),
        automaticallyImplyLeading: false,
      ),
      body:

      ChangeNotifierProvider(
        create: (_) => FitnessController(),
        child: Consumer(
          builder: (context , provider, child) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10.h),
                      Center(
                          child: Text(
                            'Enter required inputs to find your fitness level',
                            style: MyTextStyle.textStyle22(
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      SizedBox(height: 40.h),
                      CustomTextField(
                          myController: _weightController,
                          keyBoardType: TextInputType.number,
                          labelText: 'Weight (kg)',
                          onChange: (value) {
                            calculateBMI(((selectedFeet * 12 + selectedInch) / 12 ) * 30.48);
                          },
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your weight.';
                            }
                            double? weight = double.tryParse(value);
                            if (weight == null || weight < 26 || weight > 130) {
                              return 'Please enter a valid weight.';
                            }
                            calculateBMI(((selectedFeet * 12 + selectedInch) / 12 ) * 30.48);
                            return null;
                          }),
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          Expanded(
                            child:
                            DropdownButtonFormField<int>(
                              value: selectedFeet,
                              onChanged: (value) {
                                setState(() {
                                  selectedFeet = value!;
                                });
                              },
                              items: feetOptions.map((feet) {
                                return DropdownMenuItem<int>(
                                  value: feet,
                                  child: Text('$feet\''),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Height (Feet)',
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child:
                            DropdownButtonFormField<int>(
                              value: selectedInch,
                              onChanged: (value) {
                                setState(() {
                                  selectedInch = value!;
                                });
                              },
                              items: inchesOptions.map((inch) {
                                return DropdownMenuItem<int>(
                                  value: inch,
                                  child: Text('$inch"'),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Height (Inches)',
                              ),
                            ),


                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Fitness Goal',
                          ),
                          value: _selectedFitnessGoal,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedFitnessGoal = newValue;
                            });
                          },
                          items: _fitnessGoal.map((fitnessGoal) {
                            return DropdownMenuItem<String>(
                              value: fitnessGoal,
                              child: Text(fitnessGoal),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select your fitness goal.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomTextField(
                          myController: _caloriesController,
                          keyBoardType: TextInputType.number,
                          labelText: 'Calories Required',
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter calories.';
                            }
                            double? calories = double.tryParse(value);
                            if (calories == null || calories < 1200 || calories > 4000) {
                              return 'Please enter a valid calories.';
                            }
                            return null;
                          }),
                      SizedBox(height: 30.h),
                      CustomTextField(
                          myController: _workoutController,
                          keyBoardType: TextInputType.text,
                          labelText: 'Workout Name',
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your workout name.';
                            }
                            return null;
                          }),
                      SizedBox(height: 60.h),
                      CustomButton(
                        title: 'Continue',
                        loading: _isLoading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            saveFitnessDetails();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
