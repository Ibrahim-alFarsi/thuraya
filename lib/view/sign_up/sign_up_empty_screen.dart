import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/home/profile_screens/terms_and_condition.dart';
import 'package:thuraya_app/view/sign_up/verification_screen.dart';

class SignUpEmptyState extends StatefulWidget {
  const SignUpEmptyState({super.key});

  @override
  State<SignUpEmptyState> createState() => _SignUpEmptyStateState();
}

class _SignUpEmptyStateState extends State<SignUpEmptyState> {
  SignUpEmptyStateController signUpEmptyStateController =
      Get.put(SignUpEmptyStateController());
  final phoneNumberkey = GlobalKey<FormState>();
  String? setpassword = '';
  String? setConfirmPassword = '';
  TextEditingController phoneNumberCheakController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: bgColor,
          body: SafeArea(
            child: Form(
              key: formkey,
              child: GetBuilder<SignUpEmptyStateController>(
                init: SignUpEmptyStateController(),
                builder: (signUpEmptyStateController) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      children: [
                        getVerSpace(36.h),
                        getAssetImage("full_logo.png",
                            height: 107.55.h, width: 80.98.h),
                        getVerSpace(56.45.h),
                        Center(
                            child: getCustomFont(
                                "Sign Up", 28.sp, Color(0XFF000000), 1,
                                fontWeight: FontWeight.w700)),
                        getVerSpace(30.h),
                        getTextField("Full Name",
                            fontsize: 16.sp,
                            fontWeight: FontWeight.w500, validator: (name) {
                          if (name!.isEmpty) {
                            return 'Enter your name';
                          }
                          return null;
                        }),
                        getVerSpace(20.h),
                        getTextField("Email Address",
                            fontsize: 16.sp,
                            fontWeight: FontWeight.w500, validator: (email) {
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
                        getTextField("Password", validator: (password) {
                          setpassword = '';
                          setpassword = password;
                          if (password!.isEmpty) {
                            return 'Enter the  password';
                          }
                          if (password.length < 8) {
                            return 'Please enter 8 charecter password';
                          }
                          return null;
                        }),
                        getVerSpace(20.h),
                        getTextField("Confirm Password",
                            validator: (confirmPassword) {
                          setConfirmPassword = '';
                          setConfirmPassword = confirmPassword;
                          if (confirmPassword!.isEmpty) {
                            return 'Enter the  password';
                          }
                          if (confirmPassword.length < 8) {
                            return 'Please enter 8 charecter password';
                          }
                          if (setpassword != setConfirmPassword) {
                            return 'Please cheak the password';
                          }
                          return null;
                        }),
                        getVerSpace(20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signUpEmptyStateController.onRememberPosition();
                              },
                              child: Row(
                                children: [
                                  signUpEmptyStateController.remember
                                      ? getSvgImage("cheak_button_fill.svg",
                                          height: 20.h, width: 20.h)
                                      : getSvgImage("cheak_button.svg",
                                          height: 20.h, width: 20.h),
                                  getHorSpace(8.h),
                                  getRichtext(
                                      "I accepted", " Terms & Privacy Policy",
                                      function: () {
                                    Get.to(TermCondition());
                                  },
                                      firsttextSize: 16.sp,
                                      secondtextSize: 16.sp,
                                      firstTextwidth: FontWeight.w500,
                                      secondTextwidth: FontWeight.w500,
                                      firsttextcolor: regularBlack,
                                      secondtextcolor: buttonColor)
                                ],
                              ),
                            ),
                          ],
                        ),
                        getVerSpace(40.h),
                        getCustomButton("Sign Up", () {
                          if (formkey.currentState!.validate() &&
                              signUpEmptyStateController.remember == true) {
                            Get.to(VerificationScreen());
                          }
                        }),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*
  Expanded(
                  flex: 1,
                  child: ListView(
                    primary: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 20.h),
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
                              fontFamily: 'Gilroy',
                              color: Color(0XFF000000)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Center(
                          child: Text(
                            "Glad to meet you again!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color(0XFF000000),
                                fontSize: 15.sp,
                                fontFamily: 'Gilroy',
                                fontStyle: FontStyle.normal
                            ),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(height: 10.h),
                      email_password_form(),
                      SizedBox(height: 21.h),
                      forgotpassword(),
                      SizedBox(height: 40.h),
                      loginbutton(),
                      SizedBox(height: 40.h),
                      or_sign_in_with_text(),
                      SizedBox(height: 41.h),
                      login_google(),
                      SizedBox(height: 20.h),
                      login_facebook(),
                      //SizedBox(height: 97.h),

                    ],
                  ),
                ),
 */
