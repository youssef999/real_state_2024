import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realstate/Core/resources/app_colors.dart';
import 'package:realstate/Core/widgets/Custom_Text.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/home/controllers/home_controller.dart';
import 'package:realstate/models/building_model.dart';

class FavBuildings extends StatefulWidget {
  const FavBuildings({super.key});

  @override
  State<FavBuildings> createState() => _FavBuildingsState();
}

class _FavBuildingsState extends State<FavBuildings> {

  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    controller.getUserFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Favorite'.tr, context, true),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GetBuilder<HomeController>(builder: (_) {
          return ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.userFavList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  height: 120,
                                  child: Image.network(
                                    controller.userFavList[index]['image']??
                                        'https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516_640.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Column(
                                  children: [
                                    Custom_Text(
                                      text: controller.userFavList[index]
                                          ['name'],
                                      fontSize: 19,
                                      color: AppColors.textColorDark,
                                    ),
                                    Custom_Text(
                                      text: controller.userFavList[index]
                                              ['price'] +
                                          ' د.ك',
                                      fontSize: 19,
                                      color: AppColors.greenColor,
                                    ),
                                    const Row(
                                      children: [

                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 17,
                                          color: AppColors.primaryBGLightColor,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Building data = Building(
                                        id: controller.userFavList[index]['id'],
                                        name: controller.userFavList[index]
                                            ['name'],
                                        cat: controller.userFavList[index]
                                            ['cat'],
                                      );
                                      controller.removeFromFav(data);
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          );
        }),
      ),
    );
  }
}
