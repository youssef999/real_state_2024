import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realstate/features/settings/controller/settings_controller.dart';

import '../../../Core/resources/app_colors.dart';
import '../../../core/widgets/Custom_button.dart';
import '../../../core/widgets/custom_textformfield2.dart';

class ChangePasswordView extends GetView<SettingsController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          // const SizedBox(height: 13,),
          Container(
            height: 250,
            clipBehavior: Clip.antiAlias,
            decoration:const BoxDecoration(
                color: AppColors.whiteColor,
                
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/logo.jpeg',
                fit:BoxFit.cover,

                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
                hint: "newPass".tr,
                obx: true,
                type: TextInputType.text,
                obs: true,
                color: AppColors.textColorDark,
                controller: controller.passController),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
                hint: "confirmPass".tr,
                obx: true,
                type: TextInputType.text,
                obs: true,
                color: AppColors.textColorDark,
                controller: controller.checkPassController),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomButton(
                text: "changePass".tr,
                onPressed: () {
                  controller.changePassword();
                },
                color1: AppColors.buttonColor,
                color2: AppColors.buttonColor2),
          )
        ],
      ),
    );
  }
}
