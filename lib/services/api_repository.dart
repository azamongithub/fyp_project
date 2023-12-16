import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiRepository {
  static const String apiUrl = 'http://10.0.2.2:8000/predict_all';  // For Emulator
  //static const String apiUrl = 'http://192.168.1.16:8000/predict_all';
  //static const String apiUrl = 'http://127.0.0.1:8000/predict_all'; // For Postman

  Future<Map<String, dynamic>> fetchData(Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(Uri.parse(apiUrl), body: json.encode(requestData), headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        print('Response body is: ${response.body}');
        return json.decode(response.body);
      } else {
        print('Response body is: ${response.headers} & ${response.request}& ${response.contentLength}& ${response.reasonPhrase}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}



