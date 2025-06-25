import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constantWidget.dart';
import 'package:thuraya_app/utils/pref_data.dart';
import 'package:thuraya_app/view/home/home_main_screen.dart';
import 'package:thuraya_app/view/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getIsFirst();
  }

  Future<void> _getIsFirst() async {
    bool isIntro = await PrefData.getIsIntro();

    Timer(const Duration(seconds: 3), () {
      Get.to(OnboardingScreen());
      if (isIntro) {
        Get.to(OnboardingScreen());
      }
      // else if (isSignIn) {
      // Get.to(LoginEmptyState());
      // }
      else {
        Get.to(HomeMainScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    setStatusBarColor(Colors.white);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getAssetImage("logo.png", height: 100.h, width: 100.h),
              getVerSpace(4.h),
              Center(
                  child: getCustomFont("Natura", 28.sp, Color(0XFF76974C), 1,
                      fontWeight: FontWeight.w700))
            ],
          ),
        ));
  }
}
