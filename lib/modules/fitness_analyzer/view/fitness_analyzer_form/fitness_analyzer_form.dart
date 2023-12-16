import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common_components/custom_button.dart';
import '../../../../common_components/custom_text_field.dart';
import '../../../../constants/app_string_constants.dart';
import '../../../../theme/text_style_util.dart';
import '../../controller/fitness_form_controller.dart';

class FitnessAnalyzerForm extends StatelessWidget {
  const FitnessAnalyzerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FitnessFormController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.yourFitnessDetails, style: CustomTextStyle.appBarStyle()),
            backgroundColor: ColorUtil.themeColor,
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
                        style: CustomTextStyle.textStyle22(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      myController: provider.weightController,
                      keyBoardType: TextInputType.number,
                      labelText: AppStrings.weightLabel,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterWeight;
                        }
                        double? weight = double.tryParse(value);
                        if (weight == null || weight < 26 || weight > 130) {
                          return AppStrings.enterValidWeight;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // Set your border color
                              borderRadius: BorderRadius.circular(8.0), // Set border radius if needed
                            ),
                            child: DropdownButtonFormField<int>(
                              value: provider.selectedFeet,
                              onChanged: (value) {
                                provider.setSelectedFeet(value!);
                              },
                              items: provider.feetOptions.map((feet) {
                                return DropdownMenuItem<int>(
                                  value: feet,
                                  child: Text(
                                    '$feet\'',
                                    style: CustomTextStyle.textStyle18(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: AppStrings.heightFeetLabel,
                                border: InputBorder.none, // Remove default border
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // Set your border color
                              borderRadius: BorderRadius.circular(8.0), // Set border radius if needed
                            ),
                            child: DropdownButtonFormField<int>(
                              value: provider.selectedInch,
                              onChanged: (value) {
                                provider.setSelectedInch(value!);
                              },
                              items: provider.inchesOptions.map((inch) {
                                return DropdownMenuItem<int>(
                                  value: inch,
                                  child: Text(
                                    '$inch"',
                                    style: CustomTextStyle.textStyle18(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: AppStrings.heightInchLabel,
                                border: InputBorder.none, // Remove default border
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),
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
