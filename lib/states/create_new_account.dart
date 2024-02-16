import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/utility/app_dialog.dart';
import 'package:expsugarone/utility/app_service.dart';
import 'package:expsugarone/widgets/widget_button.dart';
import 'package:expsugarone/widgets/widget_form.dart';
import 'package:expsugarone/widgets/widget_icon_button.dart';
import 'package:expsugarone/widgets/widget_image_asset.dart';
import 'package:expsugarone/widgets/widget_image_file.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  AppController appController = Get.put(AppController());

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (appController.files.isNotEmpty) {
      appController.files.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Create New Account'),
      ),
      body: ListView(
        children: [
          displayImages(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.7,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      WidgetForm(
                        validatorFunc: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'โปรดกรอกชื่อด้วยนะจ๊ะ';
                          } else {
                            return null;
                          }
                        },
                        labelWidget: WidgetText(data: 'Display Name'),
                      ),
                      WidgetForm(
                        validatorFunc: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'โปรดE-mail ด้วยนะจ๊ะ';
                          } else {
                            return null;
                          }
                        },
                        labelWidget: WidgetText(data: 'Email'),
                      ),
                      WidgetForm(
                        validatorFunc: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'โปรด Passwordด้วยนะจ๊ะ';
                          } else {
                            return null;
                          }
                        },
                        labelWidget: WidgetText(data: 'Password'),
                      ),
                      WidgetButton(
                        label: 'Create',
                        pressFunc: () {
                          if (appController.files.isEmpty) {
                            Get.snackbar(
                              'ยังไม่มีรูปภาพ',
                              'เลือกรูปภาพ',
                              backgroundColor: GFColors.DANGER,
                              colorText:  GFColors.WHITE,
                            );
                          } else if (formKey.currentState!.validate()) {
                            
                          } 
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row displayImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width * 0.5,
          height: Get.width * 0.5,
          child: Stack(
            children: [
              Obx(() => Padding(
                  padding: EdgeInsets.all(16.0),
                  child: appController.files.isEmpty
                      ? WidgetImageAsset(
                          pathimg: 'images/avarta.png',
                          //  size: Get.width * 0.3,
                        )
                      : WidgetImageFile(
                          file: appController.files.last,
                          radias: Get.width * 0.5 * 0.5,
                        ))),
              Positioned(
                right: 0,
                bottom: 0,
                child: WidgetIconButton(
                  iconData: Icons.photo_camera,
                  pressFunc: () {
                    AppDialog().normalDailog(
                        title: 'Camera or Gallary',
                        iconWidget: const WidgetImageAsset(
                          pathimg: 'images/takefoto.png',
                          size: 150,
                        ),
                        contentWidget: const WidgetText(
                            data: 'โปรดถ่ายภาพหรือเลือกจากคลังภาพ'),
                        firstWidget: WidgetButton(
                          label: 'Camera',
                          pressFunc: () {
                            Get.back();
                            AppService().processTakephoto(
                                imageSource: ImageSource.camera);
                          },
                        ),
                        secondWidget: WidgetButton(
                          label: 'คลังภาพ',
                          pressFunc: () {
                            Get.back();
                            AppService().processTakephoto(
                                imageSource: ImageSource.gallery);
                          },
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
