import 'package:expsugarone/utility/app_service.dart';
import 'package:expsugarone/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class BodyLocation extends StatefulWidget {
  const BodyLocation({super.key});

  @override
  State<BodyLocation> createState() => _BodyLocationState();
}

class _BodyLocationState extends State<BodyLocation> {

  @override
  void initState() {
    super.initState();
    
    AppService().processFindLocation();


  }
  @override
  Widget build(BuildContext context) {
    return WidgetText(data: 'List_location');
  }
}