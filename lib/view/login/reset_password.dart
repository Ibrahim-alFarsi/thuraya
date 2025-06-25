import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/login/reset_password_success.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  ResetPaswordEmptyStateController resetPaswordEmptyStateController =
      Get.put(ResetPaswordEmptyStateController());
  final formkey = GlobalKey<FormState>();
  String? newpass = '';

  String? confpass = '';
  String? error = '';

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    setStatusBarColor(Color(0XFFE5E5E5));
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
              child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: bgColor,
                  child: getAppBar("", function: () {
                    Get.back();
                  }),
                ),
                getVerSpace(40.h),
                Center(
                        child: getCustomFont(
                            "Reset Password", 28.sp, Color(0XFF000000), 1,
                            fontWeight: FontWeight.w700))
                    .paddingSymmetric(horizontal: 20.h),
                getVerSpace(30.h),
                getTextField("New Password",
                    fontWeight: FontWeight.w500,
                    fontsize: 16.sp, validator: (password) {
                  newpass = '';
                  newpass = password;
                  if (password!.isEmpty) {
                    return 'Enter the  password';
                  }
                  if (password.length < 8) {
                    return 'Please enter 8 character password';
                  }
                  return null;
                }).paddingSymmetric(horizontal: 20.h),
                getVerSpace(20.h),
                getTextField("Confirm Password",
                    fontWeight: FontWeight.w500,
                    fontsize: 16.sp, validator: (confirmpassword) {
                  confpass = '';
                  confpass = confirmpassword;
                  if (confirmpassword!.isEmpty) {
                    return 'Enter the  password';
                  }
                  if (confirmpassword.length < 8) {
                    return 'Please enter 8 character password';
                  }
                  return null;
                }).paddingSymmetric(horizontal: 20.h),
                getVerSpace(20.h),
                error!.isNotEmpty
                    ? getCustomFont("$error", 14, Colors.red, 1)
                    : SizedBox(),
                getVerSpace(40.h),
                getCustomButton("Submit", () {
                  if (formkey.currentState!.validate() && newpass == confpass) {
                    Get.to(ResetPasswordSuccess());
                  } else {
                    error = '';
                    error = "Please check password";
                    return error;
                  }
                }).paddingSymmetric(horizontal: 20.h),
              ],
            ),
          )),
        ));
  }
}
