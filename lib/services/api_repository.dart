// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//
//   static const String apiUrl = 'http://127.0.0.1:8000/predict_all';
//   Future<Map<String, dynamic>> postApiData(Map<String, dynamic> body) async {
//
//
//
//     final response = await http.post(
//       apiUrl,
//       body: jsonEncode(body),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//
//
// }


import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiRepository {
  static const String apiUrl = 'http://10.0.2.2:8000/predict_all';

  Future<Map<String, dynamic>> fetchData(Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(Uri.parse(apiUrl), body: json.encode(requestData), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}



