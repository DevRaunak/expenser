import 'package:expenser/screens/user_onboarding/signup/signup_page.dart';
import 'package:expenser/ui/custom_widgets/custom_logo_stack.dart';
import 'package:expenser/ui/custom_widgets/custom_rounded_btn.dart';
import 'package:expenser/ui/custom_widgets/custom_text_field.dart';
import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';

import '../bottom_action.dart';

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

    print(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MediaQuery.of(context).orientation == Orientation.portrait ?
      MediaQuery.of(context).size.height > 500
          ? mainUI()
          : SingleChildScrollView(
              child: mainUI(),
            ) : Row(
        children: [
          Expanded(child: Container(
            color: Theme.of(context).brightness == Brightness.light ? MyColor.bgBColor : MyColor.bgWColor,
            child: CustomLogoStack(50),
          )),
          Expanded(
            flex: 1,
              child: MediaQuery.of(context).size.height > 500
              ? mainUI()
              : SingleChildScrollView(
            child: mainUI(),
          ))
        ],
      ),
    );
  }

  Widget mainUI() {
    var width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomLogoStack(constraints.maxWidth>500 ? 50 : 34 ),
              SizedBox(
                height: 21,
              ),
              Text(
                'Hello, Again',
                style: constraints.maxWidth > 500 ? mTextStyle43(
                    fontWeight: FontWeight.bold,
                    mColor: Theme.of(context).canvasColor) : mTextStyle26(
                    fontWeight: FontWeight.bold,
                    mColor: Theme.of(context).canvasColor),
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                'Welcome Back, you\'ve been missed',
                style: constraints.maxWidth > 500 ? mTextStyle19(
                    fontWeight: FontWeight.w300,
                    mColor: Theme.of(context).shadowColor) : mTextStyle12(
                    fontWeight: FontWeight.w300,
                    mColor: Theme.of(context).shadowColor),
              ),

              //////////////////////////////////////////Uname and Password Textfield/////////////////////////
              SizedBox(
                height: 21,
              ),
              CustomTextField(
                hint: 'Email here..',
                isPassword: false,
                mController: userNameController,
                mFillColor: Theme.of(context).brightness == Brightness.light
                    ? MyColor.secondaryWColor
                    : MyColor.secondaryBColor,
                mIcon: Icons.email_outlined,
              ),
              SizedBox(
                height: 11,
              ),
              CustomTextField(
                hint: 'Password here..',
                isPassword: true,
                mController: passController,
                mFillColor: Theme.of(context).brightness == Brightness.light
                    ? MyColor.secondaryWColor
                    : MyColor.secondaryBColor,
                mIcon: Icons.lock_outline,
              ),
              SizedBox(
                height: 25,
              ),
              CustomRoundedButton(callback: () {}, text: 'Login'),
              SizedBox(
                height: 11,
              ),
              constraints.maxWidth > 255 ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getChildren('Create a new Account, ', 'Sign-up now',(){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpPage(),));
                }, constraints.maxWidth, context),
              ) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getChildren('Create a new Account, ', 'Sign-up now',(){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpPage(),));
                }, constraints.maxWidth, context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
