import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/home/cart_screens/add_address_screen.dart';
import 'package:thuraya_app/view/home/cart_screens/payment_method_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckOutScreenController checkOutScreenController =
      Get.put(CheckOutScreenController());

  // List<ModelAddress> addressData = Data.getAddress();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: SafeArea(
          child: Scaffold(
              backgroundColor: bgColor,
              body: GetBuilder<CheckOutScreenController>(
                init: CheckOutScreenController(),
                builder: (CheckOutScreenController) => Column(
                  children: [
                    getVerSpace(4.h),
                    Container(
                      color: regularWhite,
                      child: getAppBar("Checkout", function: () {
                        Get.back();
                      }),
                    ),
                    getVerSpace(20.h),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          GetBuilder<CartController>(
                            init: CartController(),
                            builder: (cartController) => ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: BouncingScrollPhysics(),
                                itemCount: cartController.addressLists.length,
                                itemBuilder: (context, index) => Container(
                                      color: regularWhite,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getVerSpace(20.h),
                                          getCustomFont("Shipping Address",
                                              18.sp, Color(0XFF000000), 1,
                                              fontWeight: FontWeight.w600,
                                              txtHeight: 1.5.h),
                                          getVerSpace(16.h),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              getCustomContainer(34.h, 34.w,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0XFFE8F0DE),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.46.h,
                                                        bottom: 9.6.h,
                                                        left: 9.6.w,
                                                        right: 9.6.w),
                                                    child: getAssetImage(
                                                        "locationIcon.png"),
                                                  )),
                                              getHorSpace(20.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    getCustomFont("Home", 16,
                                                        Color(0XFF000000), 1,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    getVerSpace(5.h),
                                                    getMultilineCustomFont(
                                                            "${cartController.addressLists[index].street},${cartController.addressLists[index].city},${cartController.addressLists[index].country},${cartController.addressLists[index].pincode}",
                                                            16.sp,
                                                            regularBlack,
                                                            fontWeight:
                                                                FontWeight.w500)
                                                        .paddingOnly(
                                                            right: 64.h),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(AddAddressScreen());
                                                },
                                                child: getAssetImage(
                                                    "editIcon.png",
                                                    height: 20.h,
                                                    width: 20.w),
                                              ),
                                            ],
                                          ),
                                          getVerSpace(20.h),
                                        ],
                                      ).paddingSymmetric(horizontal: 20.h),
                                    )),
                          ),
                          getVerSpace(24.h),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 56.h,
                                top: 30.h,
                                left: 20.w,
                                right: 20.w),
                            child: getCustomButton("Continue To Payment", () {
                              Get.to(PaymentMethodScreen());
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
