import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/features/predict/controller/predict_controller.dart';

class PredictView extends GetView<PredictController> {
  const PredictView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(PredictController());

    return Scaffold(
        appBar: CustomAppBar('Predict Prices'.tr, context, false),
        body: Obx(() {
          return ListView(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 230, 237, 245)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'اعرف قيمه بيتك في ثواني',
                      style: GoogleFonts.cairo(
                          color: AppColors.primaryBGLightColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        //  padding: const EdgeInsets.all(10),
                        width: 80,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/images/cal.png',
                        )),
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(right: 10, left: 10),
                children: [
                  dropDown('محافظه', controller.selectedCountry.value,
                      (String? newValue) {
                    if (newValue != null) {
                      controller.changeFilterCountry(newValue);
                      //  controller.build.value.locationCountry = newValue;
                    }
                  }, controller.countryNames),
                  dropDown('منطقه', controller.selectedArea.value,
                      (String? newValuex) {
                    if (newValuex != null) {
                      controller.changeFilterArea(newValuex);
                      //  controller.build.value.locationArea = newValuex;
                    }
                  }, controller.selectedListArea),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 30.0, right: 8, left: 8, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Area',
                          style: GoogleFonts.cairo(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.primaryBGLightColor
                                        .withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5)),
                              ],
                              border: Border.all(
                                  color:
                                      Get.theme.focusColor.withOpacity(0.2))),
                          child: TextFormField(
                            onChanged: (v) {},
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                                hintText: 'Area *2',
                                hintStyle:
                                    GoogleFonts.cairo(color: Colors.white),
                                filled: true,
                                fillColor: AppColors.primary.withOpacity(0.3),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding: const EdgeInsets.all(0),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                prefixIcon: const Icon(
                                  Icons.space_dashboard_rounded,
                                  color: Colors.white,
                                ),
                                labelStyle: const TextStyle(color: Colors.grey),
                                //  labelText: 'Password',
                                focusColor: AppColors.whiteColor),
                            cursorColor: AppColors.darkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          //  fixedSize: MaterialStatePropertyAll(Size(double.infinity, 50)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryBGLightColor),
                          fixedSize:
                              const MaterialStatePropertyAll(Size(200, 50)),
                          //     side: MaterialStatePropertyAll()
                          shape: MaterialStatePropertyAll(
                              ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)))),
                      child: Text(
                        'Predict',
                        style: GoogleFonts.cairo(
                            color: AppColors.whiteColor, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
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
                offset: const Offset(0, 5)),
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
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                  width: 1.4, color: Color.fromARGB(255, 226, 226, 226)),
              color: Colors.grey[100]!),
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            style: GoogleFonts.cairo(color: Colors.black, fontSize: 17),
            icon: const Row(
              children: [
                Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: AppColors.primaryBGLightColor,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
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
}
