import 'dart:convert';
import 'dart:io';
import '../models/image_data.dart';
import 'package:image_picker/image_picker.dart';

abstract class GalleryService {

  static Future<PickedImage?> getPicture({ImageSource imageSource = ImageSource.gallery}) async {

    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(source: imageSource, imageQuality: 100);

    if(imagePicked == null) {
      return null;
    }

    XFile xFileFormat = XFile(File(imagePicked.path).path);

    return PickedImage(
        base64EncodedString: base64Encode(await xFileFormat.readAsBytes()),
        extension: imagePicked.path.split('.').last,
        size: await xFileFormat.length()
    );
  }
}