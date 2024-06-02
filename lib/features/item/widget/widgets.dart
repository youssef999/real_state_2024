import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/features/item/controller/item_controller.dart';

ItemController controller = Get.put(ItemController());

Widget customRadioButton(String text, int index) {
  return OutlinedButton(
      onPressed: () {
        controller.firstValue.value = index;
        controller.build.value.type = index.toString();
      },
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(100, 55)),
          backgroundColor: MaterialStateProperty.all(
            (controller.firstValue.value == index)
                ? const Color.fromARGB(78, 7, 95, 154)
                : AppColors.mainly,
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStateProperty.all(
            BorderSide(width: 0, color: AppColors.mainly),
          )),
      child: Text(
        text,
        style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: (controller.firstValue.value == index)
                ? AppColors.primaryBGLightColor
                : AppColors.darkColor),
      ));
}

Widget secoundCustomRadioButton(String text, int index, int indexCat) {
  return OutlinedButton(
      onPressed: () {
        controller.secoundValue.value = index;
        controller.build.value.item = index.toString();
        controller.build.value.cat = indexCat.toString();
      },
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          //  fixedSize: MaterialStateProperty.all(const Size(50, 10)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
          side: MaterialStateProperty.all((controller.secoundValue.value ==
                  index)
              ? const BorderSide(width: 1, color: AppColors.primaryBGLightColor)
              : const BorderSide(
                  width: 1, color: Color.fromARGB(255, 220, 220, 220)))),
      child: Text(
        text,
        style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: (controller.secoundValue.value == index)
                ? AppColors.primaryBGLightColor
                : AppColors.darkColor),
      ));
}

Widget firstTabBar() {
  return GridView(
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 30),
    children: [
      secoundCustomRadioButton('شقه', 1, 1),
      secoundCustomRadioButton('دور', 2, 1),
      secoundCustomRadioButton('بيت', 3, 1),
    ],
  );
}

Widget secoundTabBar() {
  return GridView(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 30),
    children: [
      secoundCustomRadioButton('مكتب', 4, 2),
      secoundCustomRadioButton('محل', 5, 2),
      secoundCustomRadioButton('مبني عماره', 6, 2),
    ],
  );
}

Widget thirdTabBar() {
  return GridView(
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 30),
    children: [
      secoundCustomRadioButton('مخيم', 7, 3),
      secoundCustomRadioButton('جاخور', 8, 3),
      secoundCustomRadioButton('استراحه', 9, 3),
    ],
  );
}

Widget dropDown(String hint, String value, void Function(String?)? onChanged,
    RxList<String> data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0, top: 20),
        child: Text(
          hint,
          style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBGLightColor),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13), color: Colors.grey[100]!),
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          onChanged: onChanged,
          items: data.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

Widget txtForm(String hint, Function(String?)? onSaved, TextInputType type) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBGLightColor),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Get.theme.focusColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5)),
              ],
              border:
                  Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
          child: TextFormField(
            keyboardType: type,
            onSaved: onSaved,
            onChanged: onSaved,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.cairo(color: Colors.grey),
                filled: true,
                fillColor: const Color.fromARGB(148, 228, 228, 228),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.all(0),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                prefixIcon: const Icon(
                  Icons.admin_panel_settings_sharp,
                  color: Colors.grey,
                ),
                labelStyle: const TextStyle(color: Colors.grey),
                //  labelText: 'Password',
                focusColor: AppColors.whiteColor),
            cursorColor: AppColors.darkColor,
          ),
        ),
      ],
    ),
  );
}
