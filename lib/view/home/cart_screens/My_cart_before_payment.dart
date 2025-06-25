import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/my_cart_data.dart';
import 'package:thuraya_app/model/rate_types_modeol.dart';
import 'package:thuraya_app/view/home/cart_screens/order_conform_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/color_category.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';

class MyCartScreenAfterPayment extends StatefulWidget {
  const MyCartScreenAfterPayment({super.key});

  @override
  State<MyCartScreenAfterPayment> createState() =>
      _MyCartScreenAfterPaymentState();
}

class _MyCartScreenAfterPaymentState extends State<MyCartScreenAfterPayment> {
  List<RateType> rateTypes = Data.getRateType();
  List<MyCartData> mycartData = Data.getMyCart();
  final Future<bool> _future = Future<bool>.delayed(
    Duration(milliseconds: 400),
    () {
      return true;
    },
  );
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
              child: GetBuilder<PlantDetailScreenController>(
            init: PlantDetailScreenController(),
            builder: (plantDetailScreenController) => Stack(
              children: [
                Column(
                  children: [
                    Container(
                        height: 73.h,
                        color: regularWhite,
                        child: getAppBar("Checkout", function: () {
                          Get.back();
                        }, space: 114.h)),
                    getVerSpace(20.h),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          buildProgressWidget(context),
                          getVerSpace(20.h),
                          Container(
                            color: regularWhite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getCustomFont(
                                    "Shipping Address", 17.sp, regularBlack, 1,
                                    fontWeight: FontWeight.w700),
                                getVerSpace(8.h),
                                FutureBuilder<bool>(
                                  future: _future,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.hasData) {
                                      return shippingAddress();
                                    } else {
                                      return Shimmer.fromColors(
                                        baseColor:
                                            Colors.grey.withOpacity(0.14),
                                        highlightColor: bgColor,
                                        direction: ShimmerDirection.ltr,
                                        child: shippingAddress(),
                                      );
                                    }
                                  },
                                ),
                                //shippingAddress(),
                              ],
                            ).paddingSymmetric(
                                horizontal: 20.h, vertical: 20.h),
                          ),
                          getVerSpace(20.h),
                          Container(
                            color: regularWhite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getCustomFont(
                                    "Payment Method", 17.sp, regularBlack, 1,
                                    fontWeight: FontWeight.w700),
                                getVerSpace(12.h),
                                paymentMethod(),
                                //paymentMethod(),
                              ],
                            ).paddingSymmetric(
                                horizontal: 20.h, vertical: 20.h),
                          ),
                          getVerSpace(20.h),
                          Container(
                            color: regularWhite,
                            child: orderItem(),
                            //orderItem(),
                          ),
                          getVerSpace(20.h),
                          Container(
                            color: regularWhite,
                            child: Column(children: [
                              getVerSpace(20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getCustomFont(
                                        "Sub Total", 16, Color(0XFF000000), 1,
                                        fontWeight: FontWeight.w500),
                                    getCustomFont(
                                        "\$60.00", 16, Color(0XFF000000), 1,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                              ),
                              getDivider(color: dividerColor),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getCustomFont(
                                        "Shipping", 16, regularBlack, 1,
                                        fontWeight: FontWeight.w500),
                                    getCustomFont(
                                        "+\$3.00", 16, Color(0XFF000000), 1,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                              ),
                              getVerSpace(14.h),
                              ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                shrinkWrap: true,
                                primary: false,
                                physics: BouncingScrollPhysics(),
                                itemCount: rateTypes.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          plantDetailScreenController
                                              .onSetCheakPosition(index);
                                        },
                                        child: Row(
                                          children: [
                                            plantDetailScreenController
                                                        .cheakPosition ==
                                                    index
                                                ? getSvgImage(
                                                    "cheak_button_fill.svg")
                                                : getSvgImage(
                                                    "cheak_button.svg"),
                                            getHorSpace(8.h),
                                            index == 2
                                                ? Row(
                                                    children: [
                                                      getCustomFont(
                                                          rateTypes[index]
                                                              .rateName!,
                                                          16.sp,
                                                          regularBlack,
                                                          1,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      getRichtext(
                                                          " ( on order up to",
                                                          " \$20.00",
                                                          firsttextSize: 16.sp,
                                                          firsttextcolor:
                                                              Color(0XFF808080),
                                                          secondtextSize: 16.sp,
                                                          firstTextwidth:
                                                              FontWeight.w500,
                                                          secondTextwidth:
                                                              FontWeight.w500,
                                                          secondtextcolor:
                                                              buttonColor),
                                                      getCustomFont(
                                                        " )",
                                                        16.sp,
                                                        Color(0XFF808080),
                                                        1,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )
                                                    ],
                                                  )
                                                : getCustomFont(
                                                    rateTypes[index].rateName!,
                                                    16.sp,
                                                    regularBlack,
                                                    1,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ],
                                        ).paddingSymmetric(vertical: 6.h),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              getDivider(color: dividerColor),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getCustomFont("Tax", 16.sp, regularBlack, 1,
                                      fontWeight: FontWeight.w500),
                                  getCustomFont(
                                      "+\$2.00", 16.sp, Color(0XFF000000), 1,
                                      fontWeight: FontWeight.w500),
                                ],
                              ).paddingSymmetric(horizontal: 20.h),
                              getDivider(color: dividerColor),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getCustomFont(
                                      "Discount", 16.sp, regularBlack, 1,
                                      fontWeight: FontWeight.w500),
                                  getCustomFont(
                                      "-\$4.50", 16.sp, Color(0XFF000000), 1,
                                      fontWeight: FontWeight.w500),
                                ],
                              ).paddingSymmetric(horizontal: 20.h),
                              getDivider(color: dividerColor),
                              getVerSpace(20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getCustomFont(
                                        "Total", 18.sp, Color(0XFF000000), 1,
                                        fontWeight: FontWeight.w600),
                                    getCustomFont(
                                        "\$70.00", 18.sp, Color(0XFF000000), 1,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                              ),
                              getVerSpace(17.h),
                            ]),
                          ),
                          getVerSpace(100.h),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: getCustomButton("Next", () {
                    Get.to(OrderConfirm());
                  }).paddingOnly(left: 20.h, right: 20.h, bottom: 40.h),
                ),
              ],
            ),
          ))),
    );
  }

  Widget buildProgressWidget(BuildContext context) {
    return Row(
      children: [
        getSvgImage("location_fill.svg", height: 24.h, width: 24.h),
        Expanded(
          child: FDottedLine(
            color: buttonColor,
            height: 1.h,
            strokeWidth: 1.h,
            width: double.infinity,
            space: 4.h,
            dottedLength: 4.h,
            corner: FDottedLineCorner.all(5.h),
            child: Container(),
          ).paddingSymmetric(horizontal: 6.h),
        ),
        getSvgImage("card_fill.svg", height: 24.h, width: 24.h),
        Expanded(
          child: FDottedLine(
            color: buttonColor,
            height: 1.h,
            strokeWidth: 1.h,
            width: double.infinity,
            space: 4.h,
            dottedLength: 4.h,
            corner: FDottedLineCorner.all(5.h),
            child: Container(),
          ).paddingSymmetric(horizontal: 6.h),
        ),
        getSvgImage("check_circle.svg", height: 24.h, width: 24.h),
      ],
    ).paddingSymmetric(horizontal: 30.h);
  }

  Widget orderItem() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.h),
      shrinkWrap: true,
      primary: false,
      physics: BouncingScrollPhysics(),
      itemCount: mycartData.length,
      itemBuilder: (context, index) => Column(
        children: [
          getCartDetailFormate(
              mycartData[index].image!,
              mycartData[index].name!,
              mycartData[index].price!,
              mycartData[index].quantity,
              mycartData[index].size!),
          index == mycartData.length - 1
              ? SizedBox()
              : getDivider(color: dividerColor, horPadding: 0),
        ],
      ).paddingOnly(left: 10.h, right: 10.h, top: 10),
    );
  }

  Widget shippingAddress() {
    return getCustomFont(
        "Westheimer Rd. Santa Ana, Illinois 85486", 14.sp, regularBlack, 1,
        fontWeight: FontWeight.w400);
  }

  Widget paymentMethod() {
    return Row(
      children: [
        getAssetImage("paypalpayment.png", height: 30.h, width: 30.h),
        getHorSpace(8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont("Paypal", 14.sp, regularBlack, 1,
                fontWeight: FontWeight.w400),
            getCustomFont("XXXX XXXX XXXX 2563", 14.sp, regularBlack, 1,
                fontWeight: FontWeight.w400),
          ],
        ),
      ],
    );
  }
}
