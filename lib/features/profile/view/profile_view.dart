import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/widgets/Custom_Text.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/profile/controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
        backgroundColor: AppColors.primaryBGLightColor,
        appBar: CustomAppBar('account'.tr, context, false),
        body:
       // Obx(() {
        // return
        GetBuilder<ProfileController>
            (builder: (_) {
            return ListView(children: [
              (controller.pickedImageXFiles != null &&
                  controller
                      .pickedImageXFiles!.isNotEmpty)
                  ? GetBuilder<ProfileController>(
                  builder: (_) {
                    return Column(children: [
                      const SizedBox(
                        height: 6,
                      ),
                      for (int i = 0;
                      i <
                          controller
                              .pickedImageXFiles!
                              .length;
                      i++)
                        Padding(
                          padding:
                          const EdgeInsets.all(7.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 2),
                                borderRadius:
                                BorderRadius.circular(
                                    15)),
                            child: Padding(
                              padding:
                              const EdgeInsets.all(
                                  6.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .all(8.0),
                                    child: InkWell(
                                      child: Container(
                                        height: MediaQuery
                                            .of(
                                            context)
                                            .size
                                            .width *
                                            0.41,
                                        width: MediaQuery
                                            .of(
                                            context)
                                            .size
                                            .width *
                                            0.6,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(File(controller
                                                    .pickedImageXFiles![
                                                i]
                                                    .path)),
                                                fit: BoxFit
                                                    .fill)),
                                      ),
                                      onTap: () {
                                        controller
                                            .pickMultiImage();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ]);
                  })
                  : InkWell(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    CircleAvatar(
                        radius: 100,
                        child: Image.network(
                          'https://threedio-cdn.icons8.com/nyQTub5XpLLjDfeBRnGZWVUGg_zQTGs4QC0GAdhQSKM/rs:fit:1024:1024/czM6Ly90aHJlZWRp/by1wcm9kL3ByZXZp/ZXdzLzExNy82M2Qx/NDFiNS04MjQ4LTRi/ZDQtYmQ1Mi1lNWE2/ZmI0NDBjNTMucG5n.png',
                          width: 130,
                          height: 150,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                onTap: () {
                  controller.pickMultiImage();
                },
              ),

              // Center(
              //   child:
              //
              //   Container(
              //       width: 130,
              //       height: 150,
              //       margin: const EdgeInsets.only(top: 30, bottom: 10),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(25),
              //           color: Colors.white),
              //       clipBehavior: Clip.antiAlias,
              //       child: controller.users.value.image != null &&
              //               controller.users.value.image != ''
              //           ? Image.network(
              //               controller.users.value.image!,
              //               width: 130,
              //               height: 150,
              //               fit: BoxFit.cover,
              //             )
              //           : Image.network(
              //               'https://threedio-cdn.icons8.com/nyQTub5XpLLjDfeBRnGZWVUGg_zQTGs4QC0GAdhQSKM/rs:fit:1024:1024/czM6Ly90aHJlZWRp/by1wcm9kL3ByZXZp/ZXdzLzExNy82M2Qx/NDFiNS04MjQ4LTRi/ZDQtYmQ1Mi1lNWE2/ZmI0NDBjNTMucG5n.png',
              //               width: 130,
              //               height: 150,
              //               fit: BoxFit.cover,
              //             )),
              // ),
              Text(
                controller.users.value.roleId == '1' ? 'مستخدم' : 'صاحب عقار',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Custom_Text(
                    text: 'اسم المستخدم',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainly),
              ),
              txt(controller.users.value.name ?? 'missing', (v) {
                controller.users.value.name = v;
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Custom_Text(
                    text: 'الايميل',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainly),
              ),
              txt(controller.users.value.email ?? 'missing', (v) {
                controller.users.value.email = v;
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Custom_Text(
                    text: 'رقم الهاتف',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainly),
              ),
              txt(controller.users.value.phoneNumber ?? 'missing', (v) {
                controller.users.value.phoneNumber = v;
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Custom_Text(
                    text: 'رمز الدخول',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainly),
              ),
              txt('*******', (v) {
                controller.users.value.password = v;
              }),
              Container(
                height: 1,
                width: 150,
                color: Colors.white.withOpacity(0.7),
                margin: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 40, right: 40),
              ),
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    controller.deleteAccount();
                  },
                  style: ButtonStyle(
                    //  fixedSize: MaterialStatePropertyAll(Size(double.infinity, 50)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      fixedSize: const MaterialStatePropertyAll(Size(200, 50)),
                      //     side: MaterialStatePropertyAll()
                      shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))),
                  child: Text(
                    'Delete Account',
                    style:
                    GoogleFonts.cairo(color: AppColors.mainly, fontSize: 20),
                  ),
                ),
              ),
              // if (controller.roleId == '2')
              //   txt('المحتوي', controller.meUser?['cat'] ?? 'missing', (p0) {}),
              // if (controller.roleId == '2')
              //   txt('الوصف', controller.meUser?['des'] ?? 'missing', (p0) {}),
              const SizedBox(
                height: 90,
              )
            ]);
          }),
       // }

       // ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  controller.uploadImageToServer2(
                      controller.pickedImageXFiles![0].path).then((value) {
                    controller.updateUser();
                      });

                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  width: 250,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLightColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'تعديل',
                      style:
                      GoogleFonts.cairo(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget txt(String label, void Function(String) onChanged) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: TextFormField(
        onChanged: onChanged,
        // onSaved: onChanged,
        decoration: InputDecoration(
          label: Text(
            label,
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: GoogleFonts.cairo(color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.white,
          hintStyle: GoogleFonts.cairo(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
