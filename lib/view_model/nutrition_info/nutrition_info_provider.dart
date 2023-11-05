import 'dart:convert';

import 'package:CoachBot/constants/api_constant.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../models/NutritionInfoModel.dart';

class NutritionDataProvider extends ChangeNotifier {

  String _apiResponse = '';
  String get apiResponse => _apiResponse;


  NutritionInfoModel? _nutritionFacts;
  NutritionInfoModel? get nutritionFacts => _nutritionFacts;

  bool _loading = false;
  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchData(String query) async {
    setLoading(true);
    final apiUrl =
        '${ApiConstant.nutritionFactsAPI}=$query';

    final response = await http.get(Uri.parse(apiUrl), headers: {
      'X-RapidAPI-Key': ApiConstant.apiKey,
      'X-RapidAPI-Host': 'nutrition-by-api-ninjas.p.rapidapi.com',
    });
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print("Nutrition API responce: ${response.body}");
      _nutritionFacts  = NutritionInfoModel.fromJson(jsonResponse[0]);
      setLoading(false);
      notifyListeners();
    } else {
      _nutritionFacts = null;
      setLoading(false);
      notifyListeners();
    }
  }
}
