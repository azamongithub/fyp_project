import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../routes/route_name.dart';
import '../../search_workout/services/workout_service.dart';
import '../controller/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  WorkoutService workoutService = WorkoutService();
  double workoutProgress = 0.0;
  double mealProgress = 0.0;

  @override
  void initState() {
    super.initState();
    DashboardController controller =
        Provider.of<DashboardController>(context, listen: false);
    controller.reNewProgressIfMonday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.dashboard,
          style: CustomTextStyle.appBarStyle(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.weeklyMealProgress,
                        style: CustomTextStyle.textStyle16(
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      const Text(AppStrings.progressSubtitle),
                      SizedBox(height: 10.h),
                      Consumer<DashboardController>(
                        builder: (context, dashboardController, child) {
                          return Column(
                            children: [
                              Text(
                                dashboardController.mealProgress == 100
                                    ? AppStrings.mealProgressCompleted
                                    : '${dashboardController.mealProgress.toStringAsFixed(2)}% Completed',
                                style: CustomTextStyle.textStyle16(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.weeklyWorkoutProgress,
                        style: CustomTextStyle.textStyle16(
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      const Text(AppStrings.progressSubtitle),
                      SizedBox(height: 10.h),
                      Consumer<DashboardController>(
                        builder: (context, dashboardController, child) {
                          return Column(
                            children: [
                              Text(
                                dashboardController.workoutProgress == 100
                                    ? AppStrings.workoutProgressCompleted
                                    : '${dashboardController.workoutProgress.toStringAsFixed(2)}% Completed',
                                style: CustomTextStyle.textStyle16(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.recommendedWorkouts,
                        style: CustomTextStyle.textStyle16(
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      const Text(AppStrings.recommendedWorkoutsSubtitle),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteName.workoutListScreen);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.themeColor),
                        ),
                        child: const Text(AppStrings.findWorkouts,
                            style: TextStyle(color: AppColors.whiteColor)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.nutrition,
                        style: CustomTextStyle.textStyle16(
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      const Text(AppStrings.nutritionSubtitle),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteName.findNutritionFactsScreen);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.themeColor),
                        ),
                        child: const Text(AppStrings.findNutrition,
                            style: TextStyle(color: AppColors.whiteColor)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
