import 'package:expenser/screens/home/home_page.dart';
import 'package:expenser/screens/splash/splash_page.dart';
import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: createMaterialColor(MyColor.bgBColor),
            backgroundColor: MyColor.bgBColor,
            canvasColor: MyColor.bgWColor,
            shadowColor: MyColor.lightTextBColor),
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: createMaterialColor(MyColor.bgWColor),
            backgroundColor: MyColor.bgWColor,
            canvasColor: MyColor.bgBColor,
            shadowColor: MyColor.lightTextWColor),
        home: HomePage());
  }
}
