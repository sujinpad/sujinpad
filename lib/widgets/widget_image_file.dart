// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetImageFile extends StatelessWidget {
  const WidgetImageFile({
    Key? key,
    required this.file,
    this.radias,
  }) : super(key: key);

  final File file;
  final double? radias;

  @override
  Widget build(BuildContext context) {
    return GFAvatar(
      backgroundImage: FileImage(file),
      radius: radias,
    );
  }
}
