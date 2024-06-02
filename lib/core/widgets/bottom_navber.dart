// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/models/user_model.dart';

buildBottomNavigationMenu(context, bottomNavBarController,String roleid) {
  final users = Users();
  return Obx((){
    return BottomAppBar(
      elevation: 0,
      color: AppColors.transparent,
      child: Container(
        height: 64,
        margin: const EdgeInsets.only(
          left: 24 * 0.7,
          right: 24 * 0.7,
          bottom: 24 * 0.2,
        ),
        decoration: BoxDecoration(
            color: AppColors.primaryBGLightColor,
            borderRadius: BorderRadius.circular(10 * 3.22)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            bottomItemWidget('assets/icon/home.svg', bottomNavBarController, 0,
                AppColors.whiteColor.withOpacity(0.1)),
            //FavBuildings
            bottomItemWidget('assets/icon/fav.svg', bottomNavBarController, 1,
                AppColors.transparent),
            roleid == '2'
                ? bottomItemWidget('assets/images/new.png',
                    bottomNavBarController, 2, AppColors.transparent)
                : const SizedBox(),
            bottomItemWidget2('assets/icon/setting.svg', bottomNavBarController,
                3, AppColors.transparent),
    
            // bottomItemWidget('assets/icon/my_gift.svg', bottomNavBarController, 3,
            //     AppColors.transparent),
          ],
        ),
      ),
    );
});
}

bottomItemWidget(
  String icon,
  bottomNavBarController,
  page,
  Color color,
) {
  return Expanded(
    child: GestureDetector(
        onTap: () {
          bottomNavBarController.selectedIndex.value = page;
          print(bottomNavBarController.selectedIndex.value);
        },
        child: CircleAvatar(
            radius: 25,
            backgroundColor: bottomNavBarController.selectedIndex.value == page
                ? AppColors.whiteColor.withOpacity(0.1)
                : AppColors.transparent,
            child: icon.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(
                    icon,
                    color: bottomNavBarController.selectedIndex.value == page
                        ? AppColors.whiteColor
                        : AppColors.whiteColor.withOpacity(0.4),
                    height: bottomNavBarController.selectedIndex.value != page
                        ? 24
                        : 28,
                  )
                : Image.asset(
                    icon,
                    color: bottomNavBarController.selectedIndex.value == page
                        ? AppColors.whiteColor
                        : AppColors.whiteColor.withOpacity(0.4),
                    height: bottomNavBarController.selectedIndex.value != page
                        ? 28
                        : 30,
                  ))),
  );
}

bottomItemWidget2(
  var icon,
  bottomNavBarController,
  page,
  Color color,
) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        bottomNavBarController.selectedIndex.value = page;
        print(bottomNavBarController.selectedIndex.value);
      },
      child: CircleAvatar(
        radius: 25,
        backgroundColor: bottomNavBarController.selectedIndex.value == page
            ? AppColors.whiteColor.withOpacity(0.1)
            : AppColors.transparent,
        child: SvgPicture.asset(
          icon,
          color: bottomNavBarController.selectedIndex.value == page
              ? AppColors.whiteColor
              : AppColors.whiteColor.withOpacity(0.4),
          height: bottomNavBarController.selectedIndex.value != page ? 30 : 34,
        ),
      ),
    ),
  );
}
