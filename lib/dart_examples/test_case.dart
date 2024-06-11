void main(){

  List<Map<String, dynamic>> numbers = [
    {'value' : 1, 'expected' : true},
    {'value' : 2, 'expected' : false},
    {'value' : 3, 'expected' : true},
    {'value' : 4, 'expected' : false},
    {'value' : 5, 'expected' : true},
    {'value' : 6, 'expected' : false},
  ];

  numbers.forEach((element) {
    print('value: ${element['value']} is expected ${element['expected'] ? 'odd' : 'even'} \t| result = ${int.parse(element['value'].toString()).isOdd ? 'odd' : 'even'}');
  });
}