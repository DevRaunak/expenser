import 'package:flutter/material.dart';

import '../../ui/ui_helper.dart';

List<Widget> getChildren(title, subtitle, action, width, context){
  return [
    Text(
      title,
      style: width > 500 ? mTextStyle19(
          fontWeight: FontWeight.w300,
          mColor: Theme.of(context).shadowColor) : mTextStyle12(
          fontWeight: FontWeight.w300,
          mColor: Theme.of(context).shadowColor),
    ),
    TextButton(
      onPressed: action,
      child: Text(
        subtitle,
        style: width > 500 ? mTextStyle19(
            fontWeight: FontWeight.w300,
            mColor: Theme.of(context).canvasColor) : mTextStyle12(
            fontWeight: FontWeight.w300,
            mColor: Theme.of(context).canvasColor),
      ),
    ),
  ];
}
