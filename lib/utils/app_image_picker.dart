import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> pickImageGallery() async {
    XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    return image;
  }

  Future<XFile?> pickImageCamera() async {
    XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    return image;
  }
}
