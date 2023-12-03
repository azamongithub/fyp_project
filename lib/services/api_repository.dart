import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  Future<Map<String, dynamic>> postApiData(Map<String, dynamic> body) async {
    final Uri url = Uri.parse('http://127.0.0.1:8000/predict_all_predict_all_post');

    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }



}
