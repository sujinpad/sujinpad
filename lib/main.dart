import 'package:expsugarone/states/authen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp().then((value) {
 runApp(const MyApp());
});



}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: Authen(),);
  }


}