import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/popular_plant.dart';
import 'package:thuraya_app/utils/constant.dart';
import '../../../controller/controller.dart';

class ActiveOrderScreen extends StatefulWidget {
  const ActiveOrderScreen({super.key});

  @override
  State<ActiveOrderScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
  List<PopularPlant> popularPlantData = Data.getPopularPlantData();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: GetBuilder<MyOrderScreenController>(
          init: MyOrderScreenController(),
          builder: (myOrderScreenController) => Column(
            children: [],
          ),
        ));
  }
}
