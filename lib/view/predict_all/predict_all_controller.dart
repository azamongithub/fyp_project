// api_controller.dart

import 'package:flutter/foundation.dart';

import '../../models/all_plan_model.dart';
import '../../services/api_repository.dart';

class ApiController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  late ApiData _apiData;

  ApiData get apiData => _apiData;

  Future<void> fetchApiData(Map<String, dynamic> body) async {
    try {
      final Map<String, dynamic> responseData = await _apiService.postApiData(body);
      _apiData = ApiData.fromJson(responseData);
      notifyListeners();
    } catch (error) {
      // Handle errors appropriately
      print('Error: $error');
    }
  }
}
