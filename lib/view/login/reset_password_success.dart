import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/login/login_empty_state.dart';

import '../../utils/color_category.dart';

class ResetPasswordSuccess extends StatefulWidget {
  const ResetPasswordSuccess({super.key});

  @override
  State<ResetPasswordSuccess> createState() => _ResetPasswordSuccessState();
}

class _ResetPasswordSuccessState extends State<ResetPasswordSuccess> {
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getAssetImage("passwordchangesucces.png",
                    height: 140.h, width: 140.w),
                getVerSpace(30.h),
                getCustomFont("Password Changed", 28, Color(0XFF000000), 2,
                    fontWeight: FontWeight.w700),
                getVerSpace(8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.h),
                  child: getCustomFont(
                      "Your password has been successfully changed!",
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
                    Get.off(LoginEmptyState());
                  }),
                ),
              ],
            ),
          )),
        ));
  }
}
