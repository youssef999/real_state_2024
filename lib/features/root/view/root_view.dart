import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/widgets/bottom_navber.dart';
import 'package:realstate/core/widgets/drawer_widget.dart';
import 'package:realstate/features/root/controller/root_controller.dart';

class RootView extends GetView<RootController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  RootView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        extendBody: true,
        backgroundColor: AppColors.primaryLightColor,
        bottomNavigationBar:
            buildBottomNavigationMenu(context, controller,controller.users.value.roleId ?? '1'),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: 
        controller
            .page[controller.selectedIndex.value],
      ));
  
  }
}
