import 'package:flutter/material.dart';

class PlansTab extends StatelessWidget {
  const PlansTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
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
                  _buildWorkoutCard(
                    title: 'Workout Plan',
                    description: 'High-intensity cardio workout',
                    onPressed: () {
                      // Action when Cardio Blast workout is selected
                    },
                  ),
                  _buildWorkoutCard(
                    title: 'Meal Plan',
                    description: 'Balanced eating made easy',
                    onPressed: () {
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

  Widget _buildWorkoutCard({
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
