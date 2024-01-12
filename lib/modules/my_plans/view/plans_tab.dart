import 'package:CoachBot/common_components/custom_list_tile.dart';
import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../routes/route_name.dart';
import '../../../theme/text_style_util.dart';
import '../controller/my_plans_controller.dart';

class PlansTab extends StatefulWidget {
  const PlansTab({super.key});

  @override
  State<PlansTab> createState() => _PlansTabState();
}

class _PlansTabState extends State<PlansTab> {

  @override
  void initState() {
    super.initState();
    MyPlansController myPlansController =
    Provider.of<MyPlansController>(context, listen: false);
    myPlansController.fetchAllData();
    myPlansController.fetchAndPassUserDetails();
    print(FirebaseAuth.instance.currentUser?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.myPlans, style: CustomTextStyle.appBarStyle()),
        backgroundColor: AppColors.themeColor,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MyPlansController>(builder: (context, provider, child) {
        return provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.h, left: 12.w, right: 12.w),
                    child: Text(
                      AppStrings.customizedPlans,
                      style: CustomTextStyle.textStyle24(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ListView(
                        children: [
                          CustomListTile(
                            title: Text('Calories required per day',
                                style: CustomTextStyle.textStyle18()),
                            trailing: Text(
                                provider.retrievedCalories.toStringAsFixed(0),
                                style: CustomTextStyle.textStyle14()),
                            iconData: Icons.countertops_outlined,
                          ),
                          CustomListTile(
                            title: Text(AppStrings.workoutPlan,
                                style: CustomTextStyle.textStyle18()),
                            subTitle: Text(provider.workoutPlan,
                                style: CustomTextStyle.textStyle14()),
                            trailing: const Icon(Icons.arrow_forward),
                            iconData: Icons.fitness_center,
                            onTap: () async {
                              if (kDebugMode) {
                                print(
                                    'Workout Plan is: ${provider.workoutPlan}');
                              }
                              await Navigator.pushNamed(
                                context,
                                RouteName.workoutPlanDaysScreen,
                                arguments: {
                                  'name': provider.workoutPlan,
                                },
                              );
                            },
                          ),

                          CustomListTile(
                            title: Text(
                              AppStrings.mealPlan,
                              style: CustomTextStyle.textStyle18(),
                            ),
                            subTitle: Text(provider.mealPlan,
                                style: CustomTextStyle.textStyle14()),
                            trailing: const Icon(Icons.arrow_forward),
                            iconData: Icons.restaurant,
                            onTap: () async {
                              if (kDebugMode) {
                                print('Meal Plan is: ${provider.mealPlan}');
                              }
                              await Navigator.pushNamed(
                                context,
                                RouteName.mealPlanDaysScreen,
                                arguments: {
                                  'name': provider.mealPlan,
                                },
                              );
                            },
                          ),
                          // Add more workout cards as needed
                        ],
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
