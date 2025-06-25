import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';

class AddressEdit extends StatefulWidget {
  const AddressEdit({super.key});

  @override
  State<AddressEdit> createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  AddressEditController addressEditController =
      Get.put(AddressEditController());
  TextEditingController addressPlaceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: bgColor,
          body: SafeArea(
            child: GetBuilder<MyAddressScreenController>(
              init: MyAddressScreenController(),
              builder: (myAddressScreenController) => Column(
                children: [
                  Container(
                    color: regularWhite,
                    child: getAppBar(
                        myAddressScreenController.pos
                            ? "Edit Address"
                            : "Add New Address", function: () {
                      Get.back();
                      myAddressScreenController.onAddposition(true);
                    }),
                  ),
                  getVerSpace(20.h),
                  Expanded(
                      child: ListView(
                    children: [
                      getEditProfileOptionFormate(false,
                          iconImage: "profileIcon.png", hint: 'Full Name'),
                      getVerSpace(20.h),
                      getEditProfileOptionFormate(false,
                          iconImage: "mobileIcon.png",
                          hint: 'Street Address',
                          height: 120.h),
                      getVerSpace(20.h),
                      getEditProfileOptionFormate(false, hint: 'Pin Code'),
                      getVerSpace(20.h),
                      getEditProfileOptionFormate(
                        true,
                        hint: 'Country',
                      ),
                      getVerSpace(20.h),
                      getEditProfileOptionFormate(true, hint: 'Country Code'),
                      getVerSpace(20.h),
                      getEditProfileOptionFormate(true, hint: 'Phone Number'),
                    ],
                  )),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
                    child: getCustomButton("Save", () {
                      Get.back();
                    }),
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    addressPlaceController.dispose();
    addressController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }
}
