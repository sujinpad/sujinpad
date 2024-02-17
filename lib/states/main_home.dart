import 'package:expsugarone/utility/app_constant.dart';
import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  AppController appController = Get.put(AppController());
  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < AppConstant.bodys.length; i++) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(AppConstant.iconDatas[i]),
          label: AppConstant.titles[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: WidgetText(
                data: AppConstant.titles[appController.indexBody.value]),
          ),
          body: AppConstant.bodys[appController.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            type: BottomNavigationBarType.fixed,
            currentIndex: appController.indexBody.value,
            onTap: (value) {

              appController.indexBody.value = value;

            },
          ),
        ));
  }
}
