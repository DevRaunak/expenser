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

    print(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MediaQuery.of(context).size.height > 500
          ? mainUI()
          : SingleChildScrollView(
              child: mainUI(),
            ),
    );
  }

  Widget mainUI() {
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogoStack(width>500 ? 50 : 34 ),
            SizedBox(
              height: 21,
            ),
            Text(
              'Hello, Again',
              style: width > 500 ? mTextStyle43(
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
              style: width > 500 ? mTextStyle19(
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
            MediaQuery.of(context).size.width > 255 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create a new Account,',
                  style: width > 500 ? mTextStyle19(
                      fontWeight: FontWeight.w300,
                      mColor: Theme.of(context).shadowColor) : mTextStyle12(
                      fontWeight: FontWeight.w300,
                      mColor: Theme.of(context).shadowColor),
                ),
                TextButton(
                  onPressed: (){

                  },
                  child: Text(
                    'Sign-up now',
                    style: width > 500 ? mTextStyle19(
                        fontWeight: FontWeight.w300,
                        mColor: Theme.of(context).canvasColor) : mTextStyle12(
                        fontWeight: FontWeight.w300,
                        mColor: Theme.of(context).canvasColor),
                  ),
                ),
              ],
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create a new Account,',
                  style: width > 500 ? mTextStyle19(
                      fontWeight: FontWeight.w300,
                      mColor: Theme.of(context).shadowColor) : mTextStyle12(
                      fontWeight: FontWeight.w300,
                      mColor: Theme.of(context).shadowColor),
                ),
                TextButton(
                  onPressed: (){

                  },
                  child: Text(
                    'Sign-up now',
                    style: width > 500 ? mTextStyle19(
                        fontWeight: FontWeight.w300,
                        mColor: Theme.of(context).canvasColor) : mTextStyle12(
                        fontWeight: FontWeight.w300,
                        mColor: Theme.of(context).canvasColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
