import 'package:expsugarone/utility/app_constant.dart';
import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/utility/app_service.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyListArea extends StatefulWidget {
  const BodyListArea({super.key});

  @override
  State<BodyListArea> createState() => _BodyListAreaState();
}

class _BodyListAreaState extends State<BodyListArea> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().processReadAllArea();
  }

  Widget build(BuildContext context) {
    return Obx(() => appController.areaModels.isEmpty
        ? const SizedBox()
        : ListView.builder( padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: appController.areaModels.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetText(
                  data: appController.areaModels[index].nameArea,
                  textStyle: AppConstant().h2Style(),
                ),
                WidgetText(
                    data: AppService().convertTimeToString(
                        timestamp: appController.areaModels[index].timestamp)),
const Divider(color: Colors.black,)

              ],
            ),
          ));
  }
}
