import 'package:expsugarone/utility/app_constant.dart';
import 'package:expsugarone/widgets/widget_form.dart';
import 'package:expsugarone/widgets/widget_image_asset.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 64),
                  width: 250,
                  child: Column(
                    children: [
                      displayLogoAndAppName(),
                      const WidgetForm(
                        hint: 'Email :',sufficWidget: Icon(Icons.email),
                      ),
                      const WidgetForm(
                        hint: 'Password :',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
