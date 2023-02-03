import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  VoidCallback callback;
  String text;

  CustomRoundedButton({required this.callback, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: callback,
        child: Text(text, style: mTextStyle16(mColor: Theme.of(context).backgroundColor, fontWeight: FontWeight.w800),),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).canvasColor,
      ),
    );
  }
}
