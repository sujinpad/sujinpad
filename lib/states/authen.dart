import 'package:expsugarone/states/create_new_account.dart';
import 'package:expsugarone/utility/app_constant.dart';
import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/widgets/widget_button.dart';
import 'package:expsugarone/widgets/widget_form.dart';
import 'package:expsugarone/widgets/widget_icon_button.dart';
import 'package:expsugarone/widgets/widget_image_asset.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Dependency get call Rx
  AppController appController = Get.put(AppController());

//key ที่ใช้ในการเช็ค validate
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 64),
                  width: 250,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        displayLogoAndAppName(),
                        emailForm(),
                        passwordForm(),
                        loginButton()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: WidgetButton(
        label: 'Create New Accout',
        pressFunc: () {
          Get.to(const CreateNewAccount());
        },
        gfButtonType: GFButtonType.transparent,
      ),
    );
  }

  Container loginButton() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: WidgetButton(
        label: 'login',
        pressFunc: () {
          if (formKey.currentState!.validate()) {
            
          }
        },
      ),
    );
  }

  Obx passwordForm() {
    return Obx(() => WidgetForm(validatorFunc: (p0) {
        if (p0?.isEmpty ?? true) {
          return 'กรอกรหัสด้วยนะจ๊ะ';
        } else {
          return null;
        }
    },
          hint: 'Password :',
          obsecu: appController.redEye.value,
          sufficWidget: WidgetIconButton(
            iconData: appController.redEye.value
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined,
            pressFunc: () {
              appController.redEye.value = !appController.redEye.value;
            },
          ),
        ));
  }

  WidgetForm emailForm() {
    return WidgetForm(
      validatorFunc: (p0) {
        if (p0?.isEmpty ?? true) {
          return 'กรอกอีเมล์ด้วยนะจ๊ะ';
        } else {
          return null;
        }
      },
      hint: 'Email :',
      sufficWidget: Icon(Icons.email),
    );
  }

  Row displayLogoAndAppName() {
    return Row(
      children: [
        displayImage(),
        WidgetText(
          data: 'App Authen',
          textStyle: AppConstant().h2Style(),
        )
      ],
    );
  }

  WidgetImageAsset displayImage() {
    return const WidgetImageAsset(
      pathimg: 'images/logo.png',
      size: 48,
    );
  }
}
