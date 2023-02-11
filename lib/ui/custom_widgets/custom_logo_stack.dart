import 'package:flutter/material.dart';

class CustomLogoStack extends StatelessWidget {
  double mSize;
  Color mBgColor;
  Color mIconColor;

  CustomLogoStack({required this.mSize, required this.mBgColor, required this.mIconColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: mBgColor,
        radius: mSize,
        child: Center(
            child: ImageIcon(
              AssetImage('assets/images/wallet_bw.png'),
              size: mSize,
              color: mIconColor,
            )),
      ),
    );
  }
}
