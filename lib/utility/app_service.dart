import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expsugarone/models/area_model.dart';
import 'package:expsugarone/models/respon_model.dart';
import 'package:expsugarone/models/user_api_model.dart';
import 'package:expsugarone/models/user_model.dart';
import 'package:expsugarone/states/main_home.dart';
import 'package:expsugarone/utility/app_constant.dart';
import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/utility/app_dialog.dart';
import 'package:expsugarone/widgets/widget_button.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
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

  Future<void> processCheckLonin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      context.loaderOverlay.hide();
      Get.offAll(const MainHome());
      Get.snackbar('Login Success', 'WelCome ${value.user!.uid}');
    }).catchError((onError) {
      context.loaderOverlay.hide();
      Get.snackbar(onError.code, onError.message,
          backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
    });
  }

  Future<void> processFindLocation() async {
    bool locationService = await Geolocator.isLocationServiceEnabled();

    if (locationService) {
      // open location

      LocationPermission locationPermission =
          await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        //deniedForever
        dailogCallPermission();
      } else {
        //Dened ,Alway , one
        if (locationPermission == LocationPermission.denied) {
          //Dened
          locationPermission = await Geolocator.requestPermission();
          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            dailogCallPermission();
          } else {
            Position position = await Geolocator.getCurrentPosition();
            appController.positions.add(position);
          }
        } else {
          // Alway , one
          Position position = await Geolocator.getCurrentPosition();
          appController.positions.add(position);
        }
      }
    } else {
      // close location
      AppDialog().normalDailog(
          title: 'Open Service',
          contentWidget: const WidgetText(data: 'เปิด Loation'),
          secondWidget: WidgetButton(
            label: 'Open Service',
            pressFunc: () async {
              await Geolocator.openLocationSettings();
              exit(0);
            },
          ));
    }
  }

  void dailogCallPermission() {
    AppDialog().normalDailog(
        title: 'Open Permission',
        secondWidget: WidgetButton(
          label: 'Open Permission',
          pressFunc: () async {
            await Geolocator.openAppSettings();
            exit(0);
          },
        ));
  }

  Future<void> processSaveArea(
      {required String nameArea, required List<LatLng> latlngs}) async {
    var geoPoint = <GeoPoint>[];
    for (var element in latlngs) {
      geoPoint.add(GeoPoint(element.latitude, element.longitude));
    }

    AreaModel areaModel = AreaModel(
      nameArea: nameArea,
      timestamp: Timestamp.fromDate(DateTime.now()),
      geoPoint: geoPoint,
      qrCode: 'srs${Random().nextInt(100000)}',
    );

    var user = FirebaseAuth.instance.currentUser;
    String uidLogin = user!.uid;

    print('##  uidLogin --> $uidLogin');
    print('##  areaModel --> ${areaModel.toMap()}');

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uidLogin)
        .collection('area')
        .doc()
        .set(areaModel.toMap())
        .then((value) {
      Get.snackbar('Add Success', 'ThankYou');
      appController.indexBody.value = 0;
    });
  }

  Future<void> processReadAllArea() async {
    var user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('area')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      if (appController.areaModels.isNotEmpty) {
        appController.areaModels.clear();
      }

      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          AreaModel areaModel = AreaModel.fromMap(element.data());

          appController.areaModels.add(areaModel);
        }
      }
    });
  }

  String convertTimeToString({required Timestamp timestamp}) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    String result = dateFormat.format(timestamp.toDate());
    return result;
  }

// AreaModel? = AreaModel ที่มีโอกาศเป็นค่า null
  Future<AreaModel?> findQRcode({required String qrCode}) async { 
    AreaModel? areaModel;
    var user = FirebaseAuth.instance.currentUser;


// วิธี where
    var response =
        // await FirebaseFirestore.instance.collection('user').doc(user!.uid).collection('area').where('qrcode',isEqualTo: qrCode).get();
        await FirebaseFirestore.instance.collection('user').doc(user!.uid).collection('area').where('qrCode',isEqualTo: qrCode).get();

if (response.docs.isNotEmpty) {
  for (var element in response.docs) {
    areaModel = AreaModel.fromMap(element.data());
  }
}
return areaModel;



  }
}
