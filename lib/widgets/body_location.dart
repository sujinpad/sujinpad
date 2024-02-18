import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/utility/app_dialog.dart';
import 'package:expsugarone/utility/app_service.dart';
import 'package:expsugarone/widgets/widget_button.dart';
import 'package:expsugarone/widgets/widget_form.dart';
import 'package:expsugarone/widgets/widget_icon_button.dart';
import 'package:expsugarone/widgets/widget_map.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BodyLocation extends StatefulWidget {
  const BodyLocation({super.key});

  @override
  State<BodyLocation> createState() => _BodyLocationState();
}

class _BodyLocationState extends State<BodyLocation> {
  AppController appController = Get.put(AppController());

  var latlngs = <LatLng>[];
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    appController.displaySave.value = false;
    appController.displayAddMarker.value = true;

    if (appController.mapMarkers.isNotEmpty) {
      appController.mapMarkers.clear();
    }

    if (appController.setPolygon.isNotEmpty) {
      appController.setPolygon.clear();
    }

    AppService().processFindLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.positions.isEmpty
        ? const SizedBox()
        : SizedBox(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                WidgetMap(
                  lat: appController.positions.last.latitude,
                  lng: appController.positions.last.longitude,
                  myLocationEnable: true,
                ),
                Positioned(
                  top: 32,
                  left: 32,
                  child: Column(
                    children: [
                      Obx(() => appController.displayAddMarker.value
                          ? WidgetIconButton(
                              iconData: Icons.add_box,
                              pressFunc: () {
                                AppService()
                                    .processFindLocation()
                                    .then((value) {
                                  print(
                                      appController.positions.last.toString());

                                  latlngs.add(LatLng(
                                      appController.positions.last.latitude,
                                      appController.positions.last.longitude));

                                  MarkerId markerId = MarkerId(
                                      'Id${appController.mapMarkers.length}');
                                  Marker marker = Marker(
                                      markerId: markerId,
                                      position: LatLng(
                                          appController.positions.last.latitude,
                                          appController
                                              .positions.last.longitude));

                                  appController.mapMarkers[markerId] = marker;
                                });
                              },
                              size: GFSize.LARGE,
                              gfButtonType: GFButtonType.outline2x,
                            )
                          : const SizedBox()),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => appController.mapMarkers.length >= 3
                          ? WidgetIconButton(
                              iconData: Icons.select_all,
                              pressFunc: () {
                                appController.displayAddMarker.value = false;

                                print(
                                    'ขนาดของจุดที่ต้องเขียนเส้น ---> ${latlngs.length}');

                                appController.setPolygon.add(Polygon(
                                  polygonId: PolygonId('id'),
                                  points: latlngs,
                                  fillColor: Colors.green.withOpacity(0.25),
                                  strokeColor: Colors.green.shade800,
                                  strokeWidth: 2,
                                ));

                                appController.mapMarkers.clear();
                                appController.displaySave.value = true;
                                setState(() {});
                              },
                              size: GFSize.LARGE,
                              gfButtonType: GFButtonType.outline2x,
                            )
                          : const SizedBox()),
                      Obx(() => appController.displaySave.value
                          ? WidgetIconButton(
                              iconData: Icons.save,
                              size: GFSize.LARGE,
                              pressFunc: () {
                                AppDialog().normalDailog(
                                    title: 'Confirm Save',
                                    contentWidget: Form(
                                      key: formKey,
                                      child: WidgetForm(
                                        textEditingController: nameController,
                                        validatorFunc: (p0) {
                                          if (p0?.isEmpty ?? true) {
                                            return 'กรุณากรอกชื่อพื้นทื่ด้วย';
                                          } else {
                                            return null;
                                          }
                                        },
                                        labelWidget:
                                          const  WidgetText(data: 'ชื่อพื้นที่ : '),
                                      ),
                                    ),
                                    firstWidget: WidgetButton(
                                      label: 'Save',
                                      pressFunc: () {
                                        if (formKey.currentState!.validate()) {
                                          Get.back();
                                          AppService().processSaveArea(
                                              nameArea: nameController.text,
                                              latlngs: latlngs);
                                        }
                                      },
                                    ));
                              },
                            )
                          : const SizedBox()),
                    ],
                  ),
                )
              ],
            ),
          ));
  }
}
