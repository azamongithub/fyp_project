// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
//
// class ApiHelper {
//   final String _authToken = 'ApiConstant.token';
//
//   Future<dynamic> get(String endpoint, {String? body, String? token,}) async {
//     HttpClient client = HttpClient();
//     client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
//     final Uri url = Uri.parse(endpoint);
//     try {
//       final response = await http.get(url,
//           headers:{
//             'Accept': 'application/json; charset=UTF-8',
//             'Content-Type': 'application/json; charset=UTF-8',
//             'Authorization': 'Bearer $_authToken'
//           });
//       return response;
//     } catch (e) {
//       throw Exception('Failed to perform GET request: $e');
//     }
//   }
//
//
//   Future<dynamic> post(String endpoint, dynamic body, {String? token}) async {
//     final Uri url = Uri.parse(endpoint);
//     final headers = <String, String>{
//       'Accept': 'application/json; charset=UTF-8',
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': "Bearer $_authToken",
//     };
//     try {
//       final response =
//       await http.post(url, headers: headers, body: jsonEncode(body));
//       return response;
//     } catch (e) {
//       throw Exception('Failed to perform POST request: $e');
//     }
//   }
//
//   Future<dynamic> postMultipart(String endpoint,
//       Map<String, String> fields, List<String> files,
//       {String? token}) async {
//     final request = http.MultipartRequest('POST', Uri.parse(endpoint));
//     request.headers.addAll(token != null
//         ? {
//       'Accept': 'application/json; charset=UTF-8',
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer $token'
//     }
//         : <String, String>{
//       'Accept': 'application/json; charset=UTF-8',
//       'Content-Type': 'application/json; charset=UTF-8'
//     });
//     request.fields.addAll(fields);
//     for (int i = 0; i < files.length; i++) {
//       var file = files[i];
//       if(file.isNotEmpty && file != '') {
//
//         request.files.add(await http.MultipartFile.fromPath('pictures[]', file));
//       }
//     }
//
//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);
//
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       if (kDebugMode) {
//         print("Response of Mutipart request ${response.body}");
//       }
//       return response;
//     } else {
//       throw Exception('Failed to upload files to the API');
//     }
//   }
//
//   Future<dynamic> putRequest(String endpoint, Map<String, dynamic> body,
//       {Map<String, String>? headers}) async {
//     final url = Uri.parse(endpoint);
//     final encodedBody = jsonEncode(body);
//     try {
//       final response = await http.put(url, body: encodedBody, headers: headers);
//       return response;
//     } catch (e) {
//       throw Exception('Failed to perform PUT request: $e');
//     }
//   }
//
//   Future<dynamic> deleteRequest(String endpoint,
//       {Map<String, String>? headers}) async {
//     final url = Uri.parse(endpoint);
//     try {
//       final response = await http.delete(url, headers: headers);
//       return response;
//     } catch (e) {
//       throw Exception('Failed to perform DELETE request: $e');
//     }
//   }
// }
