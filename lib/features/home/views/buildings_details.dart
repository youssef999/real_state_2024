import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/Core/resources/app_colors.dart';
import 'package:realstate/Core/widgets/Custom_Text.dart';
import 'package:realstate/core/const/constant.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/home/controllers/home_controller.dart';

import '../../../models/building_model.dart';

class BuildingsDetails extends StatefulWidget {
  Building data;

  BuildingsDetails({super.key, required this.data});

  @override
  State<BuildingsDetails> createState() => _BuildingsDetailsState();
}

class _BuildingsDetailsState extends State<BuildingsDetails> {
  HomeController controller = Get.put(HomeController());

  String newBuildImage='';
  List buildImageList=[];
  @override
  void initState() {
    controller.checkIsFav(widget.data);
    super.initState();
    splitImages();
  }

  splitImages(){
    newBuildImage=widget.data.image!.toString().replaceAll('[', '')
        .replaceAll(']', '');
    buildImageList=newBuildImage.split(',');
    print("IMAGES======="+buildImageList.length.toString());
    print("IMAGES======="+buildImageList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.data.name.toString(), context, false),
      body: ListView(children: [
        Column(
          children: [

            SizedBox(
              height: 350,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection:Axis.horizontal,
                itemCount: buildImageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                     // height: 350,
                      width:MediaQuery.of(context).size.width*0.45,
                      child: Image.network(
                        buildImageList[index],
                        //  widget.data.image.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },

              ),
            ),

            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Custom_Text(
                        text: widget.data.name.toString(),
                        color: AppColors.textColorDark,
                        fontSize: 30,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Custom_Text(
                        text: "Monthly / ${widget.data.price} $currency",
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  Obx(() {
                    return (controller.isFav.value == false)
                        ? InkWell(
                            child: const Icon(
                              Icons.favorite_border,
                              size: 40,
                              color: Colors.red,
                            ),
                            onTap: () {
                              controller.addToFav(widget.data);
                            },
                          )
                        : InkWell(
                            child: const Icon(
                              Icons.favorite,
                              size: 40,
                              color: Colors.red,
                            ),
                            onTap: () {
                              controller.removeFromFav(widget.data);
                            },
                          );
                  })
                ],
              ),
            ),
            clmn('مميزات العقار'),
            Container(
              padding: const EdgeInsets.only(right: 30, top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bed,
                        color: AppColors.primaryBGLightColor,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                          widget.data.rooms == '' || widget.data.rooms == null
                              ? '0'
                              : (widget.data.rooms!),
                          style: GoogleFonts.cairo(
                              color: Colors.grey, fontSize: 21)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('سرير',
                          style: GoogleFonts.cairo(
                              color: Colors.grey, fontSize: 21))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.wc,
                        color: AppColors.primaryBGLightColor,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                          widget.data.toilet == '' || widget.data.toilet == null
                              ? '0'
                              : (widget.data.toilet!),
                          style: GoogleFonts.cairo(
                              color: Colors.grey, fontSize: 21)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('حمام',
                          style: GoogleFonts.cairo(
                              color: Colors.grey, fontSize: 21))
                    ],
                  ),

                  // Row(),
                ],
              ),
            ),
            clmn('وصف العقار'),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(widget.data.description ?? '',
                  style: GoogleFonts.cairo(color: Colors.grey, fontSize: 21)),
            ),
            clmn('صاحب العقار'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://www.tsoln-inc.com/wp-content/uploads/TSol-Employee-Professional.jpg'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.data.nameUser ?? ''),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            )
          ],
        )
      ]),
      bottomNavigationBar: GestureDetector(
          onTap: controller.launchUrlx,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(25)),
              child: Row(
                //  crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icon/whats.svg',
                    // ignore: deprecated_member_use
                    color: AppColors.mainly,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Contact In WhatsApp',
                    style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget clmn(String des) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
          // Row(),
        ),
        const Divider(
          color: Color.fromARGB(255, 210, 210, 210),
          endIndent: 60,
          indent: 60,
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(des, style: GoogleFonts.cairo(color: Colors.black, fontSize: 21)),
      ],
    );
  }
}
