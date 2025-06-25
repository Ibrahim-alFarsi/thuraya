import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:thuraya_app/splash_screen.dart';
import 'package:thuraya_app/utils/color_category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //This is the main app, and I have added the
  //comment for the first time
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        dialogTheme: DialogThemeData(
          backgroundColor: regularWhite,
          surfaceTintColor: regularWhite,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
