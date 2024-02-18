// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.iconData,
    required this.pressFunc,
    this.size,
    this.gfButtonType,
  }) : super(key: key);

  final IconData iconData;
  final Function() pressFunc;
final double? size;
final GFButtonType? gfButtonType;
  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(iconData),
      onPressed: pressFunc,
      type: GFButtonType.transparent,
      size: size ?? GFSize.MEDIUM ,
    );
  }
}
