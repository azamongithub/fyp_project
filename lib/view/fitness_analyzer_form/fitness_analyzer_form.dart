import 'package:CoachBot/view/fitness_analyzer_form/fitness_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/app_string_constants.dart';
import '../../res/component/custom_button.dart';
import '../../res/component/custom_text_field.dart';
import '../../theme/text_style_util.dart';

class FitnessAnalyzerForm extends StatelessWidget {
  const FitnessAnalyzerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FitnessFormController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.yourFitnessDetails, style: MyTextStyle.appBarStyle()),
            backgroundColor: const Color(0xff3140b0),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: provider.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Center(
                      child: Text(
                        AppStrings.fitnessDetailsMessage,
                        style: MyTextStyle.textStyle22(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      myController: provider.weightController,
                      keyBoardType: TextInputType.number,
                      labelText: AppStrings.weightLabel,
                      // onChange: (value) {
                      //   provider.calculateBMI(((provider.selectedFeet * 12 +
                      //               provider.selectedInch) /
                      //           12) *
                      //       30.48);
                      // },
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterWeight;
                        }
                        double? weight = double.tryParse(value);
                        if (weight == null || weight < 26 || weight > 130) {
                          return AppStrings.enterValidWeight;
                        }
                        // provider.calculateBMI(((provider.selectedFeet * 12 +
                        //             provider.selectedInch) /
                        //         12) *
                        //     30.48);
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: provider.selectedFeet,
                            onChanged: (value) {
                              provider.setSelectedFeet(value!);
                            },
                            items: provider.feetOptions.map((feet) {
                              return DropdownMenuItem<int>(
                                value: feet,
                                child: Text('$feet\'',
                                style: MyTextStyle.textStyle18(
                                  fontWeight: FontWeight.w400,
                                ),
                                ),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: AppStrings.heightFeetLabel,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: provider.selectedInch,
                            onChanged: (value) {
                              provider.setSelectedInch(value!);
                            },
                            items: provider.inchesOptions.map((inch) {
                              return DropdownMenuItem<int>(
                                value: inch,
                                child: Text('$inch"',
                                  style: MyTextStyle.textStyle18(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: AppStrings.heightInchLabel,
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
                          labelText: AppStrings.fitnessGoalLabel,
                        ),
                        value: provider.selectedFitnessGoal,
                        onChanged: (newValue) {
                          provider.setSelectedFitnessGoal(newValue!);
                        },
                        items: provider.fitnessGoal.map((fitnessGoal) {
                          return DropdownMenuItem<String>(
                            value: fitnessGoal,
                            child: Text(fitnessGoal,
                              style: MyTextStyle.textStyle18(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppStrings.selectGoal;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      myController: provider.caloriesController,
                      keyBoardType: TextInputType.number,
                      labelText: 'Calories Required',
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter calories.';
                        }
                        // double? calories = double.tryParse(value);
                        // if (calories == null || calories < 1200 || calories > 4000) {
                        //   return 'Please enter a valid calories.';
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    CustomTextField(
                      myController: provider.workoutController,
                      keyBoardType: TextInputType.text,
                      labelText: 'Workout Name',
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your workout name.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50.h),
                    CustomButton(
                      title: AppStrings.continueButton,
                      loading: provider.isLoading,
                      onTap: () {
                        if (provider.formKey.currentState!.validate()) {
                          provider.setIsLoading(true);
                          provider.saveFitnessDetails(context);
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
    );
  }
}
