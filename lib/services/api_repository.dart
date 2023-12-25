import 'dart:convert';
import 'package:CoachBot/constants/api_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  Future<Map<String, dynamic>> fetchData(
      Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(Uri.parse(ApiConstant.predictAllApi),
          body: json.encode(requestData),
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response body is: ${response.body}');
        }
        return json.decode(response.body);
      } else {
        print(
            'Response body is: ${response.headers} & ${response.request}& ${response.contentLength}& ${response.reasonPhrase}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
