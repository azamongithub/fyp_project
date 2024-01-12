import 'package:CoachBot/modules/my_plans/controller/my_plans_controller.dart';
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
  final bool isEdit;
  const FitnessAnalyzerForm({
    Key? key,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.yourFitnessDetails,
            style: CustomTextStyle.appBarStyle()),
        backgroundColor: AppColors.themeColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        automaticallyImplyLeading: isEdit ? true : false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (_) => FitnessFormController(),
          child: Consumer2<FitnessFormController, MyPlansController>(
              builder: (context, controller, plansController, _) {
            return Form(
              key: controller.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Center(
                      child: Text(
                        isEdit
                            ? AppStrings.updateFitnessMessage
                            : AppStrings.fitnessDetailsMessage,
                        style: CustomTextStyle.textStyle22(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      myController: controller.weightController,
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
                              border: Border.all(color: Colors.grey),
                              // Set your border color
                              borderRadius: BorderRadius.circular(
                                  8.0), // Set border radius if needed
                            ),
                            child: DropdownButtonFormField<int>(
                              value: isEdit ? controller.selectedFeet : null,
                              onChanged: (value) {
                                controller.setSelectedFeet(value!);
                              },
                              items: controller.feetOptions.map((feet) {
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
                                hintText: AppStrings.heightFeetHint,
                                border:
                                    InputBorder.none, // Remove default border
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return AppStrings.selectFeet;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DropdownButtonFormField<int>(
                              value: isEdit ? controller.selectedInch : null,
                              onChanged: (value) {
                                controller.setSelectedInch(value!);
                              },
                              items: controller.inchesOptions.map((inch) {
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
                                hintText: AppStrings.heightInchHint,
                                border:
                                    InputBorder.none, // Remove default border
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return AppStrings.selectInch;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    CustomButton(
                      title: isEdit
                          ? AppStrings.updateButton
                          : AppStrings.continueButton,
                      loading: controller.isLoading,
                      height: 50.h,
                      width: 400.w,
                      onTap: () async {
                        if (controller.formKey.currentState!.validate()) {
                          controller.setIsLoading(true);
                          controller.saveFitnessDetails(context);
                          isEdit ? plansController.fetchAndPassUserDetails() : null;
                          isEdit ? Navigator.pop(context) : null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
