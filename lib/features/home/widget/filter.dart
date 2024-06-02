import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/features/home/controllers/home_controller.dart';

import '../views/buildings_search_view.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.only(right: 9, left: 9),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 30,
              blurRadius: 30,
              offset: const Offset(0, 15), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 30,
              blurRadius: 30,
              offset: const Offset(0, 15), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          border: Border.all(
              color: AppColors.primaryBGLightColor,
              width: 1.5,
              style: BorderStyle.solid)), 
      child: Obx(() {
        return Row(children: [
          Column(
            children: [
              drop(controller.selectMain.value, (String? newValue) {
                if (newValue != null) {
                  controller.changeFilterMain(newValue);
                  Ui.logError(newValue);
                }
              }, controller.filterMain),
              drop(controller.selectLocation.value, (String? newValue) {
                if (newValue != null) {
                  controller.changeFilterLocation(newValue);
                }
              }, controller.filterLocation)
            ],
          ),
          Column(
            children: [
              drop(controller.selectType.value, (String? newValue) {
                if (newValue != null) {
                  controller.changeFilterType(newValue);
                }
              }, controller.filterType),
              drop2(controller.selectDesc.value, (String? newValue) {
                if (newValue != null) {
                  controller.changeFilterDesc(newValue);
                }
              }, controller.filterDesc)
            ],
          ),
          IconButton(
            splashRadius: 25,
            color: AppColors.primaryBGLightColor,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(62, 7, 95, 154))),
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.to(BuildingsSearchView(
                desc: controller.selectDesc.value,
                location: controller.selectLocation.value,
                cat: controller.selectType.value,
                type: controller.selectMain.value,
              ));
            },
          ),
        ]);
      }),
    );
  }

  Widget drop2(
      String value, Function(String?)? onChanged, var filter) {
    // final controller = Get.put(HomeController());

    return Container(
      height: 35,
      width: 150,
      margin: const EdgeInsets.only(top: 15, bottom: 10, right: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: 0.5,
              style: BorderStyle.solid)),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        items: filter.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(value),
            ),
          );
        }).toList(),
        icon: const Center(
            child: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)),
        iconSize: 25,
        underline: const SizedBox(),
      ),
    );
  }

  Widget drop(
      String value, Function(String?)? onChanged, RxList<String> filter) {
    // final controller = Get.put(HomeController());

    return Container(
      height: 35,
      width: 150,
      margin: const EdgeInsets.only(top: 15, bottom: 10, right: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: 0.5,
              style: BorderStyle.solid)),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        items: filter.map<DropdownMenuItem<String>>((String value) {
        
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(value),
            ),
          );
        }).toList(),
        icon: const Center(
            child: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)),
        iconSize: 25,
        underline: const SizedBox(),
      ),
    );
  }
}
