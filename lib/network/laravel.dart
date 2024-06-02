import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/models/building_model.dart';

import '../models/user_model.dart';
import 'providers.dart';

class LaravelApiClient extends GetxService with ApiClient {
  LaravelApiClient();
  ApiClient? apiClient;
  Future<LaravelApiClient> init() async {
    Get.lazyPut(() => Users());
    apiClient ;
    return this;
  }

  final authService = Users();

  // Future<Users> getUsers(Users user) async {
  //   Uri uri = getApiBaseUri("me");
  //   Get.log(uri.toString());
  //   var response = await _httpClient.getUri(uri,
  //       options: Options(headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'X-Requested-With': 'XMLHttpRequest',
  //         'Accept-Language': 'en',
  //         'Authorization': 'Bearer ${authService.apiToken}'
  //       }));
  //   if (response.data['data'] != null) {
  //     return Users.fromJson(response.data['data']);
  //   } else {
  //     throw Exception(response.data['message']);
  //   }
  // }

  Future<Users> login(Users user, String email, String pass) async {
    print("LOGIN");
    print(email);
    print(pass);
    print(basicUrl);
    //print('LOGIN==='+);
    Uri uri = getApiBaseUri("auth/login.php");
    Get.log(uri.toString());
    Ui.logError('123 $user');
    try {
      var request = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': basicUrl,
            // 'Authorization': 'Bearer $token'
          },
          body: json.encode({'user_email': email, 'pass': pass})
          //(user)
          );
      var responseBody = jsonDecode(request.body);
      if (responseBody['success'] == true) {
        Ui.logSuccess('dfgh ${responseBody['data']}');
        return Users.fromJson(responseBody['data']);
      } else {
        print(responseBody.toString());
        Ui.logError(responseBody);
        Get.showSnackbar(Ui.ErrorSnackBar(message: 'Wrong Email or Password'));
        return Users.fromJson(responseBody['data']);
      }
    } catch (e) {
      Ui.logError(e);
      throw Exception('Error');
    }
  }

  Future<bool> register(Users user) async {
    Uri uri = getApiBaseUri("auth/register.php");
    Get.log(uri.toString());
    Ui.logError(json.encode(user));
    try {
      var request = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': basicUrl,
            // 'Authorization': 'Bearer $token'
          },
          //    body: json.encode({user}));
          body: json.encode(user));
      var responseBody = jsonDecode(request.body);
      if (responseBody['success'] == true) {
        Ui.logError(responseBody);
        return true;
      } else {
        Ui.logError(responseBody);
        return false;
      }
    } catch (e) {
      Ui.logSuccess(e);
      return false;
    }
  }

  Future<Users> me(String id) async {
    Uri uri = getApiBaseUri("auth/user_with_id.php");
    Get.log(uri.toString());
    Ui.logError('the user id is (${id})');
    try {
      var request = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': basicUrl,
            // 'Authorization': 'Bearer $token'
          },
          //    body: json.encode({user}));
          body: json.encode({
            'user_id': id,
          }));
      var responseBody = jsonDecode(request.body);
      if (responseBody['success'] == true) {
        Ui.logError('1z2x ${responseBody['data']}');
        return Users.fromJson(responseBody['data']);
      } else {
        Ui.logError(responseBody);
        return Ui.logError('wrong credits');
      }
    } catch (e) {
      Ui.logSuccess(e);
      return Ui.logError('Contact Support');
    }
  }

  Future getAds() async {
    Uri uri = getApiBaseUri("carsoul/images.php");
    Get.log(uri.toString());
    try {
      var request = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': basicUrl,
          },
         );
      var responseBody = jsonDecode(request.body);
      if (responseBody['success'] == true) {
        Ui.logSuccess('1z2x ${responseBody['Data']}');
        return responseBody['Data'];
      } else {
        Ui.logError(responseBody);
        return Ui.logError('wrong credits');
      }
    } catch (e) {
      Ui.logSuccess(e);
      return Ui.logError('Contact Support');
    }
  }

  Future<bool> updateUser(Users user) async {
    print("USER=====$user");
    print("USER=====${user.image}");
    Uri uri = getApiBaseUri("auth/update_user.php");
    Get.log(uri.toString());
    Ui.logError('the user id is (${user})');
    try {
      var request = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': basicUrl,
            // 'Authorization': 'Bearer $token'
          },
          //    body: json.encode({user}));
          body: json.encode({
            "user_name": user.name,
            "image_user":user.image.toString(),
            "user_email": user.email,
            "phone": user.phoneNumber,
            "user_id": user.userId
          }));
      var responseBody = jsonDecode(request.body);
      print("RES=======$responseBody");
      if (responseBody['success'] == true) {
       // Ui.logError('1z2x ${responseBody['data']}');
        return true;
      } else {
        Ui.logError(responseBody);
        return false;
      }
    } catch (e) {
      Ui.logSuccess(e);
      return Ui.logError('Contact Support');
    }
  }

  Future<List<Building>> buildings(String cat, String type) async {
    print("cat===$cat..........type===$type");
    print("GET BUILDINGS API HERE... $basicUrl");
    Uri uri = getApiBaseUri("buildings/get_cat_building.php");
    //("buildings/get_buildings.php");
    Get.log(uri.toString());
    //Ui.logError(build);
    var request = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicUrl,
          //   'Authorization': 'Bearer $token'
        },
        // String basicUrl='Basic '+base64Encode(utf8
        //     .encode('realStateApp:realStateApp2024'));
        //
        //
        // 'Authorization':basicUrl,
        body: json.encode({"cat": cat, "type": type})
        //    body: json.encode({user}));
        //   body: json.encode({build})
        );
    var responseBody = jsonDecode(request.body);
    if (request.statusCode == 200) {
      print("STATUS CODE====${request.statusCode}");
      Ui.logError(responseBody);
      return responseBody['data']
          .map<Building>((obj) => Building.fromJson(obj))
          .toList();
    } else {
      print("STATUS CODE====${request.statusCode}");
      Ui.logError(responseBody['success']);
      throw Exception(responseBody['message']);
    }
  }

  Future<bool> deleteUser(String id) async {
    Uri uri = getApiBaseUri("auth/delete_user.php");
    Get.log(uri.toString());
    try {
      var request = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': basicUrl,
            // 'Authorization': 'Bearer $token'
          },
          //    body: json.encode({user}));
          body: json.encode({
           // 'user_id': id,
          }));
      //        Ui.logError('the user id is (${baseUrl})');

      var responseBody = jsonDecode(request.body);
      if (responseBody['success'] == true) {
        Ui.logError('1z2x ${responseBody['data']}');
        return true;
      } else {
        Ui.logError(responseBody);
        return false;
      }
    } catch (e) {
      Ui.logSuccess(e);
      return Ui.logError('Contact Support');
    }
  }

  Future<bool> deleteBuild(String id) async {
    Uri uri = getApiBaseUri("buildings/delete_building.php");
    Get.log(uri.toString());
  //  Ui.logError('the user id is (${id})');
    try {
      var request = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': basicUrl,
            // 'Authorization': 'Bearer $token'
          },
          //    body: json.encode({user}));
          body: json.encode({
            'id': id,
          }));
      var responseBody = jsonDecode(request.body);
      if (responseBody['success'] == true) {
        Ui.logError('1z2x ${responseBody['data']}');
        return true;
      } else {
        Ui.logError(responseBody);
        return false;
      }
    } catch (e) {
      Ui.logSuccess(e);
      return Ui.logError('Contact Support');
    }
  }

  Future<List<Building>> myBuildings(String userId) async {
    print("GET BUILDINGS API HERE... $basicUrl");
    Uri uri = getApiBaseUri("buildings/get_user_buildings.php");
    //("buildings/get_buildings.php");
    Get.log(uri.toString());
    //Ui.logError(build);
    var request = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicUrl,
          //   'Authorization': 'Bearer $token'
        },
        // String basicUrl='Basic '+base64Encode(utf8
        //     .encode('realStateApp:realStateApp2024'));
        //
        //
        // 'Authorization':basicUrl,
        body: json.encode({"user_id": userId})
        //    body: json.encode({user}));
        //   body: json.encode({build})
        );
    var responseBody = jsonDecode(request.body);
    if (request.statusCode == 200) {
      Ui.logError(responseBody);
      return responseBody['data']
          .map<Building>((obj) => Building.fromJson(obj))
          .toList();
    } else {
      Ui.logError(responseBody['success']);
      throw Exception(responseBody['message']);
    }
  }
  // Future<bool> verifyEmail(Users user) async {
  //   Uri uri = getApiBaseUri("confirm/email");
  //   Get.log(uri.toString());
  //   try {
  //     var response = await _httpClient.postUri(uri,
  //         data: {'email': user.email, 'verification_code': user.verify},
  //         options: Options(headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'X-Requested-With': 'XMLHttpRequest',
  //           'Accept-Language': 'en',
  //           'Authorization': 'Bearer ${authService.apiToken}'
  //         }));
  //     if (response.data['message'] == 'Email Confirmed') {
  //       return true;
  //     } else if (response.data['message'] ==
  //         'This code is not correct or expire') {
  //       return false;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> sendResetLinkEmail(Users user) async {
  //   Uri uri = getApiBaseUri("forget/password");
  //   Get.log(uri.toString());
  //   // to remove other attributes from the user object
  //   user = Users(email: user.email);
  //   var response = await _httpClient.postUri(
  //     uri,
  //     data: json.encode(user.toJson()),
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['message'] ==
  //       'please check your email to set your  password') {
  //     return true;
  //   } else {
  //     throw Exception(response.data['message']);
  //   }
  // }

  // Future<Users> updateUsers(Users user) async {
  //   Uri uri = getApiBaseUri("account/update");
  //   Get.log(uri.toString());
  //   try {
  //     var response = await _httpClient.postUri(uri,
  //         options: Options(headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'X-Requested-With': 'XMLHttpRequest',
  //           'Accept-Language': 'en',
  //           'Authorization': 'Bearer ${authService.apiToken}'
  //         }));

  //     if (response.data['data'] != null) {
  //       response.data['data']['auth'] = true;
  //       return Users.fromJson(response.data['data']);
  //     } else {
  //       throw Exception(response.data['message']);
  //     }
  //   } catch (error) {
  //     throw Exception("Error uploading image: $error");
  //   }
  // }
}
