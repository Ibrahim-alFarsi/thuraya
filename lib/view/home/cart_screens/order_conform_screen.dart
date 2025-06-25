import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constantWidget.dart';
import 'package:thuraya_app/view/home/profile_screens/my_orders.dart';

class OrderConfirm extends StatefulWidget {
  const OrderConfirm({super.key});

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
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
              child:
//
                  // CircularProgressIndicator(color: buttonColor )
                  GetBuilder<MyOrderScreenController>(
                      init: MyOrderScreenController(),
                      builder: (controller) => paymentConform()),
            ),
          )),
    );
  }

  Widget paymentConform() {
    return GetBuilder<MyOrderScreenController>(
        init: MyOrderScreenController(),
        builder: (myOrderScreenController) => Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getAssetImage("payment_done.png", height: 175.h, width: 175.h),
                getVerSpace(20.h),
                getCustomFont(
                    "Your order has been received", 22.sp, regularBlack, 1,
                    fontWeight: FontWeight.w700),
                getVerSpace(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getCustomFont("STATUS:", 18.sp, regularBlack, 1,
                        fontWeight: FontWeight.w600),
                    getHorSpace(5.h),
                    getCustomFont("PROCESSING", 18.sp, Color(0XFFDC9E00), 1,
                        fontWeight: FontWeight.w600)
                  ],
                ),
                getVerSpace(12.h),
                getCustomFont("ID: 3655", 18.sp, regularBlack, 1,
                    fontWeight: FontWeight.w600),
                getVerSpace(30.h),
                getCustomFont(
                    "Thank you for shopping with us", 16.sp, regularBlack, 1,
                    fontWeight: FontWeight.w500),
                getVerSpace(25.h),
                getCustomButton("Continue", () {
                  myOrderScreenController.onMyorderBackposition(false);
                  Get.to(MyOrders());
                }, buttonheight: 60.h, buttonwidth: 164.h)
              ],
            ));
  }
}
