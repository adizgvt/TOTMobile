import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/getwidget.dart';

import 'models/api_response.dart';

printOnlyInDebug(var data) {
  if (kDebugMode) {
    log(data);
  }
}

apiCallErrorTemplate({required BuildContext context, required errorMessage, required onRefresh}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              errorMessage,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          GFButton(
            text: 'Refresh page',
            type: GFButtonType.solid,
            size: GFSize.LARGE,
            color: GFColors.PRIMARY,
            onPressed: onRefresh,
            icon: const Icon(
              Icons.refresh,
              color: GFColors.WHITE,
            ),
          ),
        ],
      ),
    );
}

apiCallLoadingTemplate({required BuildContext context}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.75,
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Loading...'),
        ),
      ],
    ),
  );
}


apiCallNoDataTemplate({required BuildContext context, required onRefresh}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.75,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 20,
            ),
            SizedBox(width: 10,),
            Text('No data found.')
          ],
        ),
        const SizedBox(height: 10,),
        GFButton(
          text: 'Refresh page',
          type: GFButtonType.solid,
          size: GFSize.LARGE,
          color: GFColors.PRIMARY,
          onPressed: onRefresh,
          icon: const Icon(
            Icons.refresh,
            color: GFColors.WHITE,
          ),
        ),
      ],
    ),
  );
}

appBarTemplate({required String title}){
  return GFAppBar(
    brightness: Brightness.dark,
    backgroundColor: GFColors.DARK,
    title: Text(title.toUpperCase(), style: const TextStyle(fontSize: 18),),
    centerTitle: true,
  );
}

frostedBackground() {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: NetworkImage('https://www.shutterstock.com/image-vector/newspaper-background-torn-paper-style-600nw-2261765635.jpg')
        )
    ),
    child: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.2)),
          child: Container(),
        ),
      ),
    ),
  );
}

inputDecorationTemplate({String? hintText}){
  return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: GFColors.DARK),
      labelText: '',
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none
      ),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: GFColors.PRIMARY, width: 1.0, style: BorderStyle.solid)
      ),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: GFColors.DANGER, width: 1.0, style: BorderStyle.solid)
      )
      //focusedBorder: InputBorder.none
  );
}

showSuccessDialogTemplate(
    {required BuildContext context,
      String titleText = 'BERJAYA',
      required ApiResponse apiResponse}) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(
            titleText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(apiResponse.message.toString()),
          actions: [
            GFButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('OK'),
            )
          ],
        ),
      ));
}

showWarningDialogTemplate(
    {required BuildContext context,
      String titleText = 'Amaran',
      required String message}) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(
            titleText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: [
            GFButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              color: GFColors.DANGER,
              child: const Text('BATAL'),
            ),
            GFButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('TERUSKAN'),
            ),
          ],
        ),
      ));
}

showFailDialogTemplate(
    {required BuildContext context, String titleText = 'Ralat', required ApiResponse apiResponse}) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(
            titleText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(
              '${apiResponse.errors == null ? apiResponse.message : ''}\n${apiResponse.errors == null ? '' : apiResponse.errors!.error.toString()}'),
          actions: [
            GFButton(
              color: GFColors.DANGER,
              onPressed: () {
                Navigator.pop(context, true);
                /*if (apiResponse.statusCode == 401) {
                  //laravel unauthenticated request returns 401 status code
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false);
                }*/
              },
              child: const Text('OK'),
            )
          ],
        ),
      ));
}

scrollAndFocusForBackendValidation({
  required ApiResponse response,
  required GlobalKey<FormBuilderState> formKey,
  required ScrollController scrollController
}){
  final errorMap = response.errors?.errorMap;
  if(errorMap != null){
    try{
      errorMap.forEach((key, value) {
        print('key is $key');
        print('offset');
        print(formKey.currentState!.fields[key]!.effectiveFocusNode.offset.dy);
        formKey.currentState!.fields[key]!.invalidate(value.first);

      });

      formKey.currentState!.fields[errorMap.keys.first]!.focus();
      scrollController.animateTo(
          formKey.currentState!.fields[errorMap.keys.first]!.effectiveFocusNode.offset.dy.abs(),
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease
      );

    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

abstract class CustomErrorText {
  static String maxLength(val) => 'Maksimum $val huruf';
  static String minLength(val) => 'Minimum $val huruf';
  static String requiredContent() => 'Sila isikan content';
  static String requiredThumbnail() => 'Sila pilih thumbnail';
}
