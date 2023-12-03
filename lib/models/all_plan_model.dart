// api_data_model.dart

class ApiData {
  final String mealPlan;
  final double calories;
  final String workoutPlan;

  ApiData({
    required this.mealPlan,
    required this.calories,
    required this.workoutPlan,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      mealPlan: json['meal_plan'],
      calories: json['calories'],
      workoutPlan: json['workout_plan'],
    );
  }
}
