import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/notification_data.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/constant_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotiFicationData> notificationData = Data.getNotiFicationData();

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
        body: SafeArea(
            child: FutureBuilder<bool>(
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
        )),
      ),
    );
  }

  Widget column() {
    return Column(
      children: [
        Container(
          color: regularWhite,
          child: getAppBar("Notifications", space: 99.w, function: () {
            Get.back();
          }),
        ),
        getVerSpace(10.h),
        Expanded(
            child: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              itemCount: notificationData.length,
              itemBuilder: (context, index) => getNotificationFormate(
                  index + 1,
                  notificationData[index].messege!,
                  notificationData[index].time!),
            )
          ],
        )),
        getVerSpace(30.h)
      ],
    );
  }
}
