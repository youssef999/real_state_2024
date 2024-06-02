// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_assets.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/core/widgets/custom_loading.dart';
import 'package:realstate/core/widgets/custom_textformfield.dart';
import 'package:realstate/features/auth/controllers/auth_controller.dart';
import 'package:realstate/routes/app_routes.dart';

import '../../../core/resources/app_colors.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loginFormKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.primaryBGLightColor,
      appBar: null,
      body: Form(
        key: controller.loginFormKey,
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Column(children: [
                Container(
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: SvgPicture.asset(
                    AppAssets.logo,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('LOGIN'.tr,
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainly,
                    )),
                const SizedBox(
                  height: 20,
                ),
              ]),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppColors.mainly,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Column(
                  children: [
                    CustomTextFormField(

                        onSaved: (v) {
                          controller.users.value.email = v;
                          Ui.logSuccess(controller.users.value.email ?? 'null');
                        },
                        hint: 'email'.tr,
                        obs: true,
                        color: AppColors.textColorDark,
                        validateMessage: 'wrongEmail'.tr,
                        controller: controller.emailController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(

                        onSaved: (v) {
                          controller.users.value.password = v;
                          Ui.logSuccess(controller.users.value.password ?? 'null');
                        },
                        hint: 'password'.tr,
                        obs: true,
                        color: AppColors.textColorDark,
                        validateMessage: 'wrongPass'.tr,
                        obx: true,
                        controller: controller.passController),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
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
                        "login".tr,
                        style: TextStyle(
                          color: AppColors.mainly,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        print("uuu==${controller.users}");
                        CustomLoading.showLoading('Loading');

                      //  controller.getRoleIdByUser().then((value) {
                     //     print("role id done");
                  //        Future.delayed(const Duration(seconds: 2))
                     //         .then((value) {
                    //        {
                      Ui.logSuccess(controller.users);
                              controller.userLogin(
                                controller.emailController.text,
                                controller.passController.text,
                              );
                      //      }
                   //       });
                 //       });
                      },
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 200,
                        ),
                        // TextButton(
                        //     onPressed: () {
                        //       print("heeee");
                        //     },
                        //     child: Text(
                        //       'forgotPassword'.tr,
                        //       style: TextStyle(color: AppColors.darkColor),
                        //     )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      'or'.tr,
                      style: const TextStyle(
                          color: AppColors.redColor, fontSize: 20),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "dontHaveAccount".tr,
                          style: TextStyle(
                              fontSize: 15, color: AppColors.darkColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: Text(
                            'register'.tr,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBGLightColor),
                          ),
                        )
                      ],
                    ),
                    // ElevatedButton(
                    //     onPressed: () {},
                    //     style: ButtonStyle(
                    //         elevation: MaterialStateProperty.all(0),
                    //         shape: MaterialStateProperty.all(StadiumBorder()),
                    //         backgroundColor:
                    //             MaterialStateProperty.all(Colors.white),
                    //         side: MaterialStateProperty.all(
                    //           const BorderSide(
                    //               width: 1,
                    //               color: Color.fromARGB(255, 223, 223, 223)),
                    //         )),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           'Sign Up With Google',
                    //           style: GoogleFonts.cairo(
                    //               color: Colors.black, fontSize: 18),
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         SvgPicture.asset(
                    //           'assets/icon/google.svg',
                    //           width: 25,
                    //         )
                    //       ],
                    //     ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
