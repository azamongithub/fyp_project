import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../common_components/custom_button.dart';
import '../../../../common_components/custom_card.dart';
import '../../../../routes/route_name.dart';
import '../../../../theme/text_style_util.dart';
import '../../../../utils/toast_utils.dart';
import 'package:CoachBot/constants/app_string_constants.dart';
import '../../controller/health_status_controller.dart';

class HealthStatusForm extends StatelessWidget {
  const HealthStatusForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthStatusController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.yourMedicalCondition, style: CustomTextStyle.appBarStyle()),
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
                      AppStrings.medicalConditionMessage,
                      style: CustomTextStyle.textStyle22(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomCard(
                    title: AppStrings.diabetesLabel,
                    isSelected: provider.selectedDisease == AppStrings.diabetesLabel,
                    onTap: () {
                      provider.setSelectedDisease(AppStrings.diabetesLabel);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.hypercholesterolemiaLabel,
                    isSelected: provider.selectedDisease == AppStrings.hypercholesterolemiaLabel,
                    onTap: () {
                      provider.setSelectedDisease(AppStrings.hypercholesterolemiaLabel);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.celiacLabel,
                    isSelected: provider.selectedDisease == AppStrings.celiacLabel,
                    onTap: () {
                      provider.setSelectedDisease(AppStrings.celiacLabel);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.goutLabel,
                    isSelected: provider.selectedDisease == AppStrings.goutLabel,
                    onTap: () {
                      provider.setSelectedDisease(AppStrings.goutLabel);
                    },
                  ),
                  CustomCard(
                    title: AppStrings.otherLabel,
                    isSelected: provider.selectedDisease == 'other',
                    onTap: () {
                      provider.setSelectedDisease('other');
                    },
                  ),
                  CustomCard(
                    title: AppStrings.noneLabel,
                    isSelected: provider.selectedDisease == 'none',
                    onTap: () {
                      provider.setSelectedDisease('none');
                    },
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    title: AppStrings.continueButton,
                    loading: provider.isLoading,
                    onTap: () async {
                      if (provider.selectedDisease != null) {
                        provider.setIsLoading(true);
                        provider.saveHealthDetails(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => BottomNavBar()),
                        // );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteName.bottomNavBar,
                              (route) => false,
                        );
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