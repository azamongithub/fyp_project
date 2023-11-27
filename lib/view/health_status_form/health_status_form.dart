import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../res/component/custom_card.dart';
import '../../theme/text_style_util.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../../res/component/custom_button.dart';
import 'package:CoachBot/constants/app_string_constants.dart';
import 'health_status_provider.dart';

class HealthStatusForm extends StatelessWidget {
  const HealthStatusForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthFormController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.yourMedicalCondition),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 30.h),
                CustomCard(
                  title: AppStrings.diabetes,
                  isSelected: provider.selectedDisease == 'Diabetes',
                  onTap: () {
                    provider.setSelectedDisease('Diabetes');
                  },
                ),
                CustomCard(
                  title: AppStrings.hypercholesterolemia,
                  isSelected: provider.selectedDisease == 'Hypercholesterolemia',
                  onTap: () {
                    provider.setSelectedDisease('Hypercholesterolemia');
                  },
                ),
                CustomCard(
                  title: AppStrings.celiac,
                  isSelected: provider.selectedDisease == 'Celiac',
                  onTap: () {
                    provider.setSelectedDisease('Celiac');
                  },
                ),
                CustomCard(
                  title: AppStrings.gout,
                  isSelected: provider.selectedDisease == 'Gout',
                  onTap: () {
                    provider.setSelectedDisease('Gout');
                  },
                ),
                CustomCard(
                  title: AppStrings.none,
                  isSelected: provider.selectedDisease == 'None',
                  onTap: () {
                    provider.setSelectedDisease('None');
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
                        RouteName.BottomNavBar,
                            (route) => false,
                      );
                    } else {
                      Utils.positiveToastMessage(AppStrings.inputDisease);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}