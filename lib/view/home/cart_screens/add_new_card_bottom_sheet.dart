import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constantWidget.dart';

class CardBottomSheet extends StatefulWidget {
  const CardBottomSheet({super.key});

  @override
  State<CardBottomSheet> createState() => _CardBottomSheetState();
}

class _CardBottomSheetState extends State<CardBottomSheet> {
  bool ischeaked = false;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);

    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Center(
                child: Container(
                    height: 4.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: const Color(0XFF12121D)))),
            getVerSpace(15.h),
            Center(child: getCustomFont("Add Card", 18.sp, Color(0XFF000000), 1,fontWeight: FontWeight.w700)),
            getVerSpace(20.h),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.h),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-14, 8),
                        color:
                        Color(0XFF181414).withOpacity(0.08),
                        blurRadius: 32,),
                    ],
                    color: Colors.white),
                child: getTextField(
                  "Name On Card",
                )),
            //card_name_field('Name On Card', 'assets/profileicon1st.png'),
            getVerSpace(20.h),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.h),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-14, 8),
                        color:
                        Color(0XFF181414).withOpacity(0.08),
                        blurRadius: 32,),
                    ],
                    color: Colors.white),
                child: getTextField("Card Number")),

            getVerSpace(20.h),
            Row(children: [
              Expanded(
                child: Container(
                  height: 60.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.h),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-14, 8),
                          color:
                          Color(0XFF181414).withOpacity(0.08),
                          blurRadius: 32,),
                      ],
                      color: Colors.white),
                  child: Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: getTextField("MM/YY")),
                ),
              ),
              getHorSpace(20.w),
              Expanded(
                child: Container(
                  height: 60.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.h),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-14, 8),
                          color:
                          Color(0XFF181414).withOpacity(0.08),
                          blurRadius: 32,),
                      ],
                      color: Colors.white),
                  child: Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: getTextField("CVV")),
                ),
              )
            ]),
            getVerSpace(20.5.h),
            save_card_cheakbox(),
            getVerSpace(21.h),
            // add_button(),
            getCustomButton(
              "Add",
              () {},
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.h),
                color: ischeaked ? const Color(0XFF76974C) : Colors.grey,
              ),
            ),
            getVerSpace(40.h),
          ]),
    );
  }

  Widget save_card_cheakbox() {
    return Row(
      children: [
        Checkbox(
          value: ischeaked,
          activeColor: const Color(0XFF76974C),
          side: const BorderSide(color: Color(0XFF76974C)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.h)),
          onChanged: (value) {
            setState(() {
              ischeaked = value!;
            });
          },
        ),
        getHorSpace(10.w),
        getCustomFont("Save Card", 15.sp, Color(0XFF000000), 1)
      ],
    );
  }
}
