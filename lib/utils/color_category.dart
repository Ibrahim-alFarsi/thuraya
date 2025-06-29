import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color buttonColor = '#76974C'.toColor();
Color bgColor = "#FAFAFA".toColor();
Color lightbuttonColor = "#EEF6E4".toColor();
Color subTitleColor = "#808080".toColor();
// Color pacificBlue = "#2FA2B9".toColor();
// Color hintColor = "#565858".toColor();
Color borderColor = "#DFDFDF".toColor();
// Color errorColor = "#FF6565".toColor();
// Color shadowColor = "#24819498".toColor();
// Color lightPacific = "#D8F0F4".toColor();
Color regularBlack = "#000000".toColor();
Color regularWhite = "#FFFFFF".toColor();
// Color tabbarBackground  = "#F6F6F6".toColor();
// Color selectTabColor = "#819498".toColor();
Color dividerColor = "#F1F1F1".toColor();
Color animationbaseColor = Colors.grey.withAlpha((0.14 * 255).toInt());
Color animationhighLightColor = bgColor;

extension ColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Colors.black; // Default fallback color
  }
}

void setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
  ));
}
