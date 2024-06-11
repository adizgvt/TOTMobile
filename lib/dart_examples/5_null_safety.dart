void main() {

  String pictureName1 = 'sample_picture.png';
  print(pictureName1);

  String? pictureName2;
  print(pictureName2);
  print(pictureName2 ?? 'default_picture.png');
  print(pictureName2!);
}