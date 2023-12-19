import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/notifications_services/notifications_services.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../routes/route_name.dart';
import '../controller/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  NotificationServices notificationServices = NotificationServices();
  double workoutProgress = 0.0;
  double mealProgress = 0.0;

  @override
  void initState() {
    super.initState();
    DashboardController controller = Provider.of<DashboardController>(
        context, listen: false);
    controller.fetchWeeklyProgress();
    notificationServices.requestNotificationPermission();
    notificationServices.getDeviceToken().then((value) async {
      notificationServices.firebaseInit(context);
      notificationServices.setupInteractMessage(context);
      if (kDebugMode) {
        print('device token');
      }
      if (kDebugMode) {
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil.themeColor,
        title: Text(
          AppStrings.dashboard,
          style: CustomTextStyle.appBarStyle(),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Consumer<DashboardController>(
              builder: (context, provider, child) {
            return ElevatedButton.icon(
                onPressed: () async {
                  //provider.mergeUserDataByType();
                  //provider.mergeUserData();
                  provider.addWorkoutPlan(provider.workoutPlan);
                  // provider
                  //     .addMealPlan(provider.mealPlan);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add'));
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Meal Progress',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Text('Progress towards your fitness goals'),
                      SizedBox(height: 10.h),
                      Consumer<DashboardController>(
                        builder: (context, dashboardController, child){
                          //dashboardController.fetchWeeklyProgress();
                          return Column(
                            children: [
                              Text( dashboardController.mealProgress == 100 ?
                                  'Congrats, you have completed your weekly meal plan' :
                                '${dashboardController.mealProgress.toStringAsFixed(2)}% Completed',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
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
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Workout Progress',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Text('Progress towards your fitness goals'),
                      SizedBox(height: 10.h),
                      Consumer<DashboardController>(
                        builder: (context, dashboardController, child){
                         // dashboardController.fetchWeeklyProgress();
                          return Column(
                            children: [
                              Text( dashboardController.workoutProgress == 100 ?
                              'Congrats, you have completed your weekly workout plan' :
                              '${dashboardController.workoutProgress.toStringAsFixed(2)}% Completed',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
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
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.recommendedWorkouts,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Text('Discover workouts tailored to your goals'),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteName.findWorkoutsScreen);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => FindWorkoutsScreen()),
                          // );
                        },
                        child: const Text('View Workouts'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nutrition',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Text('Find nutrition facts of any Item'),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteName.findNutritionFactsScreen);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           FindNutritionFactsScreen()),
                          // );
                        },
                        child: const Text('Nutrition Facts'),
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
