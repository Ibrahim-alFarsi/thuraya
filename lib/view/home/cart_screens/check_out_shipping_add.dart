import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/address.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/home/cart_screens/add_address_screen.dart';
import 'package:thuraya_app/view/home/cart_screens/payment_method_screen.dart';
import '../../../controller/controller.dart';
import '../../../utils/color_category.dart';

class CheckoutAddress extends StatefulWidget {
  const CheckoutAddress({super.key});

  @override
  State<CheckoutAddress> createState() => _CheckoutAddressState();
}

class _CheckoutAddressState extends State<CheckoutAddress> {
  List<ModelAddress> addressLists = Data.getAddress();
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                      color: regularWhite,
                      child: getAppBar("Checkout", function: () {
                        Get.back();
                      })),
                  // getToolbar(context, () {
                  //   backClick();
                  // },
                  //     text: "Checkout",
                  //     suffixIcon: false,
                  //     image: "filter.svg",
                  //     suffixFunction: () {}),
                  getVerSpace(20.h),
                  buildProgressWidget(context),
                  getVerSpace(20.h),
                  buildAddressList()
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buildNewAddressButton(context),
                    getVerSpace(30.h),
                    buildNextButton(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return getCustomButton("Next", () {
      Get.to(PaymentMethodScreen());
    }).paddingOnly(left: 20.h, right: 20.h, bottom: 40.h);
  }

  Widget buildNewAddressButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(AddAddressScreen());
      },
      child: getCustomContainer(60.h, double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.h), color: dividerColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getSvgImage("add_icon.svg",
                  color: regularBlack, height: 24.h, width: 24.h),
              getHorSpace(12.h),
              getCustomFont("Add New Address", 16.sp, regularBlack, 1,
                  fontWeight: FontWeight.w500)
            ],
          )).paddingSymmetric(horizontal: 74.h),
    );
    //   getCustomButton("Add New Address",(){
    //   Get.to(AddAddressScreen());
    // });
    /* getButton(context, widgetBg, "Add New Address", Colors.black, () {
      Constant.sendToNext(context, addAddressScreenRoute);
    }, 16.sp,
        buttonHeight: 60.h,
        borderRadius: 22.h,
        weight: FontWeight.w500,
        isIcon: true,
        image: "add.svg",
        buttonWidth: 267.w);*/
  }

  Expanded buildAddressList() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            Container(
              color: Colors.white,
              child: GetBuilder<CartController>(
                init: CartController(),
                builder: (controller) => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.addressLists.length,
                  itemBuilder: (context, index) {
                    ModelAddress modelAddress = controller.addressLists[index];
                    return Container(
                      child: Column(
                        children: [
                          getVerSpace(20.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont(modelAddress.country!, 17.sp,
                                        Colors.black, 1,
                                        fontWeight: FontWeight.w700),
                                    getVerSpace(8.h),
                                    getMultilineCustomFont(
                                        "${modelAddress.street} , ${modelAddress.city} , ${modelAddress.country} ${modelAddress.pincode}",
                                        14.sp,
                                        Colors.black,
                                        fontWeight: FontWeight.w400),
                                    getVerSpace(8.h),
                                    getCustomFont(modelAddress.phoneNumber!,
                                        14.sp, Colors.black, 1,
                                        fontWeight: FontWeight.w400)
                                  ],
                                ).marginOnly(right: 40.h),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.addressChange(index);
                                },
                                child: GetBuilder<CartController>(
                                  builder: (controller) => getSvgImage(
                                      controller.addressIndex == index
                                          ? "radio_fill.svg"
                                          : "radio_button.svg",
                                      height: 24.h,
                                      width: 24.h),
                                  init: CartController(),
                                ),
                              )
                            ],
                          ),
                          getVerSpace(20.h),
                          index == controller.addressLists.length - 1
                              ? SizedBox()
                              : getDivider(color: dividerColor, horPadding: 0)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ).paddingOnly(bottom: 200.h),
          ],
        ),
      ),
    );
  }

  Widget buildProgressWidget(BuildContext context) {
    return Row(
      children: [
        getSvgImage("myAddressIcon.svg", height: 24.h, width: 24.h),
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
