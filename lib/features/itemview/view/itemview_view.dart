import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/itemview/controller/itemview.dart';
import 'package:realstate/features/itemview/widget/categories_carousel_widget.dart';

class ItemVView extends GetView<ItemViewController> {
  const ItemVView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ItemViewController());
    return Scaffold(
       // backgroundColor: AppColors.primaryBGLightColor,
        appBar: CustomAppBar('View Build'.tr, context, false),
        body:  ListView(
          
          children: [
          CategoriesCarouselWidget(
              buildings: controller.build,
            )
        ]
        
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
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: TextFormField(
        onChanged: onChanged,
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
