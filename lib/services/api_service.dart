import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:training/services/flutter_local_storage_service.dart';
import '../constants.dart';
import '../models/api_response.dart';

Future<ApiResponse> apiService({
  Map<String, dynamic>? data,
  required ServiceMethod serviceMethod,
  required String path,
  bool login = false
}) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    http.Response response;
    //SET URL
    Uri uri = serviceMethod == ServiceMethod.get ? Uri.parse(domain + path).replace(queryParameters: data) : Uri.parse(domain + path);
    //SET HEADER
    Map<String, String> headers = <String, String>{'Accept': 'application/json'};
    //SET TOKEN
    if (login) {
      uri = Uri.parse('${domain}login');
    } else {
      String token = await FlutterLocalStorageService.getUserToken();
      headers['Authorization'] = 'Bearer $token';
    }
    //CHOOSE HTTP METHOD
    switch (serviceMethod) {
      case ServiceMethod.post:
        response = await http.post(uri, headers: headers, body: data);
        break;

      case ServiceMethod.put:
        response = await http.put(uri, headers: headers, body: data);
        break;

      case ServiceMethod.delete:
        response = await http.delete(uri, headers: headers, body: data);
        break;

      default:
        response = await http.get(uri, headers: headers,);
    }
    //PRINT LOGS
    if (kDebugMode) {
      print(uri);
      if(data != null) {
        print('------------------------REQUEST DATA--------------------------------');
        print(const JsonEncoder.withIndent('  ').convert(jsonDecode(jsonEncode(data))));
      }
      print('--------------------RESPONSE STATUS ${response.statusCode}-----------------------------');
      print(const JsonEncoder.withIndent('  ').convert(json.decode(response.body)));
      }
    //READING DATA AND MESSAGE
    apiResponse.statusCode = response.statusCode;
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data'];
        apiResponse.message = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.message = jsonDecode(response.body)['message'] ?? 'an error has occurred';
        apiResponse.errors = jsonDecode(response.body)['errors'] == null ? null : Errors.fromJson(jsonDecode(response.body)['errors']);
        break;
    }
  } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Exception: $e');
        print('Stacktrace: $stacktrace');
      }

      apiResponse.message = e.toString();

      //OVERWRITE MESSAGE IN CASE OF INTERNET CONNECTION ISSUE OR SERVER IS DOWN
      if(e.toString() == 'Connection failed') apiResponse.message = 'Please check your internet connection';
      if(e.toString() == 'Connection refused') apiResponse.message = 'Something wrong with the server';
  }
  return apiResponse;
}
