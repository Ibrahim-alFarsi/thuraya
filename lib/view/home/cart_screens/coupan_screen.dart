import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/coupen_model.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/view/home/cart_screens/my_cart_screen.dart';

import '../../../controller/controller.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';

class CoupanScreen extends StatefulWidget {
  const CoupanScreen({super.key});

  @override
  State<CoupanScreen> createState() => _CoupanScreenState();
}

class _CoupanScreenState extends State<CoupanScreen> {
  CoupanScreenController coupanScreenController =
      Get.put(CoupanScreenController());
  List<Coupons> coponsData = Data.getCouponsData();
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        body: GetBuilder<CoupanScreenController>(
      init: CoupanScreenController(),
      builder: (coupanScreenController) => SafeArea(
        child: Column(
          children: [
            Container(
              color: regularWhite,
              child: getAppBar("Coupons", space: 117.h, function: () {
                Get.back();
              }),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: coponsData.length,
                itemBuilder: (context, index) => Container(
                  height: 157.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: regularWhite,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getCustomFont(
                                "${coponsData[index].discount}% Off",
                                16.sp,
                                buttonColor,
                                1,
                                fontWeight: FontWeight.w700),
                            getVerSpace(10.h),
                            getMultilineCustomFont(
                                coponsData[index].discription!,
                                16.sp,
                                regularBlack,
                                fontWeight: FontWeight.w500,
                                txtHeight: 1.5.h),
                            getVerSpace(14.h),
                            getCustomFont(
                                "Expire on ${coponsData[index].expireDate}",
                                14.sp,
                                Color(0XFF808080),
                                1,
                                fontWeight: FontWeight.w500)
                          ],
                        ).paddingOnly(right: 21.h),
                      ),
                      FDottedLine(
                        corner: FDottedLineCorner.all(6.h),
                        color: buttonColor,
                        height: 200.0.h,
                        width: 100.w,
                        strokeWidth: 1.h,
                        dottedLength: 4.0,
                        space: 5.0,
                        child: Container(
                          height: 48.h,
                          width: 135.w,
                          color: Color(0XFFF9FCF6),
                          child: Center(
                              child: getCustomFont(
                                  coponsData[index].coupenCode!,
                                  16.sp,
                                  buttonColor,
                                  1,
                                  fontWeight: FontWeight.w600)),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 20.h),
                ).paddingSymmetric(vertical: 10.h),
              ),
            ),
            getCustomButton("Apply", () {
              Get.back(result: MyCartScreen());
            }).paddingOnly(left: 20.h, right: 20.h, bottom: 30.h)
          ],
        ),
      ),
        ),
      ),
    );
  }
}
