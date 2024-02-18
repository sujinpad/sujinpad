import 'dart:ffi';

import 'package:expsugarone/utility/app_controller.dart';
import 'package:expsugarone/utility/app_dialog.dart';
import 'package:expsugarone/utility/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRreader extends StatefulWidget {
  const QRreader({super.key});

  @override
  State<QRreader> createState() => _QRreaderState();
}

class _QRreaderState extends State<QRreader> {
  QRViewController? qrViewController;
  AppController appController = Get.put(AppController());

  final qrkey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();

    if (GetPlatform.isAndroid) {
      qrViewController!.pauseCamera();
    }

    if (GetPlatform.isIOS) {
      qrViewController!.resumeCamera();
    }
  }

// ย้ายปิดกล้องโทรสับ
  @override
  void dispose() {
    qrViewController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row( mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            height: 250,
            child: QRView(
              key: qrkey,
              onQRViewCreated: (p0) {
                qrViewController = p0;
                qrViewController!.scannedDataStream.listen((event) {
                  if (event.code != null) {
                    String result = event.code!;
                    qrViewController!.stopCamera();
          
                    AppService().findQRcode(qrCode: result).then((value) {

                      print('ค่า value --> $value');

                      if (value == null) {
          
                         print('ค่า result --> $result');
                        
                       
                        AppDialog().normalDailog(title: 'ไม่มีข้อมูล');
                      } else {
          
                        AppDialog().normalDailog(title: 'พบข้อมูล $result');
          
                      }
                    });
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
