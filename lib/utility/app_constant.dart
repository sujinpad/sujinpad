import 'package:expsugarone/widgets/body_list_user.dart';
import 'package:expsugarone/widgets/body_location.dart';
import 'package:expsugarone/widgets/body_porofile.dart';
import 'package:flutter/material.dart';

class AppConstant {
  //field ตัวแปรเดี่ยว สี ขนาดแชร์ให้ข้างบ้านใช้

  static List<String> titles = <String>[
    'List User',
    'My Location',
    'My Profile',
  ];

  static List<IconData> iconDatas = <IconData>[
    Icons.list,
    Icons.map,
    Icons.person
  ];

  static List<Widget> bodys = <Widget>[
    const BodyListUser(),
    const BodyLocation(),
    const BodyProfile(),
  ];

  static Color fieldColor = Colors.grey.withOpacity(0.5);

  static String urlAPI = 'http://110.164.149.104:9295/fapi/userFlutter';

  //method ตัวแปรกลุ่ม คล้ายๆ CSS

  TextStyle h1Style() {
    return const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }
}
