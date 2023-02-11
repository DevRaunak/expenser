import 'package:expenser/screens/user_onboarding/bottom_action.dart';
import 'package:expenser/screens/user_onboarding/login/login_page.dart';
import 'package:flutter/material.dart';

import '../../../ui/custom_widgets/custom_logo_stack.dart';
import '../../../ui/custom_widgets/custom_rounded_btn.dart';
import '../../../ui/custom_widgets/custom_text_field.dart';
import '../../../ui/ui_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? portraitLay()
            : landscapeLay());
  }

  Widget mainUI() {
    var width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.maxWidth);
        print(constraints.minWidth);
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(21),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomLogoStack(mSize: constraints.maxWidth > 500 ? 50 : 34, mBgColor: Theme.of(context).canvasColor, mIconColor: Theme.of(context).backgroundColor),
                  SizedBox(
                    height: 21,
                  ),
                  Text(
                    'Get Started',
                    style: constraints.maxWidth > 500
                        ? mTextStyle43(
                        fontWeight: FontWeight.bold,
                        mColor: Theme.of(context).canvasColor)
                        : mTextStyle26(
                        fontWeight: FontWeight.bold,
                        mColor: Theme.of(context).canvasColor),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    'Start managing your Expense Today!',
                    style: constraints.maxWidth > 500
                        ? mTextStyle19(
                        fontWeight: FontWeight.w300,
                        mColor: Theme.of(context).shadowColor)
                        : mTextStyle12(
                        fontWeight: FontWeight.w300,
                        mColor: Theme.of(context).shadowColor),
                  ),

                  //////////////////////////////////////////Uname and Password Textfield/////////////////////////
                  SizedBox(
                    height: 21,
                  ),
                  CustomTextField(
                    isPassword: false,
                    mController: nameController,
                    mFillColor: Theme.of(context).brightness == Brightness.light
                        ? MyColor.secondaryWColor
                        : MyColor.secondaryBColor,
                    mIcon: Icons.account_circle_outlined,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  CustomTextField(
                    isPassword: false,
                    mController: emailController,
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
                    height: 11,
                  ),
                  CustomTextField(
                    isPassword: true,
                    mController: confirmPassController,
                    mFillColor: Theme.of(context).brightness == Brightness.light
                        ? MyColor.secondaryWColor
                        : MyColor.secondaryBColor,
                    mIcon: Icons.lock_outline,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomRoundedButton(callback: () {

                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }

                  }, text: 'Sign-up'),
                  SizedBox(
                    height: 11,
                  ),
                  if (constraints.maxWidth > 400)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      getChildren('Already have an Account, ', 'Login now', () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      }, constraints.maxWidth, context),
                    )
                  else
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      getChildren('Already have an Account, ', 'Login now', () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      }, constraints.maxWidth, context),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget portraitLay(){
    return MediaQuery.of(context).size.height > 700
        ? mainUI()
        : SingleChildScrollView(
      child: mainUI(),
    );
  }

  Widget landscapeLay(){
    return Row(
      children: [
        Expanded(
            child: Container(
              child: Center(
                child: CustomLogoStack( mSize: 50, mBgColor: Theme.of(context).backgroundColor, mIconColor: Theme.of(context).canvasColor),
              ),
              color: Theme.of(context).brightness == Brightness.light
                  ? MyColor.bgBColor
                  : MyColor.bgWColor,
            )),
        Expanded(
            child: MediaQuery.of(context).size.height > 700
                ? mainUI()
                : SingleChildScrollView(child: mainUI()))
      ],
    );
  }

}
