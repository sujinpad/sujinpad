// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetImageAsset extends StatelessWidget {
  const WidgetImageAsset({
    Key? key,
    required this.pathimg,
    this.size,
  }) : super(key: key);

  final String pathimg;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      pathimg,
      width: size,
      height: size,
    );
  }
}
