import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/popular_plant.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constantWidget.dart';
import 'package:thuraya_app/view/item_category_class/plant_detail_screen.dart';

class PopularPlantScreen extends StatefulWidget {
  const PopularPlantScreen({super.key});

  @override
  State<PopularPlantScreen> createState() => _PopularPlantScreenState();
}

class _PopularPlantScreenState extends State<PopularPlantScreen> {
  PopularPlantDataScreen popularPlantDataScreen =
      Get.put(PopularPlantDataScreen());
  List<PopularPlant> popularPlant = Data.getPopularPlantData();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            body: GetBuilder<PopularPlantDataScreen>(
              init: PopularPlantDataScreen(),
              builder: (popularPlantData) => Column(
                children: [
                  Container(
                      height: 73.h,
                      width: double.infinity,
                      color: regularWhite,
                      child: getAppBar("Popular Plants", space: 89.h,
                          function: () {
                        Get.back();
                      })),
                  getVerSpace(20.h),
                  Expanded(
                      child: Container(
                    color: regularWhite,
                    child: AnimationLimiter(
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 240.h,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 10.h),
                        itemCount: popularPlant.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              child: ScaleAnimation(
                                  child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(PlantDetail(
                                        detail: popularPlant[index]));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.h),
                                        color: regularWhite),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            getCustomContainer(
                                              180.h,
                                              197.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.h),
                                                  color: bgColor),
                                              child: getAssetImage(
                                                      popularPlant[index]
                                                          .image!)
                                                  .paddingOnly(
                                                      left: 26.h,
                                                      right: 24.h,
                                                      top: 15.h,
                                                      bottom: 14.h),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  popularPlantDataScreen
                                                      .onLikePosition(
                                                          popularPlant[index]);
                                                },
                                                child: popularPlant[index]
                                                        .initialvalue
                                                    ? getSvgImage(
                                                            "heart_fill.svg",
                                                            height: 20.h,
                                                            width: 20.h)
                                                        .paddingOnly(
                                                            left: 165.h,
                                                            top: 12.h)
                                                    : getSvgImage("heart.svg",
                                                            height: 20.h,
                                                            width: 20.h)
                                                        .paddingOnly(
                                                            left: 165.h,
                                                            top: 12.h))
                                          ],
                                        ),
                                        getVerSpace(8.h),
                                        getCustomFont(popularPlant[index].name!,
                                            16.sp, regularBlack, 1,
                                            fontWeight: FontWeight.w700),
                                        getVerSpace(2.h),
                                        getCustomFont(
                                            "\$${popularPlant[index].price}",
                                            14.sp,
                                            regularBlack,
                                            1,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ),
                              )));
                        },
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
/*Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Color(0XFFFFFFFF),
            body: GetBuilder<PlantDetailScreenController>(
              init: PlantDetailScreenController(),
              builder: (plantdetailcontroller) => Column(
                children: [
                  getAppBar("Popular Plants", function: () {
                    Get.back();
                    setStatusBarColor(Color(0XFFE8F0DE));
                  }),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.8,
                          scrollDirection: Axis.vertical,
                          children: popularPlantData.map((e) {
                            return GestureDetector(
                              onTap: () {
                                plantdetailcontroller.onBackposition(false);
                                Get.to(PlantDetail(detail: e));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white),
                                child: getPopularDataFormet(e.image!, () {
                                  print("before============${e.initialvalue}");
                                  popularPlantDataScreen.onLikePosition(e);
                                  print("after============${e.initialvalue}");
                                }, e.initialvalue, e.name!, e.price.toString(),
                                    imageContainerHeight: 180.h,
                                    imageContainerWidth: 178.w,
                                    namefontsize: 16.sp,
                                    namefontweight: FontWeight.w700,
                                    pricefontsize: 16.sp,
                                    pricefontweight: FontWeight.w700,
                                    iconheight: 16.h,
                                    iconleftpad: 151.w,
                                    icontoppad: 10.h,
                                    iconwidth: 16.w,
                                    imageandnamespace: 12.h,
                                    nameandpricespace: 3.h),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }*/
}
