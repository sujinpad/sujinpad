import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/utility/app_service.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyLocation extends StatefulWidget {
  const BodyLocation({super.key});

  @override
  State<BodyLocation> createState() => _BodyLocationState();
}

class _BodyLocationState extends State<BodyLocation> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().processFindLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.positions.isEmpty
        ? const SizedBox()
        : WidgetText(data: appController.positions.last.toString()));
  }
}
