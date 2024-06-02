// ignore_for_file: must_be_immutable

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/widgets/Custom_Text.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/freelancer/freelancer/controllers/freelancer_controller.dart';
import 'package:realstate/features/freelancer/freelancer/views/show_service_details.dart';
import 'package:realstate/features/freelancer/freelancer/widget/review.dart';

class FreelancerDetailsView extends StatefulWidget {
  DocumentSnapshot data;

  FreelancerDetailsView({super.key, required this.data});

  @override
  State<FreelancerDetailsView> createState() => _FreelancerDetailsViewState();
}

class _FreelancerDetailsViewState extends State<FreelancerDetailsView> {
  FreelancerController controller = Get.put(FreelancerController());

  @override
  void initState() {
    controller.getFreelancerData(); 
    controller.getFreelancerServices(widget.data['email']);
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(widget.data['name'], context, false),
      body: GetBuilder<FreelancerController>(builder: (_) {
        return ListView(children: [
                    const ReviewFreelance(),

          const SizedBox(
            height: 11,
          ),
          Container(
            height: 300,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Center(
              child: Image.network(
                widget.data['image'],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
              child: Container(
            constraints: const BoxConstraints(maxWidth: double.infinity),
            child: Text(
              widget.data['name'],
              style: GoogleFonts.cairo(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
          )),
          dvid(11),
          Center(
              child: Container(
            constraints: const BoxConstraints(maxWidth: double.infinity),
            child: Text(
              widget.data['cat'],
              style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary),
            ),
          )),
          dvid(11),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Center(
                  child: GetBuilder<FreelancerController>(builder: (_) {
                    return AnimatedRatingStars(
                      initialRating: controller.finalRate,
                      minRating: 0.0,
                      maxRating: 5.0,
                      filledColor: Colors.amber,
                      emptyColor: Colors.yellow,
                      filledIcon: Icons.star,
                      halfFilledIcon: Icons.star_half,
                      emptyIcon: Icons.star_border,
                      onChanged: (double rating) {},
                      displayRatingValue: true,
                      interactiveTooltips: true,
                      customFilledIcon: Icons.star,
                      customHalfFilledIcon: Icons.star_half,
                      customEmptyIcon: Icons.star_border,
                      starSize: 22.0,
                      animationDuration: const Duration(milliseconds: 100),
                      animationCurve: Curves.easeInOut,
                      readOnly: true,
                    );
                  }),
                ),
                const SizedBox(
                  width: 5,
                ),
                (controller.finalRate.toString() != 'Nan')
                    ? Custom_Text(
                        text: controller.finalRate.toString(),
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      )
                    : const SizedBox()
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const SizedBox(
            height: 5,
          ),
          (controller.freelancerServicesList.isNotEmpty)
              ? txtS('services'.tr, 30, FontWeight.w900, Colors.black)
              : const SizedBox(),
          const SizedBox(
            height: 5,
          ),
          GetBuilder<FreelancerController>(builder: (_) {
            return freelancerServiceWidget();
          }),
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 9,
                  ),
                  Custom_Text(
                    text: 'comments'.tr,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.firstCommentList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.comment,
                                      color: Colors.blueAccent),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    controller.firstCommentList[index]
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', ''),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.4,
                              color: Colors.grey[800],
                            )
                          ],
                        );
                      }),
                ),
              ),
            ],
          ),
        ]);
      }),
    );
  }

  Widget freelancerServiceWidget() {
    FreelancerController controller = Get.put(FreelancerController());

    if (controller.freelancerServicesList.isEmpty) {
      return Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          Custom_Text(
            text: 'noService'.tr,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          )
        ],
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.freelancerServicesList.length,
          itemBuilder: ((context, index) {
            List<dynamic> list =
                controller.freelancerServicesList[index]['rate'];
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 133,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 228, 228, 228),
                              borderRadius: BorderRadius.circular(25)),
                          child: Image.network(
                            controller.freelancerServicesList[index]['image'],
                            height: 120,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Custom_Text(
                              text: controller.freelancerServicesList[index]
                                  ['name'],
                              fontSize: 18,
                              color: AppColors.textColorDark,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Custom_Text(
                              text: controller.freelancerServicesList[index]
                                  ['cat'],
                              fontSize: 16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              onTap: () {
                // Get.toNamed(Routes.SERVICEDETAILS,arguments:controller.freelancerServicesList );

                Get.to(ShowServiceDetails(
                  data: controller.freelancerServicesList[index],
                ));

                // Get.to(ShowServiceDetails(post:
                // controller.freelancerServicesList[index], data: {},));
                //
              },
            );
          }));
    }
  }

  txtS(String txt, double size, FontWeight w, Color color) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15,
      ),
      child: Text(
        txt,
        style: GoogleFonts.cairo(fontSize: size, fontWeight: w, color: color),
      ),
    );
  }

  dvid(double num) {
    return SizedBox(
        height: num,
        child: const Divider(
          indent: 40,
          endIndent: 40,
          color: Color.fromARGB(50, 0, 0, 0),
        ));
  }
}
