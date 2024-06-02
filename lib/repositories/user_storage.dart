import 'package:get/get.dart';

import '../models/user_model.dart';
import '../network/laravel.dart';

class UserRepository {
  late LaravelApiClient _laravelApiClient;

  Future<Users> login(Users user,String email,String pass) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.login(user,email,pass);
  }

  Future<Users> me(String user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.me(user);
  }
  Future<bool> updateUser(Users user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.updateUser(user);
  }
  
    Future<bool> deleteUser(String userId) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.deleteUser(userId);
  }
  // Future<Users> get(Users user) {
  //   _laravelApiClient = Get.find<LaravelApiClient>();
  //   return _laravelApiClient.getUsers(user);
  // }

  Future<bool> register(Users users) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.register(users);
  }
}

