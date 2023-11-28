import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/constants/assets_constants.dart';
import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/res/component/input_text_field.dart';
import 'package:CoachBot/res/component/calender_text_field.dart';
import 'package:CoachBot/view/profile_form/profile_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../utils/utils.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Consumer<ProfileFormController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.yourPersonalDetails),
            backgroundColor: const Color(0xff3140b0),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
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
                                provider.setSelectedGender('M');
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
                                            color: provider.selectedGender ==
                                                    'M'
                                                ? Colors.green
                                                : Colors.grey,
                                            width: provider.selectedGender ==
                                                    'M'
                                                ? 4
                                                : 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              AppStrings.maleLabel,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.setSelectedGender('F');
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
                                            color: provider.selectedGender ==
                                                    'F'
                                                ? Colors.green
                                                : Colors.grey,
                                            width: provider.selectedGender ==
                                                    'F'
                                                ? 4
                                                : 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              AppStrings.femaleLabel,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    CustomTextField(
                      myController: provider.nameController,
                      keyBoardType: TextInputType.name,
                      labelText: AppStrings.nameLabel,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterName;
                        } else if (!provider.nameRegExp.hasMatch(value)) {
                          return AppStrings.enterValidName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    CalendarTextField(
                      calenderController: provider.dateOfBirthController,
                      labelText: AppStrings.dateOfBirthLabel,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.selectDob;
                        }
                        return null;
                      },
                      onDateSelected: provider.onDateSelected,
                    ),
                    SizedBox(height: 70.h),
                    CustomButton(
                      title: AppStrings.continueButton,
                      loading: provider.isLoading,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (provider.selectedGender.isNotEmpty) {
                            provider.saveProfileDetails(context);
                          } else {
                            Utils.positiveToastMessage(
                                AppStrings.selectGender);
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
    );
  }
}