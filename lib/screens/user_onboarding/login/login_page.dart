import 'package:expenser/screens/home/home_page.dart';
import 'package:expenser/screens/user_onboarding/signup/signup_page.dart';
import 'package:expenser/ui/custom_widgets/custom_logo_stack.dart';
import 'package:expenser/ui/custom_widgets/custom_rounded_btn.dart';
import 'package:expenser/ui/custom_widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../ui/ui_helper.dart';
import '../bottom_action.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userNameController = TextEditingController();
  var passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    print(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MediaQuery.of(context).orientation == Orientation.portrait ?
      portraitLay() : landscapeLay(),
    );
  }

  Widget mainUI() {
    //var width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLogoStack(mSize: constraints.maxWidth>500 ? 50 : 34, mBgColor: Theme.of(context).canvasColor, mIconColor: Theme.of(context).backgroundColor),
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
                CustomRoundedButton(callback: () {

                  if(userNameController.text.toString().isNotEmpty
                      && passController.text.toString().isNotEmpty){
                    // Login process
                  } else {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Stop"),
                        content: Text("Please Fill all the required blanks!!"),
                      );
                    });
                  }

                  if(_formKey.currentState!.validate()){
                    //if true
                    //Login successful

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                  }




                  /*if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Row(
                        children: [
                          Icon(Icons.downloading, color: Theme.of(context).brightness == Brightness.light ? MyColor.bgWColor : MyColor.bgBColor,),
                          SizedBox(width: 11,),
                          Text('Processing Data'),
                        ],
                      )),
                    );

                    Fluttertoast.showToast(
                        msg: "This is Center Short Toast",
                        toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 1,
                      gravity: ToastGravity.BOTTOM
                    );
                  }*/
                }, text: 'Login'),
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
      ),
    );
  }

  Widget portraitLay(){
    return MediaQuery.of(context).size.height > 500
        ? mainUI()
        : SingleChildScrollView(
      child: mainUI(),
    );
  }

  Widget landscapeLay(){
    return Row(
      children: [
        Expanded(child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).brightness == Brightness.light ? MyColor.bgBColor : MyColor.bgWColor,
          child: Center(child: CustomLogoStack( mSize: 50, mBgColor: Theme.of(context).backgroundColor, mIconColor: Theme.of(context).canvasColor)),
        )),
        Expanded(
            child: MediaQuery.of(context).size.height > 500
                ? mainUI()
                : SingleChildScrollView(
              child: mainUI(),
            ))
      ],
    );
  }
}
