import 'dart:io';

main(){

  //----------------------------------------------
  //BASIC
  int number = 0;
  print(number);

  double sampleDouble = 0;
  print(sampleDouble);

  String sampleText = 'This is an example';
  print(sampleText);

  bool isWeekday = true;

  //----------------------------------------------
  //INTERMEDIATE
  DateTime sampleDateTime = DateTime(2024,1,1);
  print(sampleDateTime);

  List<dynamic> sampleList1 = [0, 'sample text'];
  List<int> sampleList2 = [0, 1];
  List<int> sampleList3 = [];

  Uri sampleUri = Uri.parse('www.samplewebsite.com/sample directory');
  print(sampleUri);

  Map map = <String, String> {
    'Key1': 'Value1',
    'Key2': 'Value2',
  };
  //----------------------------------------------
  //NO TYPE
  var x;
  x = 10;
}