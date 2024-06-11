import 'dart:io';

import 'email_list.dart';
import 'package:http/http.dart' as http;

void main(){
  emails.forEach((element) async {

    Uri uri = Uri.parse('https://aimsglobal.com.my:2083/execute/Email/passwd_pop')
              .replace(queryParameters: {'email': element, 'password' : 'Aims@123456'});
    try{
      http.Response response = await http.post(
        uri,
        headers: <String, String> {
          'Authorization' : 'cpanel aimsglob:8LNYNSJIN7SATE8OWHPC8IGC27FXGJZY',
          'Accept' : 'application/json',
        }
      );
      print('--------------------------');
      print(uri);
      print(element);
      print(response.statusCode);
      print(response.body);

    }catch (e) {
      print(e.toString());
    }
    sleep(Duration(seconds: 10));
  });
}