import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/utils/pref_data.dart';
import 'package:thuraya_app/view/home/home_main_screen.dart';

class VerificationSuccessScreen extends StatefulWidget {
  const VerificationSuccessScreen({super.key});

  @override
  State<VerificationSuccessScreen> createState() =>
      _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState extends State<VerificationSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {},
        child: Scaffold(
          backgroundColor: Color(0XFFE5E5E5),
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getAssetImage("verificationSuccess.png",
                    height: 140.h, width: 140.w),
                getVerSpace(30.h),
                getCustomFont("Account Created", 28, Color(0XFF000000), 2,
                    fontWeight: FontWeight.w700),
                getVerSpace(8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.h),
                  child: getCustomFont(
                      "Your account has been sucessfully created!",
                      16,
                      Color(0XFF000000),
                      2,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center),
                ),
                getVerSpace(40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 75.w),
                  child: getCustomButton("Ok", () {
                    PrefData.setIsSignIn(false);
                    Get.to(HomeMainScreen());
                  }),
                ),
              ],
            ),
          )),
        ));
  }
}
