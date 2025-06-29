import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/plant_type_category.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/item_category_class/indoor_plant.dart';
import '../../../utils/color_category.dart';

class PlantTypeScreen extends StatefulWidget {
  const PlantTypeScreen({super.key});

  @override
  State<PlantTypeScreen> createState() => _PlantTypeScreenState();
}

class _PlantTypeScreenState extends State<PlantTypeScreen> {
  PlantTypeScreenController plantTypeScreenController =
      Get.put(PlantTypeScreenController());
  List<PlantTypesCategory> plantTypes = Data.getPlantTypesCategory();
  List typeClass = [
    IndoorPlantScreen(),
    IndoorPlantScreen(),
    IndoorPlantScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: regularWhite,
          body: SafeArea(
            child: GetBuilder<PlantTypeScreenController>(
              init: PlantTypeScreenController(),
              builder: (plantTypeScreenController) => Column(children: [
                Container(
                    height: 73.h,
                    width: double.infinity,
                    color: regularWhite,
                    child: getAppBar("Plant Type", space: 109.h, function: () {
                      Get.back();
                    })),
                getVerSpace(20.h),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        width: 99.h,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: plantTypes.length,
                          primary: true,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            PlantTypesCategory modelCategory =
                                plantTypes[index];
                            return plantTypeScreenController.index.value ==
                                    index
                                ? Container(
                                    height: 56.h,
                                    color: lightbuttonColor,
                                    child: getCustomFont(
                                            modelCategory.categoryName!,
                                            16.sp,
                                            buttonColor,
                                            1,
                                            fontWeight: FontWeight.w700)
                                        .paddingOnly(right: 33.h)
                                        .paddingOnly(left: 14.h, top: 16.h),
                                  )
                                : SizedBox(
                                    height: 56.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        plantTypeScreenController
                                            .onChange(index);
                                      },
                                      child: Center(
                                        child: getCustomFont(
                                            modelCategory.categoryName!,
                                            16.sp,
                                            regularBlack,
                                            1,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      getHorSpace(10.h),
                      Expanded(
                        child: Container(
                          color: regularWhite,
                          child:
                              typeClass[plantTypeScreenController.index.value],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
