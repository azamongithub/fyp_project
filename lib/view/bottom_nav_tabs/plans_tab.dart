import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../all_meal_plans/meal_plan_days_screen.dart';
class PlansTab extends StatelessWidget {
  late double retrievedCalories;

 PlansTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    Future<void> fetchCalories() async {
      try {
        CollectionReference userFitnessCollection =
        FirebaseFirestore.instance.collection('UserFitnessCollection');
        DocumentSnapshot userSnapshot =
        await userFitnessCollection.doc(user!.uid).get();
        retrievedCalories = double.parse(userSnapshot['calories']);
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
        title: const Text('My Plans'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Your Customized Plans',
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
                    title: 'Workout Plan',
                    description: 'High-intensity cardio workout',
                    onPressed: () {
                      // Action when Cardio Blast workout is selected
                    },
                  ),
                  myPlansCard(
                    title: 'Meal Plan',
                    description: 'Balanced eating made easy',
                    onPressed: () async {
                      //int totalCalories = retrievedCalories.toInt();
                      String name = 'Carb-Controlled Harmony';
                      //String disease = 'none';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealPlanDaysScreen(
                              name: name),
                        ),
                      );
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

