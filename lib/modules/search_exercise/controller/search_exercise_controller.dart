import 'dart:convert';
import 'package:CoachBot/constants/api_constant.dart';
import 'package:CoachBot/models/ExerciseDataModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ExerciseDataController extends ChangeNotifier {
  final String _apiResponse = '';
  String get apiResponse => _apiResponse;
  List<ExerciseDataModel> _exerciseList = [];
  List<ExerciseDataModel> get exercisesList => _exerciseList;
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchExerciseDataByMuscle(String muscle) async {
    setLoading(true);
    final apiUrl = '${ApiConstant.searchExerciseApi}=$muscle';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-RapidAPI-Key': ApiConstant.searchExerciseApiKey,
        'X-RapidAPI-Host': 'exercises-by-api-ninjas.p.rapidapi.com'
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      _exerciseList = jsonData
          .map((dynamic item) => ExerciseDataModel.fromJson(item))
          .toList();
      if (kDebugMode) {
        print("Exercise List is: $_exerciseList");
      }
      notifyListeners();
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      notifyListeners();
      throw Exception('Failed to load exercises');
    }
  }
}
