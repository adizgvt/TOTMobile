import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:training/models/api_response.dart';
import 'package:training/models/article.dart';
import 'package:training/services/api_service.dart';
import '../constants.dart';
import '../helper_functions.dart';

class ArticleProvider extends ChangeNotifier {

  Future<List<Article>> getArticleList() async{

    ApiResponse response = await apiService(
        serviceMethod: ServiceMethod.get,
        path: 'index'
    );

    if(response.statusCode != 200) throw(response.message!);

    List<Article> articles = articleFromJson(jsonEncode(response.data));

    return articles;
  }

  Future<Article> getArticle({required int articleId}) async{

    ApiResponse response = await apiService(
        serviceMethod: ServiceMethod.get,
        path: 'show-article/$articleId'
    );

    if(response.statusCode != 200) throw(response.message!);

    Article article = Article.fromJson(response.data as Map<String,dynamic>);

    return article;
  }

  Future<List<dynamic>> createArticle() async{

    ApiResponse response = await apiService(
        serviceMethod: ServiceMethod.get,
        path: 'create-article'
    );

    if(response.statusCode != 200) throw(response.message!);

    List<dynamic> categories = response.data as List<dynamic>;

    return categories;
  }

  Future<bool> storeArticle({
    required context,
    required Map<String,dynamic> formData,
    required GlobalKey<FormBuilderState> formKey,
    required ScrollController scrollController
  }) async {

    ApiResponse response = await apiService(
        serviceMethod: ServiceMethod.post,
        path: 'store-article',
        data: formData
    );

    if(response.statusCode == 200) {
      await showSuccessDialogTemplate(context: context, apiResponse: response);
      return true;
    }

    else{
      scrollAndFocusForBackendValidation(response: response, formKey: formKey, scrollController: scrollController);
      await showFailDialogTemplate(context: context, apiResponse: response);
      return false;
    }
  }

  Future<bool> deleteArticle({required context, required int articleId}) async {

    ApiResponse response = await apiService(
        serviceMethod: ServiceMethod.delete,
        path: 'delete-article/$articleId',
    );

    if(response.statusCode == 200) {
      await showSuccessDialogTemplate(context: context, apiResponse: response);
      return true;
    }

    else{
      await showFailDialogTemplate(context: context, apiResponse: response);
      return false;
    }
  }
}