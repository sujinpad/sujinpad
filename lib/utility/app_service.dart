import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expsugarone/models/respon_model.dart';
import 'package:expsugarone/models/user_api_model.dart';
import 'package:expsugarone/models/user_model.dart';
import 'package:expsugarone/utility/app_constant.dart';
import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/utility/app_dialog.dart';
import 'package:expsugarone/widgets/widget_button.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:loader_overlay/loader_overlay.dart';

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
    required BuildContext context,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      String uid = value.user!.uid;
      print('uid :$uid');

      //procress upload img to storege
      String nameFile = '$uid.jpg';

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      Reference reference = firebaseStorage.ref().child('avarta/$nameFile');

      UploadTask uploadTask = reference.putFile(appController.files.last);

      await uploadTask.whenComplete(() async {
        String? urlImage = await reference.getDownloadURL();
        print('uploade $urlImage Suscess');

        UserModel userModel = UserModel(
            uid: uid,
            name: name,
            email: email,
            password: password,
            urlImage: urlImage);

        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .set(userModel.toMap())
            .then((value) async {
          print('insert success');

          UserApiModel userApiModel = UserApiModel(
              name: name,
              email: email,
              password: password,
              fuidstr: uid,
              bod: DateTime.now().toString(),
              picurl: urlImage);

          await dio.Dio()
              .post(AppConstant.urlAPI, data: userApiModel.toMap())
              .then((value) {
            if (value.statusCode == 200) {
              ResponModel responModel = ResponModel.fromMap(value.data);

              AppDialog().normalDailog(
                  title: 'Create Success',
                  contentWidget: WidgetText(data: responModel.message),
                  secondWidget: WidgetButton(
                    label: 'Thank You',
                    pressFunc: () {
                      context.loaderOverlay.hide();
                      Get.back();
                      Get.back();
                    },
                  ));
            } else {}
          });
        });
      });
    }).catchError((onError) {
      context.loaderOverlay.hide();
      Get.snackbar(onError.code, onError.message,
          backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
    });
  }
}
