import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  VoidCallback callback;
  String text;
  Widget? mChild;
  Color? borderColor;

  CustomRoundedButton({required this.callback, required this.text, this.mChild, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21),
                side: BorderSide(
                  color: borderColor ?? Colors.white,
                  width: borderColor !=null ? 2 : 0
                )
              ),
          primary: Theme.of(context).brightness == Brightness.light
              ? MyColor.secondaryBColor
              : MyColor.secondaryWColor,
        ),
        child: mChild ?? Text(
          text,
          style: mTextStyle16(
              mColor: Theme.of(context).backgroundColor,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
