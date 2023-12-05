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
            title: Text(AppStrings.yourMedicalCondition, style: MyTextStyle.appBarStyle()),
            backgroundColor: const Color(0xff3140b0),
            automaticallyImplyLeading: false,
            centerTitle: true,
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
                  title: AppStrings.diabetesLabel,
                  isSelected: provider.selectedDisease == 'Diabetes',
                  onTap: () {
                    provider.setSelectedDisease('Diabetes');
                  },
                ),
                CustomCard(
                  title: AppStrings.hypercholesterolemiaLabel,
                  isSelected: provider.selectedDisease == 'Hypercholesterolaemia',
                  onTap: () {
                    provider.setSelectedDisease('Hypercholesterolaemia');
                  },
                ),
                CustomCard(
                  title: AppStrings.celiacLabel,
                  isSelected: provider.selectedDisease == 'Celiac',
                  onTap: () {
                    provider.setSelectedDisease('Celiac');
                  },
                ),
                CustomCard(
                  title: AppStrings.goutLabel,
                  isSelected: provider.selectedDisease == 'Gout',
                  onTap: () {
                    provider.setSelectedDisease('Gout');
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
                      Utils.positiveToastMessage(AppStrings.selectDisease);
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