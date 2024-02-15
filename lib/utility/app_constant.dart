import 'package:flutter/material.dart';

class AppConstant {
  //field ตัวแปรเดี่ยว สี ขนาดแชร์ให้ข้างบ้านใช้

  static Color fieldColor = Colors.grey.withOpacity(0.5);

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
