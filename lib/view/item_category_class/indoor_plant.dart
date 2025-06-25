import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/indoor_plant_data_model.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/color_category.dart';
import '../home/home_screens/sub_types_of_plant.dart';

class IndoorPlantScreen extends StatefulWidget {
  const IndoorPlantScreen({super.key});

  @override
  State<IndoorPlantScreen> createState() => _IndoorPlantScreenState();
}

class _IndoorPlantScreenState extends State<IndoorPlantScreen> {
  List<IndoorPlant> indoorPlant = Data.getIndoorPlant();

  IndoorPlantScreenController indoorPlantScreenController =
      Get.put(IndoorPlantScreenController());

  final Future<bool> _future = Future<bool>.delayed(
    Duration(milliseconds: 400),
    () {
      return true;
    },
  );

  @override
  Widget build(BuildContext context) {
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
    return GetBuilder<IndoorPlantScreenController>(
        init: IndoorPlantScreenController(),
        builder: (indoorPlantScreenController) => GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 185.h,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 21.h),
              itemCount: indoorPlant.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    indoorPlantScreenController.onSetIndex(index);
                    Get.to(SubTypesOfPlant());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.h),
                        color: regularWhite),
                    child: Column(
                      children: [
                        getCustomContainer(149.h, 142.h,
                            decoration: indoorPlantScreenController
                                        .selectionIndex ==
                                    index
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.h),
                                    border: Border.all(
                                        color: buttonColor, width: 1.5.h),
                                    color: bgColor)
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.h),
                                    color: bgColor),
                            child: getAssetImage(indoorPlant[index].image!)
                                .paddingOnly(
                                    left: 10.h,
                                    right: 10.h,
                                    top: 15.h,
                                    bottom: 17.h)),
                        getVerSpace(10.h),
                        getCustomFont(
                            indoorPlant[index].name!, 14.sp, regularBlack, 1,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  ),
                );
              },
            ));
  }
}
