import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/plant_product.dart';
import 'package:thuraya_app/model/popular_plant.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constantWidget.dart';
import 'package:thuraya_app/view/item_category_class/plant_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<PlantProduct> plantdata = Data.getPlantProductData();
  List<PopularPlant> popularplantdata = Data.getPopularPlantData();

  final Future<bool> _future = Future<bool>.delayed(
    Duration(milliseconds: 400),
    () {
      return true;
    },
  );

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return FutureBuilder<bool>(
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
    );
  }

  Widget column() {
    return GetBuilder(
        init: HomeScreenController(),
        builder: (homeScreencontroller) => ScrollConfiguration(
              behavior: ScrollBehavior()
                // ignore: deprecated_member_use
                ..buildOverscrollIndicator(context, Container(), ScrollableDetails.vertical()),
              child: SizedBox(
                  height: 259,
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior()
                      // ignore: deprecated_member_use
                      ..buildOverscrollIndicator(
                          context, Container(), ScrollableDetails.vertical()),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 259.h,
                          mainAxisSpacing: 20.h,
                          crossAxisSpacing: 20.h),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return GetBuilder<PopularPlantDataScreen>(
                          init: PopularPlantDataScreen(),
                          builder: (setcontroller) => GestureDetector(
                            onTap: () {
                              // Get.to(PlantDetail(detail: plantdata[index]));
                              Get.to(PlantDetail(
                                detail: popularplantdata[index],
                              ));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 177.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.h),
                                      color: Color(0XFFE5E5E5),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "${Constant.assetImagePath}${plantdata[index].image}"),
                                          fit: BoxFit.fill)),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.h),
                                    child: Column(
                                      children: [
                                        getVerSpace(201.h),
                                        Row(
                                          children: [
                                            getCustomFont(
                                                plantdata[index].name!,
                                                16,
                                                Color(0XFF000000),
                                                1,
                                                fontWeight: FontWeight.w700),
                                            getHorSpace(5.h),
                                            getCustomFont(
                                                "(${plantdata[index].category})",
                                                12.sp,
                                                regularBlack,
                                                1,
                                                fontWeight: FontWeight.w400)
                                          ],
                                        ),
                                        getVerSpace(4.h),
                                        getCustomFont(
                                            "\$${plantdata[index].price.toString()}",
                                            14,
                                            Color(0XFF000000),
                                            1,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 149.w, top: 12.h),
                                    child: GestureDetector(
                                        onTap: () {
                                          setcontroller
                                              .onLikeCHange(plantdata[index]);
                                          print(plantdata[index].initialvalue);
                                        },
                                        child: plantdata[index].initialvalue
                                            ? getAssetImage("likefillIcon.png",
                                                height: 16, width: 16)
                                            : getAssetImage("likeIcon.png",
                                                height: 16, width: 16)))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  /* ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const BouncingScrollPhysics(),
                itemCount:2,
                itemBuilder: (context, index) => GetBuilder<PopularPlantDataScreen>(
                  init: PopularPlantDataScreen(),
                  builder:(setcontroller) =>Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GestureDetector(
                          onTap: (){
                           // Get.to(PlantDetail(detail: plantdata[index]));
                            Get.to(PlantDetail(detail: popularplantdata[index],));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 259.h,
                                width: 177.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(16.h),
                                    color: Color(0XFFE5E5E5),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "${Constant.assetImagePath}${plantdata[index].image}"),
                                        fit: BoxFit.fill)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Column(
                                    children: [
                                      getVerSpace(201.h),
                                      Row(
                                        children: [
                                          getCustomFont("${plantdata[index].name!}",
                                              16, Color(0XFF000000), 1,
                                              fontWeight: FontWeight.w700),
                                          getHorSpace(5.h),
                                          getCustomFont("(${plantdata[index].category})", 12.sp, regularBlack, 1,fontWeight: FontWeight.w400)
                                        ],
                                      ),
                                      getVerSpace(4.h),
                                      getCustomFont(
                                          "\$${plantdata[index].price.toString()}",
                                          14,
                                          Color(0XFF000000),
                                          1,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 149.w, top: 12.h),
                                  child: GestureDetector(
                                      onTap: () {
                                        setcontroller
                                            .onLikeCHange(plantdata[index]);
                                        print(
                                            plantdata[index].initialvalue);
                                      },
                                      child: plantdata[index].initialvalue
                                          ? getAssetImage(
                                              "likefillIcon.png",
                                              height: 16,
                                              width: 16)
                                          : getAssetImage("likeIcon.png",
                                              height: 16, width: 16)))
                            ],
                          ),
                        ),
                      ),
                )),*/
                  ),
            ));
  }
}
