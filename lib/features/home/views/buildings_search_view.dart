import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realstate/Core/resources/app_colors.dart';
import 'package:realstate/Core/widgets/Custom_Text.dart';
import 'package:realstate/core/const/constant.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/home/controllers/home_controller.dart';
import 'package:realstate/models/building_model.dart';

import 'buildings_details.dart';

// ignore: must_be_immutable
class BuildingsSearchView extends StatefulWidget {
  String type;
  String desc;
  String location;
  String cat;
  BuildingsSearchView(
      {super.key,
      required this.desc,
      required this.cat,
      required this.location,
      required this.type});
  @override
  State<BuildingsSearchView> createState() => _BuildingsSearchViewState();
}

class _BuildingsSearchViewState extends State<BuildingsSearchView> {
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    controller.searchData(
        widget.desc, widget.location, widget.cat, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Filters', context, false),
      body: GetBuilder<HomeController>(builder: (_) {
        return ListView(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.newSearchList.length,
                itemBuilder: (context, index) {

                  String imageLink=controller.newSearchList[index]['image'].toString().replaceAll('[', '')
                  .replaceAll(']', '');

                  List images=imageLink.split(',');

                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            children: [
                              SizedBox(
                                 height: 160,
                                 
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(

                                  images[0],fit: BoxFit.fill,
                                 //   controller.newSearchList[index]['image']
                                    
                                    ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Custom_Text(
                                        text: controller.newSearchList[index]
                                                ['name']
                                            .toString(),
                                        fontSize: 19,
                                        color: AppColors.textColorDark,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Custom_Text(
                                          text:
                                              "${controller.newSearchList[index]['price']} $currency",
                                          fontSize: 19,
                                          color: AppColors.primary)
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  (controller.isFav == false)
                                      ? InkWell(
                                          child: const Icon(
                                            Icons.favorite_border,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                          onTap: () {
                                            Building data = Building(
                                              id: controller
                                                  .newSearchList[index]['id'],
                                              name: controller
                                                  .newSearchList[index]['name'],
                                              cat: controller
                                                  .newSearchList[index]['cat'],
                                            );
                                            controller.addToFav(data);
                                          },
                                        )
                                      : InkWell(
                                          child: const Icon(
                                            Icons.favorite,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                          onTap: () {
                                            Building data = Building(
                                              id: controller
                                                  .newSearchList[index]['id'],
                                              name: controller
                                                  .newSearchList[index]['name'],
                                              cat: controller
                                                  .newSearchList[index]['cat'],
                                            );
                                            controller.removeFromFav(data);
                                            //     controller.addToFav(widget.data);
                                          },
                                        )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(BuildingsDetails(
                          data: controller.newSearchList[index]));
                    },
                  );
                })
          ],
        );
      }),
    );
  }
}
