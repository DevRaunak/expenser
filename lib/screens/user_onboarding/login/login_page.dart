import 'package:expenser/ui/custom_widgets/custom_logo_stack.dart';
import 'package:expenser/ui/custom_widgets/custom_rounded_btn.dart';
import 'package:expenser/ui/custom_widgets/custom_text_field.dart';
import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userNameController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 21, right: 21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomLogoStack(34),
              SizedBox(
                height: 21,
              ),
              Text(
                'Hello, Again',
                style: mTextStyle43(
                    fontWeight: FontWeight.bold,
                    mColor: Theme.of(context).canvasColor),
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                'Welcome Back, you\'ve been missed',
                style: mTextStyle19(
                    fontWeight: FontWeight.w300,
                    mColor: Theme.of(context).shadowColor),
              ),

              //////////////////////////////////////////Uname and Password Textfield/////////////////////////
              SizedBox(
                height: 21,
              ),
              CustomTextField(
                  mController: userNameController,
                  mFillColor: Theme.of(context).canvasColor,
                mIcon: Icons.email_outlined,
              ),
              SizedBox(
                height: 11,
              ),
              CustomTextField(
                  mController: passController,
                  mFillColor: Theme.of(context).canvasColor,
                mIcon: Icons.lock_outline,
              ),
              SizedBox(
                height: 11,
              ),
              CustomRoundedButton(callback: (){}, text: 'Login')
            ],
          ),
        ),
      ),
    );
  }
}
