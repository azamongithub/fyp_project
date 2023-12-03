import 'package:CoachBot/view/predict_all/predict_all_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiController = Provider.of<ApiController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Plans'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ApiDataWidget(),
            ElevatedButton(
              onPressed: () {
                apiController.fetchApiData({
                  "age": "26",
                  "gender": "M",
                  "Height": "5.9",
                  "weight": "79",
                  "Medical History": "none",
                });
              },
              child: const Text('View Plan'),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiController = Provider.of<ApiController>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Meal Plan: ${apiController.apiData.mealPlan}'),
        Text('Calories: ${apiController.apiData.calories.toString()}'),
        Text('Workout Plan: ${apiController.apiData.workoutPlan}'),
      ],
    );
  }
}
