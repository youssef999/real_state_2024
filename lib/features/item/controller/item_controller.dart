// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/models/building_model.dart';
import 'package:realstate/models/user_model.dart';

class ItemController extends GetxController {
  String catValue = 'Graphic Design';

  RxMap<String, dynamic>? userData = <String, dynamic>{}.obs;
  String? roleId;
  String? radioValue; //Initial definition of radio button value
  String? choice;
  TextEditingController emailController = TextEditingController();
  final build = Building().obs;
  Rx<int> firstValue = 1.obs;
  Rx<int> secoundValue = 1.obs;

  @override
  void onInit() async {
    radioValue = "one";
    selectedListArea.value = firstArea;
    super.onInit();
  }

  final RxList<String> countryNames = [
    'العاصمة',
    'الاحمدي',
    'الجهراء',
    'الفروانية',
    'مبارك الكبير',
    'حولي'
  ].obs;
  RxString selectedCountry = 'العاصمة'.obs;
  final RxList<String> selectedListArea = <String>[].obs;

  final ImagePicker _picker = ImagePicker();
  final ImagePicker _picker2 = ImagePicker();

  pickMultiImage() async {
    pickedImageXFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    update();
  }

  pickMultiImage2() async {
    pickedImageXFiles2 = await _picker2.pickMultiImage(
      imageQuality: 100,
    );
    update();
  }

  final RxList<String> firstArea = [
    "أبو فطيرة",
    "أبو فطيرة الشريط الساحلي (أبو الحصاني)",
    "الجابرية",
    "الخالدية",
    "الدسمة",
    "الدعية",
    "الدوحة",
    "الرابية",
    "الروضة",
    "السرة",
    "السلام",
    "الشامية",
    "الشعب",
    "الشهداء",
    "الشويخ السكني",
    "الصديق",
    "العديلية",
    "الفيحاء",
    "القادسية",
    "القصر",
    "القيروان",
    "المنصورية",
    "النزهة",
    "النهضة",
    "بيان",
    "جابر الأحمد",
    "حطين",
    "كيفان",
    "مبارك العبدالله",
    "مشرف",
  ].obs;

  final RxList<String> secondArea = [
    "أبو حليفة",
    "الأحمدي",
    "الجليعة",
    "الخيران السكنية",
    "الرقة",
    "الزور",
    "الشعيبة",
    "الصباحية",
    "الضباعية",
    "الظهر",
    "العقيلة",
    "الفحيحيل",
    "الفنطاس الزراعية",
    "المقوع",
    "المنقف",
    "المهبولة",
    "النويصيب",
    "الوفرة السكنية",
    "الوفرة الزراعية",
    "أم الهيمان",
    "بنيدر",
    "جابر العلي",
    "علي صباح السالم",
    "فهد الأحمد",
    "مدينة الخيران",
    "مدينة صباح الأحمد",
    "مدينة صباح الأحمد البحرية",
    "ميناء عبد الله",
    "هدية",
    "واره"
  ].obs;
  final RxList<String> thirdArea = [
    "أبرق خيطان",
    "إشبيلية",
    "الأندلس",
    "الحساوي",
    "الخيطان",
    "الخيطان الجديدة",
    "الرحاب",
    "الرقعي",
    "الري الصناعية",
    "الشدادية",
    "الضجيج",
    "العارضية",
    "العارضية الصناعية",
    "العمرية",
    "الفردوس",
    "الفروانية",
    "جليب الشيوخ",
    "ضاحية صباح الناصر",
    "ضاحية عبد الله المبارك",
  ].obs;
  final RxList<String> forthArea = [
    "البدع",
    "الرميثية",
    "الزهراء",
    "السالمية",
    "الشعب",
    "الشهداء",
    "النقرة",
    "جنوب السرة",
    "سلوى",
    "ضاحية مبارك العبد الله الجابر",
    "مشرف",
    "منطقة حولي",
    "ميدان حولي",
  ].obs;
  final RxList<String> fifthArea = [
    "القرين",
    "ضاحية مبارك الكبير",
    "العدان",
    "القصور",
    "ضاحية صباح السالم",
    "المسيلة",
    "صبحان",
    "الفنيطيس",
    "أبو فطيرة",
    "المسايل",
    "أبو الحصانية",
  ].obs;
  final RxList<String> sixthArea = [
    "الجهراء الجديدة",
    "الجهراء القديمة",
    "الروضتين",
    "السالمي",
    "الصبية",
    "الصليبية",
    "العبدلي",
    "العيون",
    "القصر",
    "القيصرية",
    "المطلاع",
    "النسيم",
    "النعيم",
    "الواحة",
    "أمغرة",
    "تيماء",
    "كاظمة",
    "كبد",
    "مدينة الحرير",
    "مدينة سعد العبد الله",
  ].obs;

