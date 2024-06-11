import 'dart:convert';

void main(){
  //Instantiate an object;
  //ClassName objectName = ClassName();
  Point point1 = Point(x: 0, y: 1);
  Point point2 = Point(x: 2, y: 4);
  Point point3 = Point(x: 3, y: 6);
  point1.printCoordinates();

  List<Point> points = [point1, point2, point3];
}

class Point {

  static int totalPoints = 0;
  double x = 0;
  double y = 0;

  // Generative constructor with initializing formal parameters:
  Point({this.x = 0, this.y = 0}){
   totalPoints++;
  }

  //method
  printCoordinates() {
    print('x = ${x}, y = ${y}');  
  }

  static printTotalPoints() {
    print('Total points is $totalPoints');
  }
}