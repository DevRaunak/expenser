import 'package:flutter/material.dart';

class CustomLogoStack extends StatelessWidget {
  double mSize;

  CustomLogoStack(this.mSize);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            backgroundColor: Theme.of(context).canvasColor,
            radius: 50,
          ),
        ),
        Center(
            child: ImageIcon(
              AssetImage('assets/images/wallet_bw.png'),
              size: 50,
              color: Theme.of(context).backgroundColor,
            ))
      ],
    );
  }
}
