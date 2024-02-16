// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:expsugarone/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.sufficWidget,
    this.obsecu,
    this.validatorFunc,
    this.labelWidget,
    this.textEditingController,
  }) : super(key: key);

  final String? hint;
  final Widget? sufficWidget;
  final bool? obsecu;
  final String? Function(String?)? validatorFunc;
  final Widget? labelWidget;

  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: textEditingController,
        validator: validatorFunc,
        obscureText: obsecu ?? false,
        decoration: InputDecoration(
          label: labelWidget,
          filled: true,
          fillColor: AppConstant.fieldColor,
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          border: InputBorder.none,
          hintText: hint,
          suffixIcon: sufficWidget,
        ),
      ),
    );
  }
}
