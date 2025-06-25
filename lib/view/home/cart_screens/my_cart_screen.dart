import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/model/my_cart_data.dart';
import 'package:thuraya_app/model/rate_types_modeol.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/pref_data.dart';
import 'package:thuraya_app/view/home/cart_screens/check_out_shipping_add.dart';
import 'package:thuraya_app/view/home/cart_screens/coupan_screen.dart';
import 'package:thuraya_app/view/login/login_empty_state.dart';

import '../../../datafile/model_data.dart';
import '../../../utils/constant_widget.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  MyCartScreenController myCartScreenController =
      Get.put(MyCartScreenController());
  List<RateType> rateTypes = Data.getRateType();
  List<MyCartData> mycartData = Data.getMyCart();
  Future<void> _getIsFirst() async {
    bool isSignIn = await PrefData.getIsSignIn();

    if (isSignIn) {
      Get.to(LoginEmptyState());
    } else {
      Get.to(CheckoutAddress());
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: regularWhite,
          body: SafeArea(
              child: GetBuilder<PlantDetailScreenController>(
            init: PlantDetailScreenController(),
            builder: (plantDetailScreenController) => Column(
              children: [
                Container(
                    color: regularWhite,
                    child: getAppBar(
                      "My Cart",
                      iconpermmition: false,
                    )),
                getVerSpace(20.h),
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: [
                      Container(
                        color: regularWhite,
                        child: myOrderList(),
                      ),
                      getVerSpace(20.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getCustomContainer(60.h, 301.h,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 16,
                                          color: regularBlack.withOpacity(0.03))
                                    ],
                                    borderRadius: BorderRadius.circular(16.h),
                                    color: regularWhite),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getCustomFont(
                                      "Coupon Code",
                                      16.sp,
                                      subTitleColor,
                                      1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Coupon applied successfully", // message
                                              toastLength:
                                                  Toast.LENGTH_SHORT, // length
                                              gravity: ToastGravity.CENTER,
                                              backgroundColor:
                                                  buttonColor // location
                                              // duration
                                              );
                                        },
                                        child: getCustomFont(
                                            "Apply", 16.sp, buttonColor, 1,
                                            fontWeight: FontWeight.w700,
                                            txtHeight: 1.5.h)),
                                  ],
                                ).paddingSymmetric(horizontal: 20.h)),
                            GestureDetector(
                              onTap: () {
                                Get.to(CoupanScreen());
                              },
                              child: getCustomFont(
                                  "View all", 16.sp, Color(0XFF808080), 1,
                                  fontWeight: FontWeight.w500),
                            )
                          ]).paddingSymmetric(horizontal: 20.h),
                      getVerSpace(20.h),
                      Container(
                        color: regularWhite,
                        child: Column(children: [
                          getVerSpace(20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getCustomFont("Shipping", 16, regularBlack, 1,
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
                                            : getSvgImage("cheak_button.svg"),
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
                                                    fontWeight: FontWeight.w500,
                                                  )
                                                ],
                                              )
                                            : getCustomFont(
                                                rateTypes[index].rateName!,
                                                16.sp,
                                                regularBlack,
                                                1,
                                                fontWeight: FontWeight.w500),
                                      ],
                                    ).paddingSymmetric(vertical: 6.h),
                                  ),
                                ],
                              );
                            },
                          ),
                          getDivider(color: dividerColor),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getCustomFont("Discount", 16.sp, regularBlack, 1,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      getVerSpace(20.h),
                      getViewCartButton("3 Item", "60.50", "Continue", () {
                        _getIsFirst();
                      }, () {})
                    ],
                  ),
                ),
              ],
            ),
          )
              /* */
              )),
    );
  }

  Widget myOrderList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.h),
      shrinkWrap: true,
      primary: false,
      physics: BouncingScrollPhysics(),
      itemCount: mycartData.length,
      itemBuilder: (context, index) => Dismissible(
        key: Key("$index"),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: getSvgImage("delete_icon_white.svg", height: 24.h, width: 24.h)
              .paddingOnly(right: 20.h),
        ),
        child: Column(
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
      ),
    );
  }
}
