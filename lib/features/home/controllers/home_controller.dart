// ignore_for_file: avoid_print, duplicate_ignore, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/core/widgets/custom_loading.dart';
import 'package:realstate/models/building_model.dart';
import 'package:realstate/models/user_model.dart';
import 'package:realstate/repositories/category_storage.dart';
import 'package:realstate/repositories/user_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  String typeFilter = '';
  RxList sliderImagesList = [].obs;
  CarouselSliderController sliderController = CarouselSliderController();
  RxList<DocumentSnapshot> searchResults = <DocumentSnapshot>[].obs;
  Rx<bool> isSearching = false.obs;
  List<Map<String, dynamic>> empList = [];
  List<Map<String, dynamic>> empFilterList = [];
  var buildsOne = <Building>[].obs;
  var buildsTwo = <Building>[].obs;
  Rx<Users> users = Users().obs;
  var buildsThree = <Building>[].obs;
  RxList adsList = [].obs;
  var buildsFour = <Building>[].obs;
  var buildsFive = <Building>[].obs;
  var buildsSix = <Building>[].obs;
  // final buildsCat = <Building>[].obs;
  late CategoryRepository categoryRepository;
  late UserRepository userRepository;

  HomeController() {
    categoryRepository = CategoryRepository();
    userRepository = UserRepository();
  }

  List<dynamic> allBuildings = [];

  Map<String, dynamic> searchList = {};
  Map<String, dynamic> priceMap = {};
  List newSearchList = [];
  List pricingList = [];
  Rx<bool> isFav = false.obs;

  @override
  void onInit() async {
    print("ON IT ...");
    final box = GetStorage();
    users.value = Users.fromJson(box.read('current_user'));
    Ui.logError('quoooooo ${users.value}');
    UserRepository();
    myAds();
    getCurrentLocation();
    await fetchSliderImages();
    await me(users.value.userId!);
    Ui.logSuccess('opopop ${users}');
    await buildings('1', '1');
    await buildings('2', '1');
    await buildings('3', '1');
    await buildings('1', '2');
    await buildings('2', '2');
    await buildings('3', '2');
    searchResults();
    super.onInit();
  }

  searchData(String item, String locationName, String cat, String type) async {
    newSearchList = [];

    String currentCalValue = '';
    String currentTypeValue = '';
    String currentItemValue = '';
  print("..........");
    print("xxxxxxxx===="+cat);
    print("xxxxx======"+type);
    print("..........");
    if (type == 'للبيع') {
      currentTypeValue = '1';
    } else {
      currentTypeValue = '2';
    }

    if (cat == 'عقار سكني') {
      currentCalValue = '1';
    } else if (cat == 'عقار استثماري') {
      currentCalValue = '2';
    } else {
      currentCalValue = '3';
    }

    if (item == 'سكني') {
      currentItemValue = '1';
    } else if (item == 'تجاري') {
      currentItemValue = '2';
    } else {
      currentItemValue = '3';
    }

    Ui.logError("P=======$currentItemValue");
    Ui.logError("P===1===$locationName");
    Ui.logError("P===2===$currentCalValue");
    Ui.logError("P===3===$currentTypeValue");
    Ui.logError("P===3===$currentTypeValue");

    /*
 P=======1
[log] P===1===العاصمة
[log] P===2===1
[log] P===3===1
    */

    var request = await http.post(
        Uri.parse(
            'https://manazelq8.org/brokers/buildings/building_search.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('realStateApp:realStateApp2024'))}',
        },
        body: json.encode({
          "item": currentItemValue,
          "location_country": locationName,
          "cat": currentCalValue,
          "type": currentTypeValue
        }));
    var responseBody = jsonDecode(request.body);
    print("STATUS CODE==========${request.statusCode}");
    print("bodyyyy==========${request.body}");
    // String bodyData=request.body;
    searchList = responseBody;
    newSearchList = searchList['data'];
    update();
    print("SEARCH========$searchList");
    print("SEARCH========$newSearchList");
  }

  List userFavList = [];

  getUserFav() async {
    print("FAVVVVV....");
    userFavList = [];
    Map<String, dynamic> fav = {};
    var request = await http.post(
        Uri.parse('https://manazelq8.org/brokers/fav/get_fav.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('realStateApp:realStateApp2024'))}',
        },
        body: json.encode({"user_id": "1"}));
    var responseBody = jsonDecode(request.body);
    print("STATUS FAV ==========${request.statusCode}");
    print("bodyyyy==========${request.body}");
    fav = responseBody;
    userFavList = fav['data'];
    print("FAVVVV======$userFavList");
    update();
  }

  checkIsFav(Building data) async {
    print("CHECK...............");
    print(data.id.toString());
    isFav.value = false;
    var request = await http.post(
        Uri.parse('https://manazelq8.org/brokers/fav/check_fav.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('realStateApp:realStateApp2024'))}',
        },
        body: json.encode({'user_id': '1', 'building_id': data.id.toString()}));
    var responseBody = jsonDecode(request.body);
    print("STATUS CODE==========${request.statusCode}");
    print("bodyyyy==========${request.body}");
    if (request.body.contains('true')) {
      isFav.value = true;
    } else {
      isFav.value = false;
    }
    update();
  }

  addToFav(Building data) async {
    var request = await http.post(
        Uri.parse('https://manazelq8.org/brokers/fav/add_fav.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('realStateApp:realStateApp2024'))}',
        },
        body: json.encode({'user_id': '1', 'building_id': data.id.toString()}));
    var responseBody = jsonDecode(request.body);
    print("STATUS CODE==========${request.statusCode}");
    print("bodyyyy==========${request.body}");
    isFav.value = true;
    update();
  }

  removeFromFav(Building data) async {
    var request = await http.post(
        Uri.parse('https://manazelq8.org/brokers/fav/remove_fav.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('realStateApp:realStateApp2024'))}',
        },
        body: json.encode({'user_id': '1', 'building_id': data.id.toString()}));
    var responseBody = jsonDecode(request.body);
    print("STATUS CODE==========${request.statusCode}");
    print("bodyyyy==========${request.body}");
    isFav.value = false;
    update();
  }

  final RxList<Color> colors = [
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
  ].obs;
  final RxList<String> filterMain = ['للبيع', 'للايجار'].obs;
  RxString selectMain = 'للبيع'.obs;

  final RxList<String> filterLocation = [
    'العاصمة',
    'الاحمدي',
    'الجهراء',
    'الفروانية',
    'مبارك الكبير',
    'حولي'
  ].obs;
  RxString selectLocation = 'العاصمة'.obs;

  final RxList<String> filterDesc = [
    'سكني',
    'تجاري',
    'اخري',
  ].obs;
  RxString selectDesc = 'سكني'.obs;

  final RxList<String> filterType = ['عقار سكني', 'عقار استثماري', 'اخري'].obs;
  RxString selectType = 'عقار سكني'.obs;

  // final categories = <Categories>[].obs;

  changeFilterMain(String value) {
    selectMain.value = value;

    update();
  }

  changeFilterLocation(String value) {
    selectLocation.value = value;

    update();
  }

  changeFilterType(String value) {
    selectType.value = value;
    update();
  }

  changeFilterDesc(String value) {
    selectDesc.value = value;
    update();
  }

  int? balance = 0; // Variable to store the balance

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late Stream<String> progressString;
  late String res;
  bool downloading = false;
  bool isDisable = true;

  Future<void> dowloadImage(BuildContext context, String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    progressString.listen((data) {
      res = data;
      downloading = true;
    }, onDone: () async {
      downloading = false;

      print("Task Done");

      downloading = false;

      isDisable = false;
      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text(
          'Image Set To Wallpaper Successfully',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFe91e63),
      ));
      print("Task Done");
      Get.back();
    }, onError: (error) {
      downloading = false;
      isDisable = true;
      print("Some Error");
    });
  }

  Future<void> fetchSliderImages() async {
    QuerySnapshot snapshot = await firestore.collection('advertise').get();
    sliderImagesList.value = snapshot.docs.map((doc) => doc['image']).toList();
    update();
  }

  void updateData(String docId) {
    DocumentReference docRef = firestore.collection('user').doc(docId);
    docRef.update({'price': 0, 'lock': false}).then((value) {
      if (kDebugMode) {
        print("Document updated successfully");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to update document: $error");
      }
    });
  }

  Future<void> me(String id) async {
    // print("BUILDINGSSSSS................");
    try {
      CustomLoading.showLoading('Loading');
      Ui.logSuccess('this meeeee ${id}');
      users.value = await userRepository.me(id);
      final box = GetStorage();
      box.write('current_user', users.value.toJson());
      Ui.logError('q12x ${users.value}');
      CustomLoading.cancelLoading();
    } catch (e) {
      print(e);
    }
  }

  Future<void> myAds() async {
    // print("BUILDINGSSSSS................");
    try {
      CustomLoading.showLoading('Loading');
      // Ui.logSuccess('this meeeee ${id}');
      adsList.value = await categoryRepository.myAds();

      Ui.logError('q12x ${adsList}');
      CustomLoading.cancelLoading();
    } catch (e) {
      print('ahoooo $e');
    }
  }

  Future<void> buildings(String cat, String type) async {
    print("BUILDINGSSSSS................");
    try {
      CustomLoading.showLoading('Loading');
     // Ui.logSuccess('start ${buildsOne.toJson()}');

      if (cat == '1' && type == '1') {
        buildsOne.value = await categoryRepository.buildings(cat, type);
      }
      if (cat == '2' && type == '1') {
        buildsTwo.value = await categoryRepository.buildings(cat, type);
      }
      if (cat == '3' && type == '1') {
        buildsThree.value = await categoryRepository.buildings(cat, type);
      }
      if (cat == '1' && type == '2') {
        buildsFour.value = await categoryRepository.buildings(cat, type);
      }
      if (cat == '2' && type == '2') {
        buildsFive.value = await categoryRepository.buildings(cat, type);
      }
      if (cat == '3' && type == '2') {
        buildsSix.value = await categoryRepository.buildings(cat, type);
      }

      Ui.logSuccess('ttttttttttttttkkkkkkkkkk2222 ${buildsOne}');
      Ui.logSuccess('ttttttttttttttkkkkkkkkkk2222 ${buildsTwo}');
      Ui.logSuccess('ttttttttttttttkkkkkkkkkk2222 ${buildsThree}');
    } catch (e) {
      Ui.logSuccess('ends ${e}');
      CustomLoading.cancelLoading();
      print(e);
    }
    //  loading = false;
    CustomLoading.cancelLoading();
    update();
  }

  final Uri _url = Uri.parse('https://wa.me/+96599211895');

  Future<void> launchUrlx() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Position? currentPosition;
  double currentLat = 0.0;
  double currentLong = 0.0;

  getCurrentLocation() async {
    try {
      // Request permission to access the device's location
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle accordingly
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied, take users to settings
        return;
      }
      // Get the current position
      Position position = await Geolocator.getCurrentPosition();
      currentPosition = position;
      currentLat = currentPosition!.latitude;
      currentLong = currentPosition!.longitude;

      update();
    } catch (e) {
      print(e);
    }
    print("LAT===$currentLat");
    print("lng==$currentLong");
    getEmployess();
  }

  getEmployess() async {
    empList = [];
    empFilterList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('employees').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      empList = data;
      for (int i = 0; i < empList.length; i++) {
        calculateDistance(
            currentLat, currentLong, empList[i]['lat'], empList[i]['lng']);
        print('distance==$distance');
        if (distance < 10) {
          empFilterList.add(empList[i]);
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
    // ignore: prefer_interpolation_to_compose_strings
    print("EMPLIST===" + empList.toString());
    update();
  }

  double distance = 0;
  static const double earthRadius = 6371.0; // Earth radius in kilometers

  static double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {
    print("startLat==$startLat");
    print("startLng==$startLng");
    print("endLat==$endLat");
    print("endLng==$endLng");

    double dLat = degreesToRadians(endLat - startLat);
    double dLng = degreesToRadians(endLng - startLng);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRadians(startLat)) *
            cos(degreesToRadians(endLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    distance = earthRadius * c;

    print("D==$distance");
    update(); // Distance in kilometers

    // return distance;
  }
}
