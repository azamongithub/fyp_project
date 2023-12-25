import 'package:CoachBot/modules/my_plans/controller/my_plans_controller.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../common_components/custom_button.dart';
import '../../../../common_components/custom_card.dart';
import '../../../../routes/route_name.dart';
import '../../../../theme/text_style_util.dart';
import '../../../../utils/utils.dart';
import 'package:CoachBot/constants/app_string_constants.dart';
import '../../controller/health_status_controller.dart';

class HealthStatusForm extends StatelessWidget {
  final bool isEdit;
  const HealthStatusForm({Key? key, this.isEdit = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HealthStatusController, MyPlansController>(
      builder: (context, controller, plansController, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.yourMedicalCondition,
                style: CustomTextStyle.appBarStyle()),
            backgroundColor: AppColors.themeColor,
            automaticallyImplyLeading: isEdit ? true : false,
            iconTheme: const IconThemeData(color: AppColors.whiteColor),
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
                      isEdit
                          ? AppStrings.updateMedicalMessage
                          : AppStrings.medicalConditionMessage,
                      style: CustomTextStyle.textStyle22(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomCard(
                    title: AppStrings.diabetesLabel,
                    isSelected:
                        controller.selectedDisease == AppStrings.diabetesLabel,
                    onTap: () {
                      controller.setSelectedDisease(AppStrings.diabetesLabel);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.hypercholesterolemiaLabel,
                    isSelected: controller.selectedDisease ==
                        AppStrings.hypercholesterolemiaLabel,
                    onTap: () {
                      controller.setSelectedDisease(
                          AppStrings.hypercholesterolemiaLabel);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.celiacLabel,
                    isSelected:
                        controller.selectedDisease == AppStrings.celiacLabel,
                    onTap: () {
                      controller.setSelectedDisease(AppStrings.celiacLabel);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.goutLabel,
                    isSelected:
                        controller.selectedDisease == AppStrings.goutLabel,
                    onTap: () {
                      controller.setSelectedDisease(AppStrings.goutLabel);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.otherLabel,
                    isSelected: controller.selectedDisease == 'other',
                    onTap: () {
                      controller.setSelectedDisease('other');
                    },
                  ),
                  CustomCard(
                    title: AppStrings.noneLabel,
                    isSelected: controller.selectedDisease == 'none',
                    onTap: () {
                      controller.setSelectedDisease('none');
                    },
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    title: isEdit
                        ? AppStrings.updateButton
                        : AppStrings.continueButton,
                    loading: controller.isLoading,
                    height: 50.h,
                    width: 400.w,
                    onTap: () async {
                      if (controller.selectedDisease != null) {
                        controller.setIsLoading(true);
                        controller.saveHealthDetails(context);
                        plansController.fetchAndPassUserDetails();
                        isEdit
                            ? Navigator.pop(context)
                            : Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteName.bottomNavBar,
                                (route) => false,
                              );
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
