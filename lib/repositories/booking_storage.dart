
// ignore_for_file: unnecessary_this

import 'package:get/get.dart';

import '../network/laravel.dart';

class BookingRepository {
  
  late LaravelApiClient laravelApiClient;

  BookingRepository() {
    this.laravelApiClient = Get.find<LaravelApiClient>();
  }
}
