class PickedImage {
  String extension;
  String base64EncodedString;
  int size;

  PickedImage({
    required this.base64EncodedString,
    required this.extension,
    required this.size
  });
}