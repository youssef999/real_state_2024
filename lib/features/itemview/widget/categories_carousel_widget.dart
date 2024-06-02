import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/features/itemview/controller/itemview.dart';
import 'package:realstate/models/building_model.dart';

class CategoriesCarouselWidget extends GetWidget<ItemViewController> {
  RxList<Building> buildings;

  CategoriesCarouselWidget({super.key, required this.buildings});

  @override
  Widget build(BuildContext context) {
    // print("BUILDInGS.............$buildings");

    return Obx(() {
    return Container(
        // height: 300,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 10,
            ),
          ],
        ),
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
            //    scrollDirection: Axis.horizontal,
            itemCount: buildings.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              Building build = buildings.elementAt(index);
              return MaterialButton(
                onPressed: () {
                  //    Get.to(
                  //   BuildingsDetails(
                  //     data: build
                  //   )
                  //      );
                },
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Get.theme.focusColor.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: build.image!,

                            placeholder: (context, url) => Image.network(
                              build.image!,
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error_outline),
                            // )
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(build.name!,
                              style: GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          Container(
                            height: 1,
                            width: 200,
                            color: const Color.fromARGB(255, 216, 216, 216)
                                .withOpacity(0.7),
                            margin: const EdgeInsets.only(top: 10, bottom: 5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(build.locationCountry ?? '',
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100)),
                              const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: AppColors.primaryBGLightColor,
                              )
                            ],
                          ),
                          Container(
                            height: 1,
                            width: 200,
                            color: const Color.fromARGB(255, 216, 216, 216)
                                .withOpacity(0.7),
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                          ),
                          Text('${build.price!} د.ك',
                              maxLines: 2,
                              style: const TextStyle(
                                  color: AppColors.primaryBGLightColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Container(
                            height: 1,
                            width: 200,
                            color: const Color.fromARGB(255, 216, 216, 216)
                                .withOpacity(0.7),
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, bottom: 20, top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                controller.deleteBuild(build.id!);
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: Text(
                                'Delete',
                                style: GoogleFonts.cairo(
                                    color: AppColors.mainly, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
     });
  }
}
