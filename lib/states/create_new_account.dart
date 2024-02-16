import 'package:expsugarone/utility/app_dialog.dart';
import 'package:expsugarone/widgets/widget_button.dart';
import 'package:expsugarone/widgets/widget_form.dart';
import 'package:expsugarone/widgets/widget_icon_button.dart';
import 'package:expsugarone/widgets/widget_image_asset.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Create New Account'),
      ),
      body: ListView(
        children: [
          displayImages(),
          Row(  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.7,
              
                child: Column(
                  children: [
                    WidgetForm(labelWidget: WidgetText(data: 'Display Name'),),
                    WidgetForm(labelWidget: WidgetText(data: 'Email'),),
                    WidgetForm(labelWidget: WidgetText(data: 'Password'),),
                    WidgetButton(
                      label: 'Create',
                      pressFunc: () {

                        
                      },
                    )
                  ],
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: WidgetImageAsset(
                  pathimg: 'images/avarta.png',
                  //  size: Get.width * 0.3,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: WidgetIconButton(
                  iconData: Icons.photo_camera,
                  pressFunc: () {

                    AppDialog().normalDailog(title: 'Camera or Gallary');

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
