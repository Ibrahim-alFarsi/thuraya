import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/my_address_data.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constantWidget.dart';
import 'package:thuraya_app/view/home/cart_screens/address_edit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controller/controller.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  MyAddressScreenController myAddressScreenController =
      Get.put(MyAddressScreenController());
  List<MyAddressDetail> addressDetail = Data.getMyAddressData();

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
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: regularWhite,
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                myAddressScreenController.onAddposition(false);
                Get.to(AddressEdit());
              },
              backgroundColor: Color(0XFF76974C),
              tooltip: "Add New Address",
              child: Icon(Icons.add_location)),
          body: SafeArea(

              child:  GetBuilder<MyAddressScreenController>(
                init: MyAddressScreenController(),
                builder: (myAddressScreenController) => Column(
                  children: [
                    Container(
                      color: regularWhite,
                      child: getAppBar("My Address", function: () {
                        Get.back();
                      }, space: 105.w),
                    ),
                    addressDetail.isEmpty
                        ? getVerSpace(147.h)
                        : getVerSpace(20.h),
                    addressDetail.isEmpty
                        ? getSuccessConfirmMessegeFormate(
                        "conformOrder.png",
                        "No Address Yet!",
                        "Lorem ipsum dolor sit amet conse ctetur adipiscing elit",
                        "Add",
                            () {},
                        textColor: Color(0XFF76974C),
                        Decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0XFF76974C),
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(16))))
                        : Expanded(
                      child: FutureBuilder<bool>(
                        future: _future,
                        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            return  addressList();
                          } else {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.14),
                              highlightColor: bgColor,
                              direction: ShimmerDirection.ltr,
                              child:  addressList(),
                            );
                          }
                        },
                      )
                    ),
                    getVerSpace(30.h),
                  ],
                ),
              )
             /**/)),
    );
  }

  Widget addressList() {
    return ListView.builder(
      itemCount: addressDetail.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: getMyaddressFormate(
              addressDetail[index].addressPlace!,
              addressDetail[index].address!,
              addressDetail[index].mobileNumber!),
        );
      },
    );
  }
}
