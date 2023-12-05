import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/notifications_services/notifications_services.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/meal_plan_model.dart';
import '../../../utils/routes/route_name.dart';
import '../../predict_all/predict_all_controller.dart';
import 'dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    //DashboardController provider = Provider.of<DashboardController>(context);
    //provider.fetchData();

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
    //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   // final dashboardController = Provider.of<DashboardController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3140b0),
        title: Text(
          AppStrings.dashboard,
          style: MyTextStyle.appBarStyle(),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Consumer<DashboardController>(
              builder: (context, provider, child) {
            return ElevatedButton.icon(
                onPressed: () async {
                  //provider.mergeUserDataByType();
                  //provider.mergeUserData();
                  provider.fetchData();
                  provider
                      .addMealPlan(provider.mealPlan);
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
              Center(
                child: Text(
                  'Welcome to CoachBot Fitness App',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.058,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fitness Goals',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Progress towards your fitness goals'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('75% Completed'),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => ExerciseListScreen()),
                          //     );
                          //   },
                          //   child: const Text('View Exercises'),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
                      const SizedBox(height: 10),
                      const Text('Discover workouts tailored to your goals'),
                      const SizedBox(height: 10),
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
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nutrition',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Find nutrition facts of any Item'),
                      const SizedBox(height: 10),
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
