import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thuraya_app/controller/controller.dart';
import 'package:thuraya_app/datafile/model_data.dart';
import 'package:thuraya_app/model/blog_data_model.dart';
import 'package:thuraya_app/model/popular_plant.dart';
import 'package:thuraya_app/utils/color_category.dart';
import 'package:thuraya_app/utils/constant.dart';
import 'package:thuraya_app/utils/constant_widget.dart';
import 'package:thuraya_app/view/home/home_screens/popular_plant_grid.dart';
import 'package:thuraya_app/view/home/home_screens/serch_filter_sheet.dart';
import 'package:thuraya_app/view/home/profile_screens/notification%20_scrern.dart';
import 'package:thuraya_app/view/home/home_screens/plant_type_screen.dart';
import 'package:thuraya_app/view/home/home_screens/search_screen.dart';
import 'package:thuraya_app/view/item_category_class/all_products.dart';
import '../../../model/plant_product.dart';
import 'blogScreen.dart';
import 'blog_data_grid.dart';
import 'popularPlant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<PlantProduct> plantdata = Data.getPlantProductData();
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  List<PopularPlant> popularplantdata = Data.getPopularPlantData();
  List<Blog> blogData = Data.getBlogData();
  late TabController _tabController;
  late PageController _pController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _pController = PageController();
    super.initState();
  }

  List itemCtegoryClass = [
    AllProducts(),
    AllProducts(),
    AllProducts(),
    AllProducts()
  ];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (homeScreenController) => column());
  }

  Widget column() {
    return Scaffold(
      backgroundColor: regularWhite,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                color: regularWhite,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getCustomFont("Find your favourite plants", 22.sp,
                            Color(0XFF000000), 1,
                            fontWeight: FontWeight.w700),
                        GestureDetector(
                            onTap: () {
                              Get.to(NotificationScreen());
                            },
                            child: getSvgImage("notificationIcon.svg",
                                height: 24.h, width: 24.h))
                      ],
                    ),
                    getVerSpace(24.h),
                    getSearchField("Search...",
                        fontweight: FontWeight.w500,
                        function: () {
                          Get.to(SearchScreen());
                        },
                        prefixiconimage: "searchIcon.png",
                        suffixiconimage: "filterIcon.png",
                        suffixfunction: () {
                          showModalBottomSheet(
                              backgroundColor: regularWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(22.h),
                                      topRight: Radius.circular(22.h))),
                              context: context,
                              builder: (context) => const FilterSheet());
                        }),
                    getVerSpace(20.h)
                  ],
                ).paddingSymmetric(horizontal: 20.h)),
            Expanded(
              child: ListView(
                shrinkWrap: false,
                primary: true,
                physics: BouncingScrollPhysics(),
                children: [
                  getVerSpace(20.h),
                  Column(
                    children: [
                      Container(
                          height: 140.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.h),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "${Constant.assetImagePath}corosolSliderBanner.png"),
                                  fit: BoxFit.fill)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: getCustomContainer(36.h, 109.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.h),
                                        color: regularWhite),
                                    child: Center(
                                      child: getCustomFont(
                                          "Buy Now", 14.sp, regularBlack, 1,
                                          fontWeight: FontWeight.w600),
                                    )).paddingOnly(left: 21.h, top: 84.h),
                              ),
                            ],
                          )).paddingSymmetric(horizontal: 20.h),
                      getVerSpace(20.h),
                      getCustomContainer(413.h, double.infinity,
                          color: regularWhite,
                          child: Column(
                            children: [
                              getVerSpace(20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getCustomFont(
                                      "Plant Type", 20.sp, Color(0XFF000000), 1,
                                      fontWeight: FontWeight.w700,
                                      txtHeight: 1.5.h),
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(PlantTypeScreen());
                                      },
                                      child: getCustomFont(
                                          "View more", 14, buttonColor, 1,
                                          fontWeight: FontWeight.w400,
                                          txtHeight: 1.5.h))
                                ],
                              ).paddingSymmetric(horizontal: 20.h),
                              getVerSpace(14.h),
                              getTabBar(_tabController, _pController, [
                                Container(
                                    child: const Tab(
                                  text: "All ",
                                ).paddingSymmetric(horizontal: 10.h)),
                                const Tab(
                                  text: "Outdoors",
                                ),
                                const Tab(
                                  text: "Indoors",
                                ),
                                const Tab(
                                  text: "Garden",
                                ),
                              ]).paddingSymmetric(horizontal: 20.h),
                              getVerSpace(20.h),
                              Expanded(
                                child: PageView.builder(
                                  controller: _pController,
                                  onPageChanged: (value) {
                                    _tabController.animateTo(value,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                  },
                                  itemCount: itemCtegoryClass.length,
                                  itemBuilder: (context, index) {
                                    return itemCtegoryClass[index];
                                  },
                                ),
                              ),
                            ],
                          )),
                      getVerSpace(20.h),
                      Container(
                          color: regularWhite,
                          child: Column(
                            children: [
                              getVerSpace(20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getCustomFont("Popular Plants", 20.sp,
                                      Color(0XFF000000), 1,
                                      fontWeight: FontWeight.w700,
                                      txtHeight: 1.5.h),
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(PopularPlantScreen());
                                      },
                                      child: getCustomFont(
                                          "View more", 14, buttonColor, 1,
                                          fontWeight: FontWeight.w400,
                                          txtHeight: 1.5.h))
                                ],
                              ).paddingSymmetric(horizontal: 20.h),
                              getVerSpace(20.h),
                              opulerPlantGrid(),
                              getVerSpace(20.h),
                            ],
                          )),
                      getVerSpace(20.h),
                      Container(
                        color: regularWhite,
                        child: Column(
                          children: [
                            getVerSpace(20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getCustomFont(
                                    "Blog", 20.sp, Color(0XFF000000), 1,
                                    fontWeight: FontWeight.w700,
                                    txtHeight: 1.5.h),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(BlogScreen());
                                    },
                                    child: getCustomFont(
                                        "View more", 14, buttonColor, 1,
                                        fontWeight: FontWeight.w400,
                                        txtHeight: 1.5.h))
                              ],
                            ).paddingSymmetric(horizontal: 20.h),
                            getVerSpace(20.h),
                            BlogDataGrid(),
                          ],
                        ),
                      ),
                      getVerSpace(27.h),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
