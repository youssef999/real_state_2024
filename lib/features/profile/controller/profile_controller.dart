import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:get_storage/get_storage.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/core/widgets/custom_loading.dart';
import 'package:realstate/models/user_model.dart';
import 'package:realstate/repositories/user_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  // RxMap<String, dynamic> meUser = <String, dynamic>{}.obs;
  // String? roleId ;
//  Map<String, dynamic> meUser = {};

  late UserRepository userRepository;
  String imageLink = '';
  List<XFile>? pickedImageXFiles;

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
  final ImagePicker _picker = ImagePicker();
  pickMultiImage() async {
    pickedImageXFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    update();
  }

  ProfileController() {
    userRepository = UserRepository();
  }

  String? id;
  final users = Users().obs;

  @override
  void onInit() async {
    var box = GetStorage();
    try {
      //  meUser.value = box.read('current_user');
      users.value = Users.fromJson(box.read('current_user'));
      id = users.value.userId!;
      Ui.logSuccess('zzzzzzz $users');
    } catch (e) {
      print(e);
    }

    // await data();
    super.onInit();
  }

  Future<void> deleteAccount() async {
    print("Delete Users................");
    try {
      CustomLoading.showLoading('Loading');
      Ui.logSuccess('start ${id}');
      var box = GetStorage();

      bool x = await userRepository.deleteUser(id!);
      if (x) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: 'Account Deleted Successfully'));
        box.remove('current_user');
        Get.back();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: 'Contact Support To Delete'));
      }
      //  Ui.logSuccess('zxxc ${build}');
      CustomLoading.cancelLoading();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUser() async {
    print("Update Users................");
    try {
      CustomLoading.showLoading('Loading');
      users.value.image = imageLink.toString();
      Ui.logSuccess('start ${users.value}');
      //  var box = GetStorage();
      bool x = await userRepository.updateUser(users.value);
      if (x) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: 'Account Updated Successfully'));
        //box.remove('current_user');
        Get.back();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: 'Contact Support To Update'));
      }
      //  Ui.logSuccess('zxxc ${build}');
      CustomLoading.cancelLoading();
    } catch (e) {
      print(e);
    }
  }

  updateUserData()async{

  }


}
