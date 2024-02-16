import 'dart:io';

import 'package:expsugarone/utility/app_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
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

  Future<void> processCreateNewAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => null)
        .catchError((onError) {
      Get.snackbar(onError.code, onError.message,
          backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
    });
  }
}
