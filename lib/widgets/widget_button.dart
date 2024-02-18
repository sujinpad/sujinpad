// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.gfButtonType,
    this.size,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final GFButtonType? gfButtonType;
final double? size;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: pressFunc,
      text: label,
      type: gfButtonType ?? GFButtonType.transparent,
      size: size ?? GFSize.MEDIUM,
    );
  }
}
