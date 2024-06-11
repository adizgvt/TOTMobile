void main() {
  SampleClass.method1();
  SampleClass.method2();
}

abstract class SampleClass{

  static method1(){
    print('running method 1');
  }

  static method2(){
    print('running method 2');
  }
}