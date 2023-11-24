class MealPlanModel {
  String id;
  String name;
  String disease;
  String description;
  int? totalCalories;
  Map<String, dynamic> days;
  // String? totalCarbs;
  // String? totalProtein;
  // String? totalSugar;
  // String? totalFat;
  // String? totalCholesterol;
  // String? totalSodium;
  // String? totalPotassium;

  MealPlanModel({
    required this.id,
    required this.name,
    required this.disease,
    required this.description,
    this.totalCalories,
    required this.days,
    // this.totalCarbs,
    // this.totalProtein,
    // this.totalSugar,
    // this.totalFat,
    // this.totalCholesterol,
    // this.totalSodium,
    // this.totalPotassium,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'disease': disease,
      'description': description,
      'totalCalories': totalCalories,
      'days': days,
      // 'totalCarbs': totalCarbs,
      // 'totalProtein': totalProtein,
      // 'totalSugar': totalSugar,
      // 'totalFat': totalFat,
      // 'totalCholesterol': totalCholesterol,
      // 'totalSodium': totalSodium,
      // 'totalPotassium': totalPotassium,
    };
  }

  factory MealPlanModel.fromJson(String id, Map<String, dynamic> json) {
    return MealPlanModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      disease: json['disease'] ?? '',
      description: json['description'] ?? '',
      totalCalories: json['totalCalories'] ?? 0,
      days: json['days'] ?? {},
      // totalCarbs: json['totalCarbs'] ?? '',
      // totalProtein: json['totalProtein'] ?? '',
      // totalSugar: json['totalSugar'] ?? '',
      // totalFat: json['totalFat'] ?? '',
      // totalCholesterol: json['totalCholesterol'] ?? '',
      // totalSodium: json['totalSodium'] ?? '',
      // totalPotassium: json['totalPotassium'] ?? '',
    );
  }
}

class Day {
  Meal breakfast;
  Meal? morningSnack;
  Meal lunch;
  Meal? afternoonSnack;
  Meal? eveningSnack;
  Meal dinner;
  Meal? planAhead;

  Day({
    required this.breakfast,
    required this.morningSnack,
    required this.lunch,
    required this.afternoonSnack,
    this.eveningSnack,
    required this.dinner,
    this.planAhead,
  });

  Map<String, dynamic> toJson() {
    return {
      'breakfast': breakfast.toJson(),
      'morningSnack': morningSnack?.toJson(),
      'lunch': lunch.toJson(),
      'afternoonSnack': afternoonSnack?.toJson(),
      'eveningSnack': eveningSnack?.toJson(),
      'dinner': dinner.toJson(),
      'planAhead': planAhead?.toJson(),
    };
  }
}

class Meal {
  String? mealCalories;
  String? title1;
  String? title2;
  String? title3;
  String? title4;
  String? title5;
  String? title6;
  String? title7;
  String? title8;
  String? title9;
  String? title10;
  String? title11;
  String? title12;

  // String? itemCarbs;
  // String? itemProtein;
  // String? itemSugar;
  // String? itemFat;
  // String? itemCholesterol;
  // String? itemSodium;
  // String? itemPotassium;

  Meal({
    this.mealCalories,
    this.title1,
    this.title2,
    this.title3,
    this.title4,
    this.title5,
    this.title6,
    this.title7,
    this.title8,
    this.title9,
    this.title10,
    this.title11,
    this.title12,
    // this.itemCarbs,
    // this.itemProtein,
    // this.itemSugar,
    // this.itemFat,
    // this.itemCholesterol,
    // this.itemSodium,
    // this.itemPotassium,
  });

  Map<String, dynamic> toJson() {
    return {
      'mealCalories': mealCalories,
      'title1': title1,
      'title2': title2,
      'title3': title3,
      'title4': title4,
      'title5': title5,
      'title6': title6,
      'title7': title7,
      'title8': title8,
      'title9': title9,
      'title10': title10,
      'title11': title11,
      'title12': title12,
    };
  }
}