import 'dart:io';

import 'package:expsugarone/utility/app_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processTakephoto({required ImageSource imageSource}) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (result != null) {
      appController.files.add(File(result.path));
    }
  }
}
