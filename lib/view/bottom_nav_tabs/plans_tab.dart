import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../theme/text_style_util.dart';
import '../../utils/routes/route_name.dart';

class PlansTab extends StatelessWidget {
  late final double retrievedCalories;
  late final String mealPlan;

  PlansTab({super.key}) {
    // throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    Future<void> fetchCalories() async {
      try {
        CollectionReference userFitnessCollection =
            FirebaseFirestore.instance.collection('UserDataCollection');
        DocumentSnapshot userSnapshot =
            await userFitnessCollection.doc(user!.uid).get();
        retrievedCalories = userSnapshot['calories'];
        mealPlan = userSnapshot['meal_plan'];
        if (kDebugMode) {
          print('Calories: $retrievedCalories');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching calories: $e');
        }
      }
    }

    fetchCalories();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.myPlans, style: MyTextStyle.appBarStyle()),
        backgroundColor: const Color(0xff3140b0),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.customizedPlans,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  myPlansCard(
                    title: AppStrings.workoutPlan,
                    description: AppStrings.checkWorkoutPlan,
                    onPressed: () {
                      // Action when Cardio Blast workout is selected
                    },
                  ),
                  myPlansCard(
                    title: AppStrings.mealPlan,
                    description: AppStrings.checkMealPlan,
                    onPressed: () async {
                      //int totalCalories = retrievedCalories.toInt();
                      String name = mealPlan;
                      //String disease = 'none';
                      print('Meal Plan is: $mealPlan');
                      Navigator.pushNamed(
                        context,
                        RouteName.mealPlanDaysScreen,
                        arguments: {
                          'name': name,
                        },
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MealPlanDaysScreen(
                      //         name: name),
                      //   ),
                      // );
                    },
                  ),
                  // Add more workout cards as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget myPlansCard({
  required String title,
  required String description,
  required VoidCallback onPressed,
}) {
  return Card(
    child: ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onPressed,
    ),
  );
}
