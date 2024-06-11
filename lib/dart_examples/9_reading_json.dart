import 'dart:convert';

void main() {
  String sampleJson = '{'
      '"widget":{'
        '"debug":"on","'
        'window":{'
          '"title":"SampleKonfabulatorWidget",'
          '"name":"main_window",'
          '"width":500,"height":500},'
          '"image":{'
            '"src":"Images/Sun.png",'
            '"name":"sun1",'
            '"hOffset":250,'
            '"vOffset":250,'
            '"alignment":"center"'
            '},'
          '"text":{'
            '"data":"ClickHere",'
            '"size":36,'
            '"style":"bold",'
            '"name":"text1",'
            '"hOffset":250,'
            '"vOffset":100,'
            '"alignment":"center",'
            '"onMouseUp":"sun1.opacity=(sun1.opacity/100)*90;"}'
          '}'
        '}';

  final prettyString = const JsonEncoder.withIndent('  ').convert(json.decode(sampleJson));

  print(prettyString);

  var decodedJson = jsonDecode(sampleJson);
  print(decodedJson['widget']['window']['title']);
}