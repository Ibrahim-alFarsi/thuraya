import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/my_order_data_model.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/home/home_main_screen.dart';
import 'package:thuraya_app/view/home/profile_screens/active_order.dart';
import 'package:thuraya_app/view/home/profile_screens/completed_order.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constant.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  MyOrderScreenController myOrderScreenController =
      Get.put(MyOrderScreenController());
  PageController pageController = PageController();
  List<MyOrderData> myOrder = Data.getMyOrderData();
  List orderPositionClass = [ActiveOrderScreen(), CompletedOrderScreen()];

  final Future<bool> _future = Future<bool>.delayed(
    Duration(milliseconds: 400),
    () {
      return true;
    },
  );

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        myOrderScreenController.myOrder
            ? SizedBox()
            : Get.off(HomeMainScreen());
        return myOrderScreenController.myOrder
            ? Future.value(true)
            : Future.value(false);
      },
      child: Scaffold(
          backgroundColor: regularWhite,
          body: SafeArea(
            child: GetBuilder<MyOrderScreenController>(
              init: MyOrderScreenController(),
              builder: (myOrderScreenController) => Column(
                children: [
                  Container(
                    color: regularWhite,
                    child: getAppBar("My Order", function: () {
                      myOrderScreenController.myOrder
                          ? Get.back()
                          : Get.off(HomeMainScreen());
                    }, space: 105.w),
                  ),
                  getVerSpace(20.h),
                  Expanded(
                    child: Container(
                        color: regularWhite,
                        child: FutureBuilder<bool>(
                          future: _future,
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            if (snapshot.hasData) {
                              return myOrderList();
                            } else {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.14),
                                highlightColor: bgColor,
                                direction: ShimmerDirection.ltr,
                                child: myOrderList(),
                              );
                            }
                          },
                        )),
                  ),
                  getVerSpace(30.h),
                ],
              ),
            ), /*  */
          )),
    );
  }

  Widget myOrderList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      itemCount: myOrder.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            getActiveOrderFormet(
                myOrder[index].orderPosition!,
                myOrder[index].detailImage!,
                myOrder[index].name!,
                myOrder[index].date!,
                myOrder[index].price!.toDouble(),
                myOrder[index].quntity.toDouble()),
            getDivider(color: dividerColor, horPadding: 0)
          ],
        );
      },
    );
  }
}
