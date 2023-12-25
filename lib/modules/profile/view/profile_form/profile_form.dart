import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/constants/assets_constants.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../common_components/calender_text_field.dart';
import '../../../../common_components/custom_button.dart';
import '../../../../common_components/custom_text_field.dart';
import '../../../../theme/text_style_util.dart';
import '../../../../utils/utils.dart';
import '../../controller/profile_form_controller.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Consumer<ProfileFormController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.yourPersonalDetails,
                style: CustomTextStyle.appBarStyle()),
            backgroundColor: AppColors.themeColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
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
                                controller.setSelectedGender('M');
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
                                            color:
                                                controller.selectedGender == 'M'
                                                    ? Colors.green
                                                    : Colors.grey,
                                            width:
                                                controller.selectedGender == 'M'
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
                            SizedBox(height: 8.h),
                            Text(
                              AppStrings.maleLabel,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                        SizedBox(width: 30.w),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.setSelectedGender('F');
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
                                                controller.selectedGender == 'F'
                                                    ? Colors.green
                                                    : Colors.grey,
                                            width:
                                                controller.selectedGender == 'F'
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
                            SizedBox(height: 8.h),
                            Text(
                              AppStrings.femaleLabel,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    CustomTextField(
                      myController: controller.nameController,
                      keyBoardType: TextInputType.name,
                      labelText: AppStrings.nameLabel,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterName;
                        } else if (!controller.nameRegExp.hasMatch(value)) {
                          return AppStrings.enterValidName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    CalendarTextField(
                      calenderController: controller.dateOfBirthController,
                      labelText: AppStrings.dateOfBirthLabel,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.selectDob;
                        }
                        return null;
                      },
                      onDateSelected: controller.onDateSelected,
                    ),
                    SizedBox(height: 70.h),
                    CustomButton(
                      title: AppStrings.continueButton,
                      loading: controller.isLoading,
                      height: 50.h,
                      width: 400.w,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (controller.selectedGender.isNotEmpty) {
                            controller.saveProfileDetails(context);
                            //plansController.fetchAndPassUserDetails();
                          } else {
                            Utils.positiveToastMessage(AppStrings.selectGender);
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
