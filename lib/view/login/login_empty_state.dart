import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/utils/pref_data.dart';
import 'package:thuraya_app/view/home/home_main_screen.dart';
import 'package:thuraya_app/view/login/forgetpassword_empty_state.dart';
import 'package:thuraya_app/view/sign_up/sign_up_empty_screen.dart';

class LoginEmptyState extends StatefulWidget {
  const LoginEmptyState({super.key});

  @override
  State<LoginEmptyState> createState() => _LoginEmptyStateState();
}

class _LoginEmptyStateState extends State<LoginEmptyState> {
  LoginEmptyStateController loginEmptyStateController =
      Get.put(LoginEmptyStateController());
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 36.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Form(
                key: formkey,
                child: GetBuilder<LoginEmptyStateController>(
                  init: LoginEmptyStateController(),
                  builder: (loginEmptyStateController) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getVerSpace(36.h),
                      getAssetImage("full_logo.png",
                          height: 107.55.h, width: 80.98.h),
                      getVerSpace(56.45.h),
                      Center(
                          child: getCustomFont(
                        "Login",
                        28.sp,
                        Color(0XFF000000),
                        1,
                        fontWeight: FontWeight.w700,
                      )),
                      getVerSpace(30.h),
                      Expanded(
                          child: ListView(
                        children: [
                          getTextField("Email Address",
                              fontWeight: FontWeight.w500,
                              fontsize: 16.sp, validator: (email) {
                            if (email!.isEmpty) {
                              return 'Enter the  email';
                            } else {
                              if (!RegExp(
                                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                  .hasMatch(email)) {
                                return 'Please enter valid email address';
                              }
                            }
                            return null;
                          }),
                          getVerSpace(20.h),
                          getTextField("Password",
                              fontWeight: FontWeight.w500,
                              fontsize: 16.sp, validator: (password) {
                            if (password!.isEmpty) {
                              return 'Enter the  password';
                            }
                            if (password.length < 8) {
                              return 'Please enter 8 charecter password';
                            }
                            return null;
                          }),
                          getVerSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  loginEmptyStateController
                                      .onRememberPosition();
                                },
                                child: Row(
                                  children: [
                                    loginEmptyStateController.remember
                                        ? getSvgImage("cheak_button_fill.svg",
                                            height: 20.h, width: 20.h)
                                        : getSvgImage("cheak_button.svg",
                                            height: 20.h, width: 20.h),
                                    getHorSpace(8.h),
                                    getCustomFont(
                                        "Remember me", 16.sp, regularBlack, 1,
                                        fontWeight: FontWeight.w500)
                                  ],
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(ForgetPasswordEmptyState());
                                  },
                                  child: getCustomFont("Forgot Password?",
                                      16.sp, Color(0XFF000000), 1,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          getVerSpace(40.h),
                          getCustomButton("Login", () {
                            if (formkey.currentState!.validate() &&
                                loginEmptyStateController.remember == true) {
                              PrefData.setIsSignIn(false);
                              Get.to(HomeMainScreen());
                            }
                          }),
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
                        child: getRichtext("Don’t have a account?", " Sign Up",
                            function: () {
                          Get.to(SignUpEmptyState());
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
