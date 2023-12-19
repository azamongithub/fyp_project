import 'package:CoachBot/modules/my_plans/controller/my_plans_controller.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common_components/custom_button.dart';
import '../../../common_components/custom_card.dart';
import '../../../theme/text_style_util.dart';
import '../../../utils/utils.dart';
import 'package:CoachBot/constants/app_string_constants.dart';

import '../controller/fitness_goal_controller.dart';

class FitnessGoalForm extends StatelessWidget {
  final bool isEdit;
  const FitnessGoalForm({Key? key, this.isEdit =false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<FitnessGoalController, MyPlansController>(
      builder: (context, controller, plansController,_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.yourFitnessGoal, style: CustomTextStyle.appBarStyle()),
            backgroundColor: ColorUtil.themeColor,
            iconTheme: const IconThemeData(color: ColorUtil.whiteColor),
            automaticallyImplyLeading: isEdit? true : false,
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      isEdit ? AppStrings.updateGoalMessage : AppStrings.fitnessGoalMessage,
                      style: CustomTextStyle.textStyle22(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomCard(
                    title: AppStrings.muscleBuildingLabel,
                    isSelected: controller.selectedFitnessGoal == AppStrings.muscleBuildingValue,
                    onTap: () {
                      controller.setSelectedFitnessGoal(AppStrings.muscleBuildingValue);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.weightGainLabel,
                    isSelected: controller.selectedFitnessGoal == AppStrings.weightGainValue,
                    onTap: () {
                      controller.setSelectedFitnessGoal(AppStrings.weightGainValue);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.weightLossLabel,
                    isSelected: controller.selectedFitnessGoal == AppStrings.weightLossValue,
                    onTap: () {
                      controller.setSelectedFitnessGoal(AppStrings.weightLossValue);
                    },
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    title: isEdit ? AppStrings.updateButton : AppStrings.continueButton,
                    loading: controller.isLoading,
                    height: 50.h,
                    width: 400.w,
                    onTap: () async {
                      if (controller.selectedFitnessGoal != null) {
                        controller.setIsLoading(true);
                        controller.saveFitnessGoalDetails(context);
                        plansController.fetchAndPassUserDetails();
                        isEdit ? Navigator.pop(context) : null;
                      } else {
                        Utils.positiveToastMessage(AppStrings.selectAnyOne);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}