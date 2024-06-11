import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main(){
  //simpleExceptionHandling();
  httpExceptionHandling();
}

simpleExceptionHandling(){
  try{
    List<int> sampleList = [0, 1, 2];
    print(sampleList[4]);
  }catch (e){
    print(e);
  }finally{

  }
}

httpExceptionHandling() async {
  try{
    print('loading Data');
    Response response = await http.get(Uri.parse('https://api.data.gov.my/weather/forecast?limit=3'));
    print(response.body);
    print('finished loading Data');
  }
  catch (e){
    print('Some error has occurred');
    print(e);
  }
}