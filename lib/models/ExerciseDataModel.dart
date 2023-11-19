class ExerciseDataModel {
  final String name;
  final String type;
  final String equipment;
  final String difficulty;
  final String instructions;

  ExerciseDataModel({
    required this.name,
    required this.type,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  factory ExerciseDataModel.fromJson(Map<String, dynamic> json) {
    return ExerciseDataModel(
      name: json['name'],
      type: json['type'],
      equipment: json['equipment'],
      difficulty: json['difficulty'],
      instructions: json['instructions'],
    );
  }
}
