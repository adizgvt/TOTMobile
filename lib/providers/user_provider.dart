import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training/services/flutter_local_storage_service.dart';

import '../constants.dart';
import '../helper_functions.dart';
import '../models/api_response.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider extends ChangeNotifier {

  User? user;

  Future<bool> login({required context, required Map<String, dynamic> formData}) async {

    ApiResponse response = await apiService(
        serviceMethod: ServiceMethod.post,
        path: '',
        login: true,
        data: formData
    );

    if(response.statusCode == 200) {
      user = userFromJson(jsonEncode(response.data));
      FlutterLocalStorageService.saveUserToken(token: user!.token);
      FlutterLocalStorageService.saveUserLoginDetails(username: formData['emel'], password: formData['password']);
      return true;
    }

    else{
      await showFailDialogTemplate(context: context, apiResponse: response);
      return false;
    }
    return true;
  }
}