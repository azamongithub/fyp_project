import 'package:flutter/foundation.dart';
import '../../services/api_repository.dart';
import '../../services/firestore_service.dart';

class ApiProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic> _responseData = {};
  Map<String, dynamic> get responseData => _responseData;

  Future<void> fetchDataAndStore(Map<String, dynamic> requestData) async {
    try {
      _responseData = await _apiRepository.fetchData(requestData);
      await _firestoreService.storeUserData(_responseData);
      notifyListeners(); // Notify listeners about the change in state
    } catch (e) {
      print('Error: $e');
    }
  }
}
