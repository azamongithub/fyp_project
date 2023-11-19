import 'package:flutter/material.dart';
import '../all_meal_plans/meal_plan_screen.dart';

class PlansTab extends StatelessWidget {
  const PlansTab({super.key});


  @override
  Widget build(BuildContext context) {
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
                  MyPlansCard(
                    title: 'Workout Plan',
                    description: 'High-intensity cardio workout',
                    onPressed: () {
                      // Action when Cardio Blast workout is selected
                    },
                  ),
                  MyPlansCard(
                    title: 'Meal Plan',
                    description: 'Balanced eating made easy',
                    onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayMealPlansScreen() ));
                      // Action when Strength Training workout is selected
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

  Widget MyPlansCard({
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
}
