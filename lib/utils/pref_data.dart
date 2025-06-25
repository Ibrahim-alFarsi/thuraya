import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String prefName = "com.example.thuraya_app";

  static String isIntro = "${prefName}isIntro";
  static String signIn = "${prefName}signIn";
  static String homeScreen = "${prefName}homeScreen";

  static Future<void> setIsIntro(bool sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isIntro, sizes);
  }

  static Future<bool> getIsIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(isIntro) ?? true;
    return intValue;
  }

  static Future<void> setIsSignIn(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(signIn, isFav);
  }

  static Future<bool> getIsSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(signIn) ?? true;
  }

  static Future<void> setIsHome(bool home)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(homeScreen, home);
  }

  static Future<bool> getIsHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(homeScreen) ?? true;
  }
}
