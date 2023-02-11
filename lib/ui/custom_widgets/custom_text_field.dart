import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController? mController;
  Color mFillColor;
  IconData mIcon;
  bool isPassword;

  CustomTextField(
      {required this.mController,
      required this.mFillColor,
      required this.mIcon,
      required this.isPassword});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passVisible = false;

  @override
  Widget build(BuildContext context) {
    return widget.isPassword ? TextFormField(
      validator: (value){
        if(value==null || value.isEmpty){
          return "Please fill this Field!!";
        } else {
          return null;
        }
      },
      controller: widget.mController,
      obscureText: !passVisible,
      obscuringCharacter: "*",
      cursorColor: Theme.of(context).brightness==Brightness.light ? MyColor.textWColor : MyColor.textBColor,
      style: mTextStyle16(
          mColor: Theme.of(context).brightness == Brightness.light
              ? MyColor.textWColor
              : MyColor.textBColor),
      decoration: InputDecoration(
          prefixIcon: Icon(widget.mIcon),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: passVisible ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
              onPressed: (){

              },
            ),
          ),
          iconColor: Theme.of(context).backgroundColor,
          prefixIconColor: Theme.of(context).backgroundColor,
          fillColor: widget.mFillColor,
          filled: true,
          focusColor: Theme.of(context).backgroundColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).brightness==Brightness.light ? MyColor.textBColor : MyColor.textWColor
            ),
          ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).brightness==Brightness.light ? MyColor.textWColor : MyColor.textBColor
          ),
          borderRadius: BorderRadius.circular(21),
        ),
      ),

    ) : TextFormField(
      controller: widget.mController,
      cursorColor: Theme.of(context).brightness==Brightness.light ? MyColor.textWColor : MyColor.textBColor,
      style: mTextStyle16(
          mColor: Theme.of(context).brightness == Brightness.light
              ? MyColor.textWColor
              : MyColor.textBColor),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.mIcon),
        iconColor: Theme.of(context).backgroundColor,
        prefixIconColor: Theme.of(context).backgroundColor,
        fillColor: widget.mFillColor,
        filled: true,
        focusColor: Theme.of(context).backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
          borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).brightness==Brightness.light ? MyColor.textBColor : MyColor.textWColor
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).brightness==Brightness.light ? MyColor.textWColor : MyColor.textBColor
          ),
          borderRadius: BorderRadius.circular(21),
        ),
      ),

    );
  }
}
