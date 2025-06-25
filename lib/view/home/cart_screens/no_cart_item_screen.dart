import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuraya_app/utils/constant.dart';

import '../../../utils/color_category.dart';
import '../../../utils/constantWidget.dart';

class NoCartItemScreen extends StatefulWidget {
  const NoCartItemScreen({super.key});

  @override
  State<NoCartItemScreen> createState() => _NoCartItemScreenState();
}

class _NoCartItemScreenState extends State<NoCartItemScreen> {
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Color(0XFFE5E5E5),
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getAssetImage("no_cart_image.png", height: 140.h, width: 140.w),
                getVerSpace(30.h),
                getCustomFont("No Cart Yet!", 28, Color(0XFF000000), 1,
                    fontWeight: FontWeight.w700),
                getVerSpace(8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.h),
                  child: getCustomFont(
                      "Explore more and shortlist some products.",
                      16,
                      Color(0XFF000000),
                      2,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center),
                ),
                getVerSpace(40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 75.w),
                  child: getCustomButton(
                      "Add Favourites",
                      buttonwidth: 177.h,
                      color: buttonColor,
                      decoration: BoxDecoration(
                          border: Border.all(color: buttonColor),
                          borderRadius: BorderRadius.circular(16.h)),
                      () {}),
                ),
              ],
            ),
          )),
        ));
  }
}
