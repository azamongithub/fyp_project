import 'package:CoachBot/res/component/input_text_field.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../res/component/custom_button.dart';

class FitnessAnalyzerForm extends StatefulWidget {
  const FitnessAnalyzerForm({super.key});

  @override
  _FitnessAnalyzerFormState createState() => _FitnessAnalyzerFormState();
}

class _FitnessAnalyzerFormState extends State<FitnessAnalyzerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final List<String> _fitnessGoal = ['Muscle Building', 'Weight Gain', 'Weight Loss'];
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _workoutController = TextEditingController();

  String? _selectedFitnessGoal;
  double bmi = 0;
  bool _isLoading = false;
  String? bmiCategory;

  void calculateBMI() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;

    if (weight != 0 && height != 0) {
      setState(() {
        bmi = weight / ((height / 100) * (height / 100));
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
      });
    }
  }

  Future<void> _saveFitnessDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final fitnessData = {
        'email': user!.email,
        'weight': _weightController.text,
        'height': _heightController.text,
        'fitnessGoal': _selectedFitnessGoal,
        'bmi': bmi,
        'bmiCategory': bmiCategory,
        'calories': _caloriesController.text,
        'workout': _workoutController.text,
      };
      calculateBMI();
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
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Fitness Details'),
        backgroundColor: const Color(0xff3140b0),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: height * 0.01),
                CustomTextField(
                    myController: _weightController,
                    keyBoardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    labelText: 'Weight (kg)',
                    onValidator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your weight.';
                      }
                      double? weight = double.tryParse(value);
                      if (weight == null || weight < 26 || weight > 130) {
                        return 'Please enter a valid weight.';
                      }
                      return null;
                    }),
                SizedBox(height: height * 0.02),
                CustomTextField(
                    myController: _heightController,
                    keyBoardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    labelText: 'Height (cm)',
                    onValidator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your height.';
                      }
                      double? height = double.tryParse(value);
                      if (height == null || height < 50 || height > 280) {
                        return 'Please enter a valid height.';
                      }
                      return null;
                    }),

                SizedBox(height: height * 0.02),
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
                SizedBox(height: height * 0.02),
                CustomTextField(
                    myController: _caloriesController,
                    keyBoardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                SizedBox(height: height * 0.02),
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
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.grey,
                //     ),
                //     borderRadius: BorderRadius.circular(8.0),
                //   ),
                //   child: DropdownButtonFormField<String>(
                //     decoration: const InputDecoration(
                //       labelText: 'Food Preferences',
                //     ),
                //     value: _selectedFoodPreferences,
                //     onChanged: (newValue) {
                //       setState(() {
                //         _selectedFoodPreferences = newValue;
                //       });
                //     },
                //     items: _foodPreferences.map((foodPreference) {
                //       return DropdownMenuItem<String>(
                //         value: foodPreference,
                //         child: Text(foodPreference),
                //       );
                //     }).toList(),
                //     validator: (value) {
                //       if (value == null) {
                //         return 'Please select your food preference.';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                const SizedBox(height: 16.0),
                CustomButton(
                  title: 'Continue',
                  loading: _isLoading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      _saveFitnessDetails();
                    }
                  },
                ),
                // ChangeNotifierProvider(
                //     create: (_) => FitnessController(),
                //     child: Consumer<FitnessController>(
                //         builder: (context, provider, child) {
                //       return RoundButton(
                //         title: 'Continue',
                //         loading: _isLoading,
                //         onTap: () {
                //           if (_formKey.currentState!.validate()) {
                //             setState(() {
                //               _isLoading = true;
                //             });
                //             _saveFitnessDetails();
                //           }
                //         },
                //       );
                //     }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
