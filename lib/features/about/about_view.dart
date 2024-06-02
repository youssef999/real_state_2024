


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/widgets/Custom_Text.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('aboutUs'.tr, context,false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const SizedBox(height: 21),
          Custom_Text(text: 'about'.tr,
          fontSize:16,color:AppColors.textColorDark,
          fontWeight:FontWeight.w500,
          )
          
        ],),
      ),
    );
  }
}