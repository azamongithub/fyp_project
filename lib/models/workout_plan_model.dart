class WorkoutPlanModel {
  String id;
  String name;
  String disease;
  String description;
  Map<String, WorkoutDay> days;

  WorkoutPlanModel({
    required this.id,
    required this.name,
    required this.disease,
    required this.description,
    required this.days,
  });

  factory WorkoutPlanModel.fromJson(String id, Map<String, dynamic> json) {
    Map<String, WorkoutDay> days = {};
    json['days'].forEach((key, value) {
      days[key] = WorkoutDay.fromJson(value);
    });

    return WorkoutPlanModel(
      id: id,
      name: json['name'],
      disease: json['disease'],
      description: json['description'],
      days: days,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'disease': disease,
      'description': description,
      'days': days.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class WorkoutDay {
  List<Exercise> exercises;

  WorkoutDay({required this.exercises});

  factory WorkoutDay.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    json['exercises'].forEach((exercise) {
      exercises.add(Exercise.fromJson(exercise));
    });

    return WorkoutDay(
      exercises: exercises,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }
}

class Exercise {
  String name;
  String description1;
  String description2;
  String description3;
  String description4;
  String description5;

  Exercise({
    required this.name,
    required this.description1,
    this.description2 = '',
    this.description3 = '',
    this.description4 = '',
    this.description5 = '',
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      description1: json['description1'],
      description2: json['description2'] ?? '',
      description3: json['description3'] ?? '',
      description4: json['description4'] ?? '',
      description5: json['description5'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description1': description1,
      'description2': description2,
      'description3': description3,
      'description4': description4,
      'description5': description5,
    };
  }
}
