// ignore_for_file: unused_local_variable, avoid_print, duplicate_ignore, unused_field, unused_element

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/core/widgets/Custom_Text.dart';
import 'package:realstate/core/widgets/custom_loading.dart';
import 'package:realstate/models/user_model.dart';
import 'package:realstate/repositories/user_storage.dart';
import 'package:realstate/routes/app_routes.dart';

import '../../../../Core/const/app_message.dart';

class AuthController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController checkPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController roleId = TextEditingController();
  TextEditingController empCatController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<int> isSelected = 1.obs;
  int regRoleId = 1;
  GlobalKey<FormState>? loginFormKey;
  changeRoleId(int val) {
    regRoleId = val;
    update();
  }

  Location location = Location();
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  Future<void> getLocationPermission() async {
    _permissionGranted = await location.requestPermission();
    //  print("PER====" + _permissionGranted.toString());
    if (_permissionGranted == PermissionStatus.granted) {
      await location.requestPermission();
      print("Done");
    }
  }

  @override
  void onInit() async {
    getDeviceToken();
    getAllCategories();
    getAllCountries();
    getAllCities();
    //  users.value.roleId = '1';
    super.onInit();
  }

  User? user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final users = Users().obs;

  List<Map<String, dynamic>> categoryList = [];
  List<Map<String, dynamic>> countryList = [];
  List<Map<String, dynamic>> cityList = [];
  final List<String> catNames = [];
  final List<String> countryNames = ['Country', 'Egypt', 'Kuwit'];
  String selectedCountry = 'Country';
  late UserRepository userRepo;
  AuthController() {
    userRepo = UserRepository();
  }
  final List<String> cityNames = [];

  List<String> empTypeList = ['online'.tr, 'offline'.tr];

  String empType = 'online'.tr;

  changeEmpType(String val) {
    empType = val;
    update();
  }

  String selectedItem = 'ترجمة';
  String selectedCity = 'وهران';
  String phoneNumber = '';
  List<Map<String, dynamic>> userDataList = [];

  List<Map<String, dynamic>> freelancerDataList = [];

  XFile? pickedImageXFile;

  final ImagePicker _picker = ImagePicker();

  var imageLink = '';

  String downloadUrl = '';

  String profileUrl = '';

  String idUrl = '';

  String downloadUrl2 = '';

  List<String> downloadUrls = [];

  List<String> profileDownloadUrl = [];

  List<XFile>? idUrlList;

  List<XFile>? pickedImageXFiles;

  List<XFile>? profilePickedFiles;

  bool isImage = false;

  bool isLoading = false;

  final box = GetStorage();

  changeCityValue(String val) {
    selectedCity = val;
    update();
  }

  showIdDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Custom_Text(
              text: 'camera'.tr,
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: Custom_Text(
                  text: 'gallery'.tr,
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'selectImage'.tr,
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'cancel'.tr,
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })
            ],
          );
        });
  }

  showProfileDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Custom_Text(
              text: 'camera'.tr,
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: Custom_Text(
                  text: 'gallery'.tr,
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'selectImage'.tr,
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'cancel'.tr,
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })
            ],
          );
        });
  }

  showDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: const Custom_Text(
              text: 'الصورة ',
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: const Custom_Text(
                  text: 'كاميرا ',
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: ' اختر صورة  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: 'الغاء  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })
            ],
          );
        });
  }

  captureImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);
    Get.back();
    //pickedImageXFile;
    update();
  }

  pickImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    Get.back();
    update();
    //   uploadImageToFirebaseStorage(pickedImageXFile!);
  }

  pickMultiImage() async {
    pickedImageXFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
    update();
  }

  pickProfileImage() async {
    profilePickedFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
    update();
  }

  pickIdImage() async {
    idUrlList = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
    update();
  }

  changeCatValue(String value) {
    catValue = value;
    // selectedItem = value;
    update();
  }

  changeCountryValue(String value) {
    selectedCountry = value;
    update();
  }

  getAllCities() async {
    print("ccc");

    cityList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('city').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      cityList = data;

      for (int i = 0; i < cityList.length; i++) {
        cityNames.add(cityList[i]['name']);
      }

      print("city===$cityList");
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    update();
  }

  String catValue = 'Graphic Design';

  getAllCategories() async {
    final box = GetStorage();
    String lang = box.read('locale');

    categoryList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cat').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      categoryList = data;
      if (lang == 'ar') {
        for (int i = 0; i < categoryList.length; i++) {
          catNames.add(categoryList[i]['nameAr']);

          catValue = catNames[0];

          print("CATLENGTH======" + catNames.length.toString());
        }
      } else {
        for (int i = 0; i < categoryList.length; i++) {
          catNames.add(categoryList[i]['name']);

          catValue = catNames[0];

          print("CATLENGTH======" + catNames.length.toString());
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    update();
  }

  getAllCountries() async {
    print("ccc");
    countryList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('countries').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      countryList = data;

      for (int i = 0; i < countryList.length; i++) {
        countryNames.add(countryList[i]['name']);
      }
      print(countryNames);
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    update();
  }

  String token = '';

  getDeviceToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();
    // Get the device token
    token = (await _firebaseMessaging.getToken())!;
  }

  addTokenToFirebase() async {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
    Random random = Random();
    String result = '';

    for (int i = 0; i < 12; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    await FirebaseFirestore.instance.collection('tokens').doc(result).set({
      'token': token!,
    }).then((value) {
      print("DONE ADD TOKEN");
    });
  }

  String enCat = '';

  getCatInEnglish(String cat) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cat')
        .where('nameAr', isEqualTo: cat)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      enCat = data[0]['name'];
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    update();
  }

  changePassword() async {
    if (passController.text == checkPassController.text &&
        passController.text.length > 5) {
      try {
        await user!.updatePassword(passController.text.toString());
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else {
      appMessage(
          text: 'كلمة المرور غير متطابقة او عددها اقل من 6 ', fail: true);
    }
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .then((value) {
        appMessage(text: "checkMail".tr, fail: true);

        Get.toNamed(Routes.LOGIN)!
            .then((value) => appMessage(text: "checkMail".tr, fail: false));
      });
      // Password reset email sent successfully
    } catch (e) {
      appMessage(text: 'ادخل بريد سليم ', fail: false);
      // Handle any errors that occur during the password reset process
      // ignore: avoid_print
      print('Error sending password reset email: $e');
    }
  }

  Future<void> userLogin(String email,String pass) async {
    try {
      var box = GetStorage();

      Ui.logError('ttttttttttttttkkkkkkkkkk2222 ${users.value}');

      users.value = await userRepo.login(users.value,email,pass);

      Get.showSnackbar(Ui.SuccessSnackBar(message: 'Welcome back'));
      Get.toNamed(Routes.ROOT, arguments: users.value);

      box.write('current_user', users.value.toJson());

      Ui.logSuccess('ttttttttttttttkkkkkkkkkk2222 ${users.value}');
    } catch (e) {
      CustomLoading.cancelLoading();
      loading = false;
      update();
      String error = '';
      print("E====$e");
      if (e.toString().contains('The password is invalid')) {
        error = 'wrongPass'.tr;
      } else if (e.toString().contains('There is no user record')) {
        error = 'wrongMail'.tr;
      } else {
        error = 'Something Went Wrong Try Agian ';
      }
    }
  }

  Future<void> userSignUp() async {
    try {
      CustomLoading.showLoading('Loading');

      Ui.logError('ttttttttttttttkkkkkkkkkk2222 ${users.value}');
      bool x = await userRepo.register(users.value);
      if (x) {
        Get.showSnackbar(Ui.SuccessSnackBar(message: 'Sign In'));
        Get.toNamed(Routes.LOGIN);
      }
    } catch (e) {
      CustomLoading.cancelLoading();
      print(e);
    }
    //  loading = false;

    update();
  }

  sendEmailVerfication() async {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    print("SENT....");
  }

  // addNewFreelancer() async {
  //   final box=GetStorage();
  //   const String chars =
  //       'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
  //   Random random = Random();
  //   String result = '';

  //   for (int i = 0; i < 12; i++) {
  //     result += chars[random.nextInt(chars.length)];
  //   }

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('freelancers')
  //         .doc(result)
  //         .set({
  //       'name': nameController.text,
  //       'email': emailController.text,
  //       'id': result,
  //       'cat': selectedItem,
  //       'city':selectedCity,
  //       'country': selectedCountry,
  //       'images': downloadUrls
  //     }).then((value) {
  //       update();
  //       // ignore: avoid_print
  //       print("DONE");
  //       appMessage(text: 'welcome'.tr, fail: false);
  //        box.write('freelancer_email', emailController.text);
  //       box.write('freelancer_name', nameController.text);
  //       // Get.toNamed('/bottomBar');
  //     });
  //   } catch (e) {
  //     update();
  //     print(e);
  //     appMessage(text: "error".tr, fail: true);
  //   }
  // }

  Future uploadProfileImageToFirebaseStorage(List<XFile> images) async {
    for (int i = 0; i < images.length; i++) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference =
            FirebaseStorage.instance.ref().child('profile/$fileName');
        UploadTask uploadTask = reference.putFile(File(images[i].path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        profileUrl = await taskSnapshot.ref.getDownloadURL();
        profileDownloadUrl.add(profileUrl);
      } catch (e) {
        // Handle any errors that occur during the upload process
        // ignore: avoid_print
        print('Error uploading image to Firebase Storage: $e');
      }
    }
    return profileDownloadUrl;
  }

  Future uploadMultiImageToFirebaseStorage(List<XFile> images) async {
    for (int i = 0; i < images.length; i++) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference =
            FirebaseStorage.instance.ref().child('images2024/$fileName');
        UploadTask uploadTask = reference.putFile(File(images[i].path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } catch (e) {
        // Handle any errors that occur during the upload process
        // ignore: avoid_print
        print('Error uploading image to Firebase Storage: $e');
      }
    }

    return downloadUrls;
  }
}
