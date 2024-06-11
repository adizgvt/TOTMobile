void main() {
  printInfo(gender: 'Male', name: 'John');
  printInfo(gender: 'Female', name: 'Suju');
  printInfo2(gender: 'Female', name: 'Suju');
  printInfo2(name: 'Suju');
}

void printInfo({required String name, required String gender}){
  print("Hello $name your gender is $gender");
}

void printInfo2({required String name, String gender = 'Male'}){
  print("Hello $name your gender is $gender");
}