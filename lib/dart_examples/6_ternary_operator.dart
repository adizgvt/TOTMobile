void main(){

  bool x = false;
  x == false ? print('X is false') : print('X is true');
  print('X is ${x== false ? 'false' : 'true'}');
  print('X is ${x ? 'false' : 'true'}');

  bool isLoading = false;
  bool isDataEmpty = true;

  isLoading ? print('Loading Data') : isDataEmpty ? print('List Data Empty') : print('Showing Data');
}