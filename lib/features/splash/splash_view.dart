import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_assets.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final box = GetStorage();
  @override
  void initState() {
    String email = box.read('email') ?? 'x';
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (email == 'x') {
        Get.offNamed(Routes.ROOT);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBGLightColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: AppColors.primaryBGLightColor,borderRadius: BorderRadius.circular(25)),
              child: SvgPicture.asset(
                AppAssets.logo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: 200,
            height: 100,
            child: DefaultTextStyle(
              style: GoogleFonts.cairo(
                  fontSize: 23.0,  color: Colors.white),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
               // pause: Duration(minutes: 1),
                animatedTexts: [
                  RotateAnimatedText('Welcome to\n Real State',textAlign: TextAlign.center,duration: Duration(seconds: 3)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
