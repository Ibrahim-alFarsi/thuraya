import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/utils/color_category.dart';
import '../../../datafile/model_data.dart';
import '../../../model/address.dart';
import '../../../utils/constantWidget.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  List<ModelAddress> addressLists = Data.getAddress();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final addressForm = GlobalKey<FormState>();
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: GetBuilder<CartController>(
            init: CartController(),
            builder: (controller) => Form(
              key: addressForm,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                          color: regularWhite,
                          child: getAppBar("Add New Address", function: () {
                            Get.back();
                          })),
                      // getToolbar(context, () {
                      //   backClick();
                      // },
                      //     text: "Add New Address",
                      //     suffixIcon: false,
                      //     image: "filter.svg",
                      //     suffixFunction: () {}),
                      getVerSpace(20.h),
                      buildTextFieldWidget(context),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: getCustomButton("Save", () {
                      print(addressLists.length);
                      if (addressForm.currentState!.validate()) {
                        controller.addAddress(
                            countryController.text,
                            streetAddressController.text,
                            cityController.text,
                            pinCodeController.text,
                            phoneController.text);
                        Get.back();
                      }
                    }).paddingOnly(bottom: 30.h, right: 20.h, left: 20.h),
                    // getButton(context, accentColor,, Colors.white,
                    //        , 18.sp,
                    //         weight: FontWeight.w700,
                    //         buttonHeight: 60.h,
                    //         borderRadius: 10.h)
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildTextFieldWidget(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                shrinkWrap: true,
                primary: false,
                children: [
                  getVerSpace(20.h),
                  getTextField("Full Name*", controller: fullNameController,
                      validator: (fullName) {
                    if (fullName == null || fullName.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  }, enable: true),
                  getVerSpace(20.h),
                  getTextField("Country*", controller: countryController,
                      validator: (country) {
                    if (country == null || country.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  }, enable: true),
                  getVerSpace(20.h),
                  getTextField("Street Address*",
                      controller: streetAddressController, validator: (street) {
                    if (street == null || street.isEmpty) {
                      return 'Please enter your street address';
                    }
                    return null;
                  }, enable: true),
                  getVerSpace(20.h),
                  Row(
                    children: [
                      Expanded(
                          child: getTextField("Town/City*",
                              controller: cityController, validator: (city) {
                        if (city == null || city.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      }, enable: true)
                          // defaultTextField(
                          //     context, cityController, ,
                          //     validator: (city) {
                          //   if (city == null || city.isEmpty) {
                          //     return 'Please enter your city';
                          //   }
                          //   return null;
                          // }),
                          ),
                      getHorSpace(20.h),
                      Expanded(
                          child: getTextField("Pin Code*",
                              controller: pinCodeController,
                              validator: (pincode) {
                        if (pincode == null || pincode.isEmpty) {
                          return 'Please enter your pincode';
                        }
                        return null;
                      }, enable: true)
                          // defaultTextField(
                          //     context, pinCodeController, ,
                          //     validator: (pincode) {
                          //   if (pincode == null || pincode.isEmpty) {
                          //     return 'Please enter your pincode';
                          //   }
                          //   return null;
                          // },
                          //     keyboardType: TextInputType.number,
                          //     inputFormatters: [
                          //       FilteringTextInputFormatter.digitsOnly
                          //     ]),
                          ),
                    ],
                  ),
                  getVerSpace(20.h),
                  getTextField("Email*", controller: emailController,
                      validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  }, enable: true),
                  getVerSpace(20.h),
                  getTextField("Phone Number*", controller: phoneController,
                      validator: (phone) {
                    if (phone == null || phone.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  }, enable: true),
                  // defaultTextField(context, phoneController,
                  //    , keyboardType: TextInputType.number, inputFormatters: [
                  //   FilteringTextInputFormatter.digitsOnly
                  // ]),
                  getVerSpace(20.h),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.changeAddress();
                          },
                          child: GetBuilder<CartController>(
                            init: CartController(),
                            builder: (controller) => getSvgImage(
                                controller.checkShipping
                                    ? "cheak_button.svg"
                                    : "cheak_button_fill.svg",
                                height: 24.h,
                                width: 24.h),
                          )),
                      getHorSpace(10.h),
                      getCustomFont(
                          "Use as shipping address", 14.sp, regularBlack, 1,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                  getVerSpace(30.h),
                ],
              ),
            ).paddingOnly(bottom: 130.h)
          ],
        ),
      ),
    );
  }
}
