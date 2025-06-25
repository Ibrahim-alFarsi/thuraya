import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/plant_detail_image_slider_model.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/home/cart_screens/my_cart_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../model/popular_plant.dart';

class PlantDetail extends StatefulWidget {
  const PlantDetail({required this.detail, super.key});
  final PopularPlant detail;

  @override
  State<PlantDetail> createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  PlantDetailScreenController plantDetailScreenController =
      Get.put(PlantDetailScreenController());
  List<DetailSliderImage> sliderImage = Data.getSliderImage();
  List<PopularPlant> popularPlant = Data.getPopularPlantData();
  PageController controller = PageController();

  Future<void> share() async {
    await Share.share(
      subject: "Example Chooser Title",
      "https://flutter.dev/",
    );
  }

  final Future<bool> _future = Future<bool>.delayed(
    Duration(milliseconds: 0),
    () {
      return true;
    },
  );

//DetailSlider
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
      child: Scaffold(
          backgroundColor: regularWhite,
          body: SafeArea(
              child: FutureBuilder<bool>(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return column();
              } else {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.14),
                  highlightColor: bgColor,
                  direction: ShimmerDirection.ltr,
                  child: column(),
                );
              }
            },
          ))),
    );
  }

  Widget indicater() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(sliderImage.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 10.h,
            width: 10.w,
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 30.h),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == plantDetailScreenController.currentPage
                    ? buttonColor
                    : Color(0XFFF1F1F1)),
          );
        }));
  }

  Widget column() {
    return GetBuilder<PlantDetailScreenController>(
      init: PlantDetailScreenController(),
      builder: (plantDetailScreenController) => Stack(
        children: [
          Column(
            children: [
              Container(
                  height: 503.h,
                  color: regularWhite,
                  child: Stack(
                    children: [
                      Container(
                        child: PageView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: sliderImage.length,
                            scrollDirection: Axis.horizontal,
                            controller: controller,
                            onPageChanged: (value) {
                              plantDetailScreenController.onPageChange(value);
                            },
                            itemBuilder: (context, index) {
                              print(controller.initialPage);
                              return getAssetImage(sliderImage[index].image!,
                                      height: 236.79.h, width: 170.h)
                                  .paddingOnly(
                                      bottom: 146.h,
                                      top: 26.h,
                                      left: 20.h,
                                      right: 20.h);
                            }),
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //         child: Container(
                      //       child: PageView.builder(
                      //           physics: BouncingScrollPhysics(),
                      //           itemCount: sliderImage.length,
                      //           scrollDirection: Axis.horizontal,
                      //           controller: controller,
                      //           onPageChanged: (value) {
                      //             plantDetailScreenController
                      //                 .onPageChange(value);
                      //           },
                      //           itemBuilder: (context, index) {
                      //             print(controller.initialPage);
                      //             return getAssetImage(
                      //                     sliderImage[index].image!,
                      //                     height: 236.79.h,
                      //                     width: 170.h)
                      //                 .paddingOnly(
                      //                     bottom: 146.h,
                      //                     top: 26.h,
                      //                     left: 20.h,
                      //                     right: 20.h);
                      //           }),
                      //     )),
                      // Expanded(
                      //   child: Container(
                      //     child: Column(
                      //       children: [
                      //         atmospherRules(
                      //             'humidityIcon.png', 'Humidity', 55),
                      //         getVerSpace(20.h),
                      //         atmospherRules(
                      //             'sunlight.png', 'Sunlight', 55),
                      //         getVerSpace(20.h),
                      //         atmospherRules('height.png', 'Height', 55),
                      //       ],
                      //     ).paddingOnly(top: 82.h),
                      //   ),
                      // )
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: getSvgImage("arrow_square_left.svg",
                                height: 24.h, width: 24.h),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  share();
                                },
                                child: getSvgImage("share_icon.svg",
                                    height: 24.h, width: 24.h),
                              ),
                              getHorSpace(16.h),
                              GestureDetector(
                                onTap: () {
                                  plantDetailScreenController.onLikePosition();
                                },
                                child: plantDetailScreenController.likePosition
                                    ? getSvgImage("heart_fill.svg",
                                        height: 24.h,
                                        width: 24.h,
                                        color: regularBlack)
                                    : getSvgImage("heart.svg",
                                        height: 24.h,
                                        width: 24.h,
                                        color: regularBlack),
                              )
                            ],
                          ),
                        ],
                      ).paddingOnly(left: 20.h, right: 20.h, top: 20.h),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: indicater().paddingOnly(bottom: 90.h)),
                      getDivider(color: dividerColor, horPadding: 0)
                          .paddingOnly(top: 397.h),
                      getCustomFont(
                              "${widget.detail.name}", 22.sp, regularBlack, 1,
                              fontWeight: FontWeight.w700)
                          .paddingOnly(top: 418.h, left: 20.h, right: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getCustomFont("\$${widget.detail.price}", 16.sp,
                              regularBlack, 1,
                              fontWeight: FontWeight.w500),
                          Row(
                            children: [
                              getAddRemoveButton("add_icon.svg", function: () {
                                plantDetailScreenController
                                    .onQuntityIncrese(widget.detail.quntity);
                              }),
                              getHorSpace(20.h),
                              getCustomFont("${plantDetailScreenController.qu}",
                                  16, Color(0XFF000000), 1,
                                  fontWeight: FontWeight.w500),
                              getHorSpace(20.h),
                              plantDetailScreenController.qu > 1
                                  ? getAddRemoveButton("remove_icon.svg",
                                      function: () {
                                      plantDetailScreenController
                                          .onQuntityDicrese(
                                              plantDetailScreenController.qu);
                                      print(
                                          "Quntity is ================================ ${plantDetailScreenController.qu}");
                                    })
                                  : SizedBox(),
                            ],
                          )
                        ],
                      ).paddingOnly(top: 447.h, left: 20.h, right: 20.h),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    getVerSpace(20.h),
                    getCustomContainer(56.h, double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.h),
                                color: regularWhite,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 16,
                                      color: regularBlack.withOpacity(0.03))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getCustomFont("Sized", 16.sp, regularBlack, 1,
                                    fontWeight: FontWeight.w500),
                                Row(
                                  children: [
                                    getCustomFont(
                                        " Medium", 16.sp, buttonColor, 1,
                                        fontWeight: FontWeight.w500),
                                    getHorSpace(22.h),
                                    getSvgImage("arrow_down.svg",
                                        height: 16.h, width: 16.h)
                                  ],
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 16.h))
                        .paddingSymmetric(horizontal: 20.h),
                    getVerSpace(20.h),
                    getCustomContainer(148.h, double.infinity,
                        color: regularWhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont("Description", 18.sp, regularBlack, 1,
                                fontWeight: FontWeight.w600, txtHeight: 1.5.h),
                            getVerSpace(9.h),
                            getMultilineCustomFont(
                                "Dolor sit amet consectetur adipiscing elit duis. Integer quis auctor elit sed vulputate mi sit. Duis at consectetur lorem donec",
                                16.sp,
                                regularBlack,
                                txtHeight: 1.5.h)
                          ],
                        ).paddingOnly(top: 20.h, left: 20.h, right: 20.h)),
                    getVerSpace(20.h),
                    getCustomContainer(
                      315.h,
                      double.infinity,
                      color: regularWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                                  "Related Products", 18.sp, regularBlack, 1,
                                  txtHeight: 1.5.h, fontWeight: FontWeight.w600)
                              .paddingSymmetric(horizontal: 20.h),
                          getVerSpace(15.h),
                          SizedBox(
                            height: 240.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: popularPlant.length,
                              itemBuilder: (context, index) {
                                return GetBuilder<PopularPlantDataScreen>(
                                  init: PopularPlantDataScreen(),
                                  builder: (popularPlantDataScreen) =>
                                      getCustomContainer(235.h, 177.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16.h),
                                              color: regularWhite),
                                          child: GestureDetector(
                                              onTap: () {
                                                // Get.to();
                                              },
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      getCustomContainer(
                                                        180.h,
                                                        177.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.h),
                                                          color: bgColor,
                                                        ),
                                                        child: getAssetImage(
                                                                popularPlant[
                                                                        index]
                                                                    .image!,
                                                                height: 151.h,
                                                                width: 127.w)
                                                            .paddingOnly(
                                                                left: 26.h,
                                                                right: 24.h,
                                                                bottom: 14.h),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            popularPlantDataScreen
                                                                .onLikePosition(
                                                                    popularPlant[
                                                                        index]);
                                                          },
                                                          child: popularPlant[
                                                                      index]
                                                                  .initialvalue
                                                              ? getSvgImage(
                                                                      "heart_fill.svg",
                                                                      height:
                                                                          20.h,
                                                                      width:
                                                                          20.h)
                                                                  .paddingOnly(
                                                                      left:
                                                                          145.h,
                                                                      top: 12.h)
                                                              : getSvgImage(
                                                                      "heart.svg",
                                                                      height:
                                                                          20.h,
                                                                      width:
                                                                          20.h)
                                                                  .paddingOnly(
                                                                      left:
                                                                          145.h,
                                                                      top:
                                                                          12.h))
                                                    ],
                                                  ),
                                                  getVerSpace(8.h),
                                                  getCustomFont(
                                                      popularPlant[index].name!,
                                                      16.sp,
                                                      regularBlack,
                                                      1,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  getVerSpace(2.h),
                                                  getCustomFont(
                                                      "\$${popularPlant[index].price}",
                                                      14.sp,
                                                      regularBlack,
                                                      1,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ],
                                              ))).paddingSymmetric(
                                          horizontal: 10.h),
                                );
                              },
                            ),
                          )
                        ],
                      ).paddingOnly(top: 18.h, left: 0.h),
                    ),
                  ],
                ),
              ),
              getVerSpace(100.h)
            ],
          ),
          getViewCartButton("Items", "15.00", "View Cart", () {
            Get.to(MyCartScreen());
          }, () {})
        ],
      ),
    );
  }
}
