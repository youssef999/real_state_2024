import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/widgets/adv.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/home/widget/categories_carousel_widget.dart';
import 'package:realstate/features/home/widget/filter.dart';
import 'package:realstate/routes/app_routes.dart';
import '../controllers/home_controller.dart';
import 'all_building_cat.dart';

class HomeView extends GetView<HomeController> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.mainly,
      appBar: CustomAppBar('Manazel'.tr, context, true),
      key: scaffoldKey,
      body: DefaultTabController(
        length: 2,
        // child: SingleChildScrollView(
        child: ListView(
          children: [
            const SizedBox(height: 8),
            const AdvWidget(),
            const SizedBox(height: 8),
            GetBuilder<HomeController>(builder: (_) {
              return const Filter();
            }),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.PREDICT),
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 230, 237, 245)),
                height: 45,
                width: MediaQuery.of(context).size.width * 0.50,
                child: Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          //  padding: const EdgeInsets.all(10),
                          width: 40,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'assets/images/cal.png',
                          )),
                      Expanded(
                          child: Center(
                              child: Text(
                        'تقييم استرشادي',
                        style: GoogleFonts.cairo(
                            color: AppColors.primaryBGLightColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ))),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryBGLightColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'اعلانات مميزه',
              textAlign: TextAlign.start,
              style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBGLightColor),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 229, 229, 229),
                  borderRadius: BorderRadius.circular(5)),
              child: TabBar(
                  padding: const EdgeInsets.all(5),
                  unselectedLabelColor: AppColors.primaryBGLightColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.mainly,
                  indicatorColor: Colors.blueAccent,
                  labelStyle: GoogleFonts.cairo(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  indicatorWeight: 5,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryBGLightColor),
                  dividerHeight: 00,
                  tabs: const [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("بيع"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("ايجار"),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.4,
              child: TabBarView(
                children: [
                  // Content for the first tab
                  firstTabBar(),
                  // Content for the second tab
                  secoundTabBar(),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
        // ),
      ),
    );
  }

  Widget firstTabBar() {
    // shrkat
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عقار سكني',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.cairo(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    'allServices'.tr,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      color: AppColors.textColorGreyMode,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(AllBuildingsCatView(data: controller.buildsOne));
                  },
                ),
              ],
            ),
            CategoriesCarouselWidget(
              buildings: controller.buildsOne,
            )
          ],
        ),
        // astsmar
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عقار استثماري',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.cairo(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    'allServices'.tr,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      color: AppColors.textColorGreyMode,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(AllBuildingsCatView(data: controller.buildsTwo));
                  },
                ),
              ],
            ),
            CategoriesCarouselWidget(
              buildings: controller.buildsTwo,
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'شركات و محلات',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.cairo(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    'allServices'.tr,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      color: AppColors.textColorGreyMode,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(AllBuildingsCatView(data: controller.buildsThree));
                  },
                ),
              ],
            ),
            CategoriesCarouselWidget(
              buildings: controller.buildsThree,
            )
          ],
        ),
        // Add more content for the first tab here
      ],
    );
  }

  //
  Widget secoundTabBar() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عقار سكني',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.cairo(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    'allServices'.tr,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      color: AppColors.textColorGreyMode,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(AllBuildingsCatView(data: controller.buildsFour));
                  },
                ),
              ],
            ),
            CategoriesCarouselWidget(
              buildings: controller.buildsFour,
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عقار استثماري',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.cairo(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    'allServices'.tr,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      color: AppColors.textColorGreyMode,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(AllBuildingsCatView(data: controller.buildsFive));
                  },
                ),
              ],
            ),
            CategoriesCarouselWidget(
              buildings: controller.buildsFive,
            )
          ],
        ),
        //Column(
        // children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'شركات و محلات',
              textAlign: TextAlign.start,
              style: GoogleFonts.cairo(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              child: Text(
                'allServices'.tr,
                textAlign: TextAlign.start,
                style: GoogleFonts.cairo(
                  fontSize: 17,
                  color: AppColors.textColorGreyMode,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Get.to(AllBuildingsCatView(data: controller.buildsSix));
              },
            ),
          ],
        ),
        CategoriesCarouselWidget(
          buildings: controller.buildsSix,
        )
        //   ],
        // ),
        // Add more content for the first tab here
      ],
    );
  }
}
