import 'package:expsugarone/widgets/widget_button.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  void normalDailog({
    required String title,
    Widget? iconWidget,
    Widget? contentWidget,
    Widget? firstWidget,
    Widget? secondWidget,
  }) {
    Get.dialog(AlertDialog(
      icon: iconWidget,
      title: WidgetText(data: title),
      content: contentWidget,
      actions: [
        firstWidget ?? const SizedBox(),
        secondWidget ??
            WidgetButton(
              label: 'OK',
              pressFunc: () => Get.back(),
            )
      ],
    ),barrierDismissible: false);
  }
}
