

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realstate/core/widgets/Custom_button.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/settings/views/change_pass_view.dart';

import 'change_lang_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('settings'.tr, context, true),
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: [
          const SizedBox(height: 11,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(text: 'changeLang'.tr,

                onPressed: (){

              Get.to(const ChangeLangView());

            }),
          ),

          const SizedBox(height: 11,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(text: 'changePass'.tr,

                onPressed: (){

              Get.to(const ChangePasswordView());

                }),
          ),


          
        ],),
      ),
    );
  }
}
