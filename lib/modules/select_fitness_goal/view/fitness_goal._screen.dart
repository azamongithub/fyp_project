import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common_components/custom_button.dart';
import '../../../common_components/custom_card.dart';
import '../../../theme/text_style_util.dart';
import '../../../utils/toast_utils.dart';
import 'package:CoachBot/constants/app_string_constants.dart';

import '../controller/fitness_goal_controller.dart';

class FitnessGoalForm extends StatelessWidget {
  const FitnessGoalForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FitnessGoalController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.yourFitnessGoal, style: CustomTextStyle.appBarStyle()),
            backgroundColor: ColorUtil.themeColor,
            automaticallyImplyLeading: false,
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
                      AppStrings.fitnessGoalMessage,
                      style: CustomTextStyle.textStyle22(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomCard(
                    title: AppStrings.muscleBuildingLabel,
                    isSelected: provider.selectedFitnessGoal == AppStrings.muscleBuildingValue,
                    onTap: () {
                      provider.setSelectedFitnessGoal(AppStrings.muscleBuildingValue);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.weightGainLabel,
                    isSelected: provider.selectedFitnessGoal == AppStrings.weightGainValue,
                    onTap: () {
                      provider.setSelectedFitnessGoal(AppStrings.weightGainValue);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.weightLossLabel,
                    isSelected: provider.selectedFitnessGoal == AppStrings.weightLossValue,
                    onTap: () {
                      provider.setSelectedFitnessGoal(AppStrings.weightLossValue);
                    },
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    title: AppStrings.continueButton,
                    loading: provider.isLoading,
                    onTap: () async {
                      if (provider.selectedFitnessGoal != null) {
                        provider.setIsLoading(true);
                        provider.saveFitnessGoalDetails(context);
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   RouteName.healthStatusForm,
                        //       (route) => false,
                        // );
                      } else {
                        ToastUtils.positiveToastMessage(AppStrings.selectDisease);
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