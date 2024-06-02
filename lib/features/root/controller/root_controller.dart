// ignore_for_file: unused_local_variable, unused_import, avoid_print

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/features/freelancer/freelancer/views/freelancer_view.dart';
import 'package:realstate/features/freelancer/orders/views/order_request_view2.dart';
import 'package:realstate/features/freelancer/service/views/add_service_view.dart';
import 'package:realstate/features/freelancer/service/views/freelancer_services.dart';
import 'package:realstate/features/home/views/home_view.dart';
import 'package:realstate/features/item/view/item_view.dart';
import 'package:realstate/features/profile/view/profile_view.dart';
import 'package:realstate/features/settings/views/settings_view.dart';
import 'package:realstate/models/user_model.dart';

import '../../home/views/fav_buildings.dart';

class RootController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final users = Users().obs;

  List page = [];
  @override
  void onInit() {
    super.onInit();
    //final users = Users().obs;

    var box = GetStorage();
    // local = box.read('locale') ?? 'ar';
    // try {
    //  meUser.value = box.read('current_user');
    try {
      users.value = Users.fromJson(box.read('current_user'));
      Ui.logSuccess('zzzzzzz ${users.value}');
    } catch (e) {
      print(e);
    }

    page = [
      HomeView(),
      const FavBuildings(),

      //  const AllChatsView(),
      //  const MyOrderView(),
      const ItemView(),
      const SettingsView(),
    ];

    // print('ROLEIDD=====$roleId');
  }

  void selectedPage(int index) {
    selectedIndex.value = index;
  }
}
