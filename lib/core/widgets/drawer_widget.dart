// ignore_for_file: deprecated_member_use, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/core/widgets/custom_image_widget.dart';
import 'package:realstate/core/widgets/custom_loading.dart';
import 'package:realstate/features/about/about_view.dart';
import 'package:realstate/features/itemview/view/itemview_view.dart';
import 'package:realstate/features/profile/view/profile_view.dart';
import 'package:realstate/features/settings/views/change_lang_view.dart';
import 'package:realstate/models/user_model.dart';
import 'package:realstate/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/privacy/privacy_policy.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? local;
  // Rx<Users> users = Users().obs;
//  RxMap<String, dynamic> meUser = <String, dynamic>{}.obs;
  final users = Users().obs;
  @override
  void initState() {
    var box = GetStorage();
    local = box.read('locale') ?? 'ar';
    try {
      //  meUser.value = box.read('current_user');
      users.value = Users.fromJson(box.read('current_user'));
      Ui.logSuccess('zzzzzzz ${users.value}');
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width / 1.34,
        shape: RoundedRectangleBorder(
            borderRadius: local == 'ar'
                ? const BorderRadius.only(
                    topLeft: Radius.circular(
                      24 * 2,
                    ),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(
                      24 * 2,
                    ),
                  )),
        backgroundColor: const Color.fromARGB(255, 226, 226, 226),
        child: Obx(
          () {
            return ListView(
              children: [
                _userImgWidget(context),
                _userTextwidget(context),
                const Divider(
                  color: AppColors.whiteColor,
                ),
                _drawerWidget(context),
              ],
            );
          },
        ),
      ),
    );
  }

  _userImgWidget(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          top: 24 * 1,
          bottom: 24,
        ),
        height: 12 * 8.3,
        width: 10 * 11.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10 * 1.5),
          color: AppColors.primaryBGLightColor,
          border: Border.all(color: AppColors.primaryBGLightColor, width: 5),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: users.value.image != null && users.value.image != ''
                ? Image.network(
                    users.value.image !,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/user.png')),
      ),
    );
  }

  _userTextwidget(BuildContext context) {
   // final box = GetStorage();
    //  String email = box.read('email') ?? "";
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            users.value.name ?? 'User Name',
            textAlign: TextAlign.start,
            style: GoogleFonts.cairo(
              fontSize: 17,
              color: AppColors.primaryBGLightColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            users.value.email ?? 'Email@gmail.com',
            //  userData?['email'] ?? 'email@gmail.com',
            textAlign: TextAlign.start,
            style: GoogleFonts.cairo(
              fontSize: 17,
              color: AppColors.primaryBGLightColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  _drawerWidget(BuildContext context) {
    // final box = GetStorage();

    // String roleId = box.read('roleId') ?? 'x';
    // String email = box.read('email') ?? 'x';
    // // ignore: prefer_interpolation_to_compose_strings
    // print("ROLEID===" + roleId);
    // print("EMAIL=====$email");
 final Uri _url = Uri.parse('https://wa.me/+96599211895');
 Future<void> launchUrlx() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // (roleId == '2')
        //     ? _drawerTileWidget(
        //         icon: 'assets/icon/kyc_verification.svg',
        //         title: 'orderRequests'.tr,
        //         onTap: () {
        //           Get.to(const OrderRequestView());
        //         })
        //     : const SizedBox(),
        //

        // (roleId == '2')
        //     ? _drawerTileWidget(
        //         icon: 'assets/icon/transactions_log.svg',
        //         title: 'addNewService'.tr,
        //         onTap: () {
        //           Get.to(const AddServicesView());
        //         },
        //       )
        //     : const SizedBox(),
        _drawerTileWidget(
          icon: 'assets/images/profile.png',
          title: 'الحساب'.tr,
          onTap: () {
            Get.to(const ProfileView());
          },
        ),
        _drawerTileWidget(
          icon: 'assets/images/setting.png',
          title: 'settings'.tr,
          onTap: () {
            Get.to(const ChangeLangView());
          },
        ),
        if (users.value.roleId == '2')
          _drawerTileWidget(
            icon: 'assets/images/new.png',
            title: 'العقارات'.tr,
            onTap: () {
              Get.to(const ItemVView());
              //  Get.to(const ChangeLangView());
            },
          ),
        _drawerTileWidget(
          icon: 'assets/images/whats.png',
          title: 'تواصل بنا'.tr,
          onTap: () {
           // Get.to(const PrivacyPolicy());
           CustomLoading.showLoading('Going To Whatsapp..');
           launchUrlx();
           CustomLoading.cancelLoading();
          },
        ),
        const SizedBox(
          height: 60,
        ),
        //
        const Divider(
          color: AppColors.whiteColor,
        ),
        _drawerTileWidget(
          icon: 'assets/images/about.png',
          title: 'aboutUs'.tr,
          onTap: () {
            Get.to(const AboutView());
          },
        ),
        _drawerTileWidget(
          icon: 'assets/images/privacy.png',
          title: 'privacy'.tr,
          onTap: () {
            Get.to(const PrivacyPolicy());
          },
        ),

        const SizedBox(
          height: 20,
        ),
        const Divider(
          color: AppColors.whiteColor,
        ),
        //PrivacyPolicy
        _drawerTileWidget(
          icon: 'assets/images/logout.png',
          title: 'logout'.tr,
          color: Colors.red,
          onTap: () {
            final box = GetStorage();
            box.remove('email');
            Get.offAllNamed(Routes.LOGIN);
          },
        )
      ],
    );
  }

  _drawerTileWidget(
      {required VoidCallback onTap,
      required String title,
      required String icon,
      Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15 * 1,
          vertical: 50 * 0.2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 11 * 3,
              width: 10 * 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * 0.7),
              ),
              child: Container(
                padding: const EdgeInsets.all(10 * 0.2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10 * 0.7,
                  ),
                ),
                child: CustomImageWidget(
                  path: icon,
                  color: Colors.black,
                  height: 10 * 5,
                  width: 14 * 3,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: GoogleFonts.cairo(
                  fontSize: 15,
                  color: color ?? AppColors.primaryBGLightColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
