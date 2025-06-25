import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constantWidget.dart';
import 'package:thuraya_app/view/home/cart_screens/my_cart_screen.dart';
import '../../model/plant_product.dart';

class SnackPlantDetail extends StatefulWidget {
  const SnackPlantDetail({required this.detail, super.key});
  final PlantProduct detail;

  @override
  State<SnackPlantDetail> createState() => _SnackPlantDetailState();
}

class _SnackPlantDetailState extends State<SnackPlantDetail> {
  PlantDetailScreenController plantDetailScreenController =
      Get.put(PlantDetailScreenController());

  @override
  void initState() {
    setStatusBarColor(Color(0XFFF4F5F2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);

    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: SafeArea(
          child: Scaffold(
              backgroundColor: Color(0XFFF4F5F2),
              body: GetBuilder<PlantDetailScreenController>(
                init: PlantDetailScreenController(),
                builder: (plantDetailScreenController) => Column(
                  children: [
                    getVerSpace(4.h),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 98.w),
                          child: Container(
                            height: 368.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16.h),
                                    bottomRight: Radius.circular(16.h)),
                                color: Color(0XFFFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(18, 11),
                                    blurRadius: 26,
                                    color: Color(0XFFBCC8AC).withOpacity(0.10),
                                  )
                                ],
                                image: DecorationImage(
                                    image: AssetImage(
                                        "${Constant.assetImagePath}${widget.detail.detailImage}"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        getAppBar("", function: () {
                          Get.back();
                        }),
                        Padding(
                          padding: EdgeInsets.only(left: 263.w, top: 78.h),
                          child: Column(
                            children: [
                              atmospherRules(
                                  'humidityIcon.png', 'Humidity', 55),
                              getVerSpace(20.h),
                              atmospherRules('sunlight.png', 'Sunlight', 55),
                              getVerSpace(20.h),
                              atmospherRules('height.png', 'Height', 55),
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          getVerSpace(30.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getCustomFont("${widget.detail.name}", 22.sp,
                                    Color(0XFF000000), 1,
                                    fontWeight: FontWeight.w700),
                                getCustomFont("\$${widget.detail.price}", 22.sp,
                                    Color(0XFF000000), 1,
                                    fontWeight: FontWeight.w700)
                              ],
                            ),
                          ),
                          getVerSpace(20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: getCustomFont(
                                "Dolor sit amet consectetur adipiscing elit duis. Integer quis auctor elit sed vulputate mi sit. Duis at consectetur lorem donec",
                                16.sp,
                                Color(0XFF000000),
                                10,
                                fontWeight: FontWeight.w500),
                          ),
                          getVerSpace(20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: getCustomFont(
                                "Quantity", 18, Color(0XFF000000), 1,
                                fontWeight: FontWeight.w600),
                          ),
                          getVerSpace(15.h),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                children: [
                                  getadd_remove_button("addicon.png",
                                      function: () {
                                    plantDetailScreenController
                                        .onQuntityIncrese(
                                            widget.detail.quntity);
                                    print(
                                        "Quntity is ================================ ${plantDetailScreenController.qu}");
                                  }),
                                  getHorSpace(20.h),
                                  getCustomFont(
                                      "${plantDetailScreenController.qu}",
                                      16,
                                      Color(0XFF000000),
                                      1,
                                      fontWeight: FontWeight.w500),
                                  getHorSpace(20.h),
                                  plantDetailScreenController.qu > 1
                                      ? getadd_remove_button("removeicon.png",
                                          function: () {
                                          plantDetailScreenController
                                              .onQuntityDicrese(
                                                  plantDetailScreenController
                                                      .qu);
                                          print(
                                              "Quntity is ================================ ${plantDetailScreenController.qu}");
                                        })
                                      : SizedBox(),
                                ],
                              )),
                          getVerSpace(30.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: getCustomFont(
                                "Photos", 18, Color(0XFF000000), 1,
                                fontWeight: FontWeight.w600),
                          ),
                          // getVerSpace(20.h),
                          SizedBox(
                              height: 130.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.detail.plantimages!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 20.h,
                                        bottom: 20.h),
                                    child: getCustomContainer(0, 79.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.h),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(-14, 8),
                                                blurRadius: 32,
                                                color: Color(0XFF181414)
                                                    .withOpacity(0.08),
                                              ),
                                            ],
                                            color: Color(0XFFFFFFFF)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 19.w, vertical: 16.h),
                                          child: GestureDetector(
                                              onTap: () {
                                                // Get.to();
                                              },
                                              child: getAssetImage(
                                                  widget.detail
                                                      .plantimages![index],
                                                  height: 58.h,
                                                  width: 41.w)),
                                        )),
                                  );
                                },
                              )),
                          getVerSpace(20.h),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 56.h, left: 20.w, right: 20.w),
                            child: getCustomButton(
                              "Add To Cart",
                              () {
                                Get.to(MyCartScreen());
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  Widget atmospherRules(String image, String atmospherRulse, int percent) {
    return getCustomContainer(60.h, 131.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0XFFE8F0DE),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: getCustomContainer(36.h, 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.h),
                    child: getAssetImage(image),
                  )),
            ),
            getHorSpace(9.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCustomFont(atmospherRulse, 14.sp, Color(0XFF76974C), 1,
                    fontWeight: FontWeight.w400),
                getCustomFont('$percent%', 14.sp, Color(0XFF76974C), 1,
                    fontWeight: FontWeight.w600),
              ],
            )
          ],
        ));
  }
}
