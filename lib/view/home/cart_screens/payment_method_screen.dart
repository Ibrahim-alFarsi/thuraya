import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/model/payment_method_model.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/home/cart_screens/My_cart_before_payment.dart';
import '../../../datafile/model_data.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethodScreenController paymentMethodScreenController =
      Get.put(PaymentMethodScreenController());
  bool select = false;
  List<Payment> paymentOption = Data.getPaymentData();

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
              body: GetBuilder<PaymentMethodScreenController>(
                init: PaymentMethodScreenController(),
                builder: (paymentMethodScreenController) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: regularWhite,
                      child: getAppBar("Payment Methods", function: () {
                        Get.back();
                      }, space: 71.w),
                    ),
                    getVerSpace(40.h),
                    buildProgressWidget(context),
                    getVerSpace(30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: getCustomFont(
                          "Select the payment method you want to use",
                          16.sp,
                          Color(0XFF000000),
                          1,
                          fontWeight: FontWeight.w500,
                          txtHeight: 1.5.h),
                    ),
                    getVerSpace(10.h),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: paymentOption.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              paymentMethodScreenController
                                  .onSetCheakPosition(index);
                            },
                            child: getCustomContainer(84.h, double.infinity,
                                color: regularWhite,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        getAssetImage(
                                            paymentOption[index].image!,
                                            height: 34.h,
                                            width: 34.w),
                                        getHorSpace(20.w),
                                        paymentOption[index].type == 'card'
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  getCustomFont(
                                                      paymentOption[index]
                                                          .name!,
                                                      16,
                                                      Color(0XFF000000),
                                                      1,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  getCustomFont(
                                                      "xxxx xxxx xxxx 5416",
                                                      16.sp,
                                                      regularBlack,
                                                      1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      txtHeight: 1.5.h)
                                                ],
                                              )
                                            : getCustomFont(
                                                paymentOption[index].name!,
                                                16,
                                                Color(0XFF000000),
                                                1,
                                                fontWeight: FontWeight.w700),
                                      ],
                                    ),
                                    paymentMethodScreenController
                                                .cheakPosition ==
                                            index
                                        ? getSvgImage("radio_fill.svg",
                                            height: 24.h, width: 24.h)
                                        : getSvgImage("radio_button.svg",
                                            height: 24.h, width: 24.h)
                                  ],
                                ).paddingSymmetric(horizontal: 20.h)),
                          ).paddingSymmetric(vertical: 10.h);
                        },
                      ),
                    ),
                    /*Center(
                        child: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(22.h),
                                          topRight: Radius.circular(22.h))),
                                  CardBottomSheet());
                            },
                            child: getCustomFont(
                                "+ Add New Card", 16.sp, Color(0XFF000000), 1,
                                fontWeight: FontWeight.w500))),*/
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 56.h, top: 30.h, left: 20.w, right: 20.w),
                      child: getCustomButton("Confirm Payment", () {
                        Get.to(MyCartScreenAfterPayment());
                      }),
                    )
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
        getSvgImage("card.svg", height: 24.h, width: 24.h),
        Expanded(
          child: FDottedLine(
            color: regularBlack,
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
}
