
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage({required ImageSource source}) async {
    return _picker.pickImage(source: source);
  }
}