  RxString selectedArea = "أبو فطيرة".obs;
  changeFilterCountry(String value) {
    selectedCountry.value = value;

    if (selectedCountry.value == 'العاصمة') {
      selectedListArea.value = firstArea;
      selectedArea = "أبو فطيرة".obs;
    } else if (selectedCountry.value == 'الاحمدي') {
      selectedListArea.value = secondArea;
      selectedArea = "أبو حليفة".obs;
    } else if (selectedCountry.value == 'الجهراء') {
      selectedListArea.value = thirdArea;
      selectedArea = "أبرق خيطان".obs;
    } else if (selectedCountry.value == 'الفروانية') {
      selectedListArea.value = forthArea;
      selectedArea = "البدع".obs;
    } else if (selectedCountry.value == 'مبارك الكبير') {
      selectedListArea.value = fifthArea;
      selectedArea = "القرين".obs;
    } else if (selectedCountry.value == 'حولي') {
      selectedListArea.value = sixthArea;
      selectedArea = "الجهراء الجديدة".obs;
    }

    update();
  }

  String imageLink = '';
  List<XFile>? pickedImageXFiles;

  String imageLink2 = '';
  List<XFile>? pickedImageXFiles2;

  uploadImageToServer2(String imagePath) async {

    print("imagepath===$imagePath");
    try {
      // Read image file as bytes
      File imageFile = File(imagePath);
      List<int> imageBytes = await imageFile.readAsBytes();
      // Encode image bytes to base64
      String base64Image = base64Encode(imageBytes);

      // Prepare POST request body
      Map<String, String> requestBody = {
        'image': base64Image,
      };
      // Send POST request to Imgur API
      final response = await http.post(
        Uri.parse('https://api.imgur.com/3/image'),
        headers: {
          'Authorization': "Client-ID " + "fb8a505f4086bd5",
          //'Client-ID $clientId',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      // Check if the request was successful
      if (response.statusCode == 200) {
        print("IMAGE200");
        // Parse response JSON
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // Check if upload was successful
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('link')) {
          print(responseData['data']['link']);
          imageLink = responseData['data']['link'];
          // Image uploaded successfully
          return responseData['data']['link'];
        } else {
          print("ELSEEE IMAGE");
          // Image upload failed
          throw ('Image upload failed: ${response.body}');
        }
      } else {
        // Request failed
        print("ELSEEE 2222 IMAGE");
        throw ('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      print('Error uploading image: $e');
      return 'eee';
    }
  }
String downloadUrl = '';
String downloadUrl2 = '';
  List<String> downloadUrls = [];
  List<String> downloadUrls2 = [];

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

  Future uploadMultiImageToFirebaseStorage2(List<XFile> images) async {
    for (int i = 0; i < images.length; i++) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference =
        FirebaseStorage.instance.ref().child('images2024/$fileName');
        UploadTask uploadTask = reference.putFile(File(images[i].path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        downloadUrl2 = await taskSnapshot.ref.getDownloadURL();
        downloadUrls2.add(downloadUrl2);
      } catch (e) {
        // Handle any errors that occur during the upload process
        // ignore: avoid_print
        print('Error uploading image to Firebase Storage: $e');
      }
    }
    return downloadUrls2;
  }

  // uploadImageToServer(String imagePath) async {
  //   print("imagepath===$imagePath");
  //   try {
  //     // Read image file as bytes
  //     File imageFile = File(imagePath);
  //     List<int> imageBytes = await imageFile.readAsBytes();
  //     // Encode image bytes to base64
  //     String base64Image = base64Encode(imageBytes);
  //
  //     // Prepare POST request body
  //     Map<String, String> requestBody = {
  //       'image': base64Image,
  //     };
  //     // Send POST request to Imgur API
  //     final response = await http.post(
  //       Uri.parse('https://api.imgur.com/3/image'),
  //       headers: {
  //         'Authorization': "Client-ID " + "fb8a505f4086bd5",
  //         //'Client-ID $clientId',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(requestBody),
  //     );
  //     // Check if the request was successful
  //     if (response.statusCode == 200) {
  //       print("IMAGE200");
  //       // Parse response JSON
  //       Map<String, dynamic> responseData = jsonDecode(response.body);
  //       // Check if upload was successful
  //       if (responseData.containsKey('data') &&
  //           responseData['data'].containsKey('link')) {
  //         print(responseData['data']['link']);
  //         imageLink = responseData['data']['link'];
  //         // Image uploaded successfully
  //         return responseData['data']['link'];
  //       } else {
  //         print("ELSEEE IMAGE");
  //         // Image upload failed
  //         throw ('Image upload failed: ${response.body}');
  //       }
  //     } else {
  //       // Request failed
  //       print("ELSEEE 2222 IMAGE");
  //       throw ('Failed to upload image: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle errors
  //     print('Error uploading image: $e');
  //     return 'eee';
  //   }
  // }

  changeFilterArea(String value) {
    selectedArea.value = value;
    update();
  }

  addNewItem() async {


    final box = GetStorage();
    final users = Users().obs;
    users.value = Users.fromJson(box.read('current_user'));

    print("ADD NEW ITEM.....");
    Ui.logSuccess('1z1z ${imageLink}');
    String basicUrl =
        'Basic ${base64Encode(utf8.encode('realStateApp:realStateApp2024'))}';

     downloadUrls.add(imageLink2.toString());

    try{
      var request = await http.post(
        //
          Uri.parse
            ('https://manazelq8.org/brokers/buildings/add_building.php'),
          headers: {
           // 'Content-Type': 'application/json',
            'Authorization': basicUrl,
          },
          body: json.encode({
            "images": downloadUrls.toString(),
            "threeDImages": [imageLink2].toString(),
            'image_user': users.value.image.toString(),
            // "https://content.almalnews.com/wp-content/uploads/2019/10/%D8%A7%D9%84%D8%A7%D8%B3%D9%83%D8%A7%D9%86-1.jpg",
            'id': build.value.id,
            'name': build.value.name,
            'cat': build.value.cat,
            'type': build.value.type,
            'description': build.value.description,
            'price': build.value.price,
            'location_country': build.value.locationCountry,
            'location_area': build.value.locationArea,
            'address': build.value.address,
            'building_number': build.value.buildNum,
            'floor_number': build.value.buildingSteps,
            'toilet_number': build.value.toilet,
            'monthly_rent': build.value.rentMonthly,
            'rent_time': build.value.rentTime,
            'bank_security': build.value.bankSafe,
            'availability_time': build.value.lettingTime,
            //'images': build.value.image,
            'rooms_number': build.value.rooms,
            'area': build.value.space,
             'item':'1'
          }));
      // var responseBody =jsonDecode(request.body);
      print("STATUS locations CODE==========${request.statusCode}");
      print("bodyyyy===xxxxx=======${request.body}");
      update();
    }catch(e){
      print("ERROR==ADD ITEM="+e.toString());
    }

  }

  void radioButtonChanges(String? value) {
    radioValue = value;
    switch (value) {
      case 'one':
        choice = value;
        break;
      case 'two':
        choice = value;
        break;
      case 'three':
        choice = value;
        break;
      default:
        choice = null;
    }

    update();
    //   print(choice); //Debug the choice in console
  }
}
