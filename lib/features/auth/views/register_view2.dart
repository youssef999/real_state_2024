// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_assets.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/core/widgets/Custom_Text.dart';
import 'package:realstate/core/widgets/custom_loading.dart';
import 'package:realstate/core/widgets/custom_textformfield.dart';
import 'package:realstate/core/widgets/phone_field_widget.dart';
import 'package:realstate/features/auth/controllers/auth_controller.dart';
import 'package:realstate/routes/app_routes.dart';

import '../../../core/resources/app_colors.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  AuthController controller = Get.put(AuthController());
  final box = GetStorage();
  @override
  void initState() {
    String test = box.read('location') ?? 'x';
    if (test == 'x') {
      box.write('location', '');
    }
    controller.getLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Rx<String> locationName = box.read('location').toString().obs;
    // var email, pass;
    return Scaffold(
      backgroundColor: AppColors.primaryBGLightColor,
      body: Form(
        child: Center(
          child: GetBuilder<AuthController>(builder: (_) {
            return

                //  Obx(() =>

                ListView(
              children: [
                Container(
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: SvgPicture.asset(
                    AppAssets.logo,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(children: [
                  Text('createNewAccount'.tr,
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainly,
                          fontFamily: 'Hind'))
                ]),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.mainly,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Column(
                    children: [
                      Obx(() {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.changeRoleId(1);
                                    controller.regRoleId = 1;
                                    controller.isSelected.value = 1;
                                    controller.users.value.roleId = '1';
                                  },
                                  style: controller.isSelected.value == 1
                                      ? ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  width: 1,
                                                  color: Colors.white)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.darkColor))
                                      : const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.whiteColor)),
                                  child: Text(
                                    'user'.tr,
                                    style: controller.isSelected.value == 1
                                        ? const TextStyle(color: Colors.white)
                                        : const TextStyle(color: Colors.black),
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.changeRoleId(2);
                                    controller.isSelected.value = 0;
                                    controller.roleId.text = '2';
                                    controller.users.value.roleId = '2';
                                  },
                                  style: controller.isSelected.value == 0
                                      ? ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  width: 1,
                                                  color: Colors.white)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.darkColor))
                                      : const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.whiteColor)),
                                  child: Text(
                                    'صاحب شركه'.tr,
                                    style: controller.isSelected.value == 0
                                        ? const TextStyle(color: Colors.white)
                                        : const TextStyle(color: Colors.black),
                                  )),
                            ),
                          ],
                        );
                      }),
