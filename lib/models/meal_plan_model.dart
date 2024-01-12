class MealPlanModel {
  String id;
  String? name;
  String? disease;
  String description;
  Map<String, dynamic> days;

  MealPlanModel({
    required this.id,
    this.name,
    this.disease,
    required this.description,
    required this.days,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'disease': disease,
      'description': description,
      'days': days,
    };
  }

  factory MealPlanModel.fromJson(String id, Map<String, dynamic> json) {
    return MealPlanModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      disease: json['disease'] ?? '',
      description: json['description'] ?? '',
      days: json['days'] ?? {},
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
  });

  Map<String, dynamic> toJson() {
    return {
      // 'mealCalories': mealCalories,
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
