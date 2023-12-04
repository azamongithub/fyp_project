// api_data_model.dart

class PredictionModel {
  final String mealPlan;
  final double calories;
  final String workoutPlan;

  PredictionModel({
    required this.mealPlan,
    required this.calories,
    required this.workoutPlan,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      mealPlan: json['meal_plan'],
      calories: json['calories'],
      workoutPlan: json['workout_plan'],
    );
  }
}
