import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? mController;
  Color mFillColor;
  IconData mIcon;

  CustomTextField({required this.mController, required this.mFillColor, required this.mIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mController,
      style: mTextStyle16(),
      decoration: InputDecoration(
        prefixIcon: Icon(mIcon),
        iconColor: Theme.of(context).backgroundColor,
        prefixIconColor: Theme.of(context).backgroundColor,
        fillColor: mFillColor,
        filled: true,
        focusColor: Theme.of(context).backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
        )
      ),
    );
  }
}
