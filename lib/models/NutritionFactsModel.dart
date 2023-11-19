class NutritionInfoModel {
  final String name;
  final double calories;
  final double servingSize;
  final double totalFat;
  final double saturatedFat;
  final double protein;
  final int sodium;
  final int potassium;
  final int cholesterol;
  final double totalCarbohydrates;
  final double fiber;
  final double sugar;

  NutritionInfoModel({
    required this.name,
    required this.calories,
    required this.servingSize,
    required this.totalFat,
    required this.saturatedFat,
    required this.protein,
    required this.sodium,
    required this.potassium,
    required this.cholesterol,
    required this.totalCarbohydrates,
    required this.fiber,
    required this.sugar,
  });

  factory NutritionInfoModel.fromJson(Map<String, dynamic> json) {
    return NutritionInfoModel(
      name: json['name'],
      calories: json['calories'].toDouble(),
      servingSize: json['serving_size_g'].toDouble(),
      totalFat: json['fat_total_g'].toDouble(),
      saturatedFat: json['fat_saturated_g'].toDouble(),
      protein: json['protein_g'].toDouble(),
      sodium: json['sodium_mg'],
      potassium: json['potassium_mg'],
      cholesterol: json['cholesterol_mg'],
      totalCarbohydrates: json['carbohydrates_total_g'].toDouble(),
      fiber: json['fiber_g'].toDouble(),
      sugar: json['sugar_g'].toDouble(),
    );
  }
}