////////////////////////////////////////////////////////////////////////////////////////////
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          onSaved: (value) {
                            controller.nameController.text = value!;
                            controller.users.value.name = value;
                            Ui.logError(controller.users.value.name ?? 'null');
                          },
                          hint: 'userName'.tr,
                          obs: false,
                          color: AppColors.textColorDark,
                          validateMessage: 'Invalid Name',
                          controller: controller.nameController),
                      const SizedBox(
                        height: 20,
                      ),

                      CustomTextFormField(
                          hint: 'email'.tr,
                          icon: Icons.alternate_email,
                          onSaved: (value) {
                            controller.emailController.text = value!;
                            controller.users.value.email = value;
                          },
                          obs: false,
                          color: AppColors.textColorDark,
                          validateMessage: 'wrongEmail'.tr,
                          controller: controller.emailController),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          hint: 'password'.tr,
                          obs: true,
                          onSaved: (value) {
                            controller.passController.text = value!;
                            controller.users.value.password = value;
                          },
                          color: AppColors.textColorDark,
                          validateMessage: 'wrongPass'.tr,
                          obx: true,
                          controller: controller.passController),

                      // GetBuilder<AuthController>(builder: (_) {
                      //   return Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Custom_Text(
                      //             text: 'country'.tr,
                      //             fontSize: 16,
                      //             color: AppColors.textColorLight,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 6,
                      //       ),
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(13),
                      //             color: Colors.grey[100]!),
                      //         child: DropdownButton<String>(
                      //           isExpanded: true,
                      //           value: controller.selectedCountry,
                      //           onChanged: (String? newValue) {
                      //             if (newValue != null) {
                      //               controller.changeCountryValue(newValue);
                      //             }
                      //           },
                      //           items: controller.countryNames
                      //               .map<DropdownMenuItem<String>>(
                      //                   (String value) {
                      //             return DropdownMenuItem<String>(
                      //               value: value,
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Text(value),
                      //               ),
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     ],
                      //   );
                      // }),

                      const SizedBox(
                        height: 10,
                      ),

                      // GetBuilder<AuthController>(builder: (_) {
                      //   return Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Custom_Text(
                      //             text: 'city'.tr,
                      //             fontSize: 16,
                      //             color: AppColors.textColorLight,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 6,
                      //       ),
                      //       Container(
                      //         height: 35,
                      //         margin: const EdgeInsets.only(
                      //             top: 15, bottom: 10, right: 6),
                      //         decoration: BoxDecoration(
                      //             color:
                      //                 const Color.fromARGB(255, 241, 241, 241),
                      //             borderRadius: BorderRadius.circular(25),
                      //             border: Border.all(
                      //                 color: const Color.fromARGB(
                      //                     255, 235, 235, 235),
                      //                 width: 0.5,
                      //                 style: BorderStyle.solid)),
                      //         child: DropdownButton<String>(
                      //           isExpanded: true,
                      //           value: controller.selectedCountry,
                      //           onChanged: (String? newValue) {
                      //             if (newValue != null) {
                      //               controller.changeCountryValue(newValue);
                      //             }
                      //           },
                      //           items: controller.countryNames
                      //               .map<DropdownMenuItem<String>>(
                      //                   (String value) {
                      //             return DropdownMenuItem<String>(
                      //               value: value,
                      //               child: Center(
                      //                 child: Text(value),
                      //               ),
                      //             );
                      //           }).toList(),
                      //           icon: const Center(
                      //               child: Icon(Icons.keyboard_arrow_down_sharp,
                      //                   color: Colors.black)),
                      //           iconSize: 25,
                      //           underline: const SizedBox(),
                      //         ),
                      //       )
                      //     ],
                      //   );
                      // }),

                      const SizedBox(
                        height: 10,
                      ),

                      GetBuilder<AuthController>(builder: (_) {
                        return Column(children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              PhoneFieldWidget(
                                labelText: "phoneNumber".tr,
                                hintText: "223 665 7896".tr,
                                onChanged: (phone) {
                                  controller.users.value.phoneNumber =
                                      phone.number;
                                  Ui.logError(
                                      controller.users.value.phoneNumber ??
                                          'null');
                                },
                                isLast: false,
                                isFirst: false,
                              ),
                              (controller.regRoleId == 2)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Custom_Text(
                                            text: 'اسم المكتب/ الشركه',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppColors.primaryBGLightColor),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Get.theme.focusColor
                                                        .withOpacity(0.1),
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 5)),
                                              ],
                                              border: Border.all(
                                                  color: Get.theme.focusColor
                                                      .withOpacity(0.05))),
                                          child: CustomTextFormField(
                                              onSaved: (value) {
                                                controller.nameController.text =
                                                    value!;
                                              },
                                              icon: Icons.business,
                                              hint: 'userName'.tr,
                                              obs: false,
                                              color: AppColors.textColorDark,
                                              validateMessage: 'Invalid Name',
                                              controller:
                                                  controller.nameController),
                                        ),
                                        Custom_Text(
                                            text: 'selectLocation'.tr,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppColors.primaryBGLightColor),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.LOCATION);
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            height: 80,
                                            decoration: BoxDecoration(
                                                image: const DecorationImage(
                                                    image: NetworkImage(
                                                        'https://images.pexels.com/photos/209154/pexels-photo-209154.jpeg'),
                                                    fit: BoxFit.cover),
                                                border: Border.all(
                                                    color: AppColors.mainly),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: AppColors.mainly,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        locationName.value != 'null' ||
                                                locationName.value != ''
                                            ? SizedBox(
                                                child: Center(
                                                    child: Text(
                                                locationName.value,
                                                style: GoogleFonts.cairo(
                                                    color: AppColors
                                                        .primaryBGLightColor,
                                                    fontSize: 20),
                                                overflow: TextOverflow.fade,
                                              )))
                                            : const SizedBox()
                                      ],
                                    )
                                  : const SizedBox()
                            ],
                          )
                        ]);
                      }),

                      const SizedBox(
                        height: 16,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 33.0, right: 33),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 7,
                              fixedSize: const Size(300, 60),
                              shadowColor: AppColors.darkColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.1, color: AppColors.darkColor),
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: AppColors.primaryBGLightColor),
                          child: Text(
                            "register".tr,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainly,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            CustomLoading.showLoading('Loading...');
                            //    controller.startAddNewFreelancer();
                            Ui.logSuccess(controller.users);
                            controller.userSignUp();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                //)
                ;
          }),
        ),
      ),
    );
  }
}
