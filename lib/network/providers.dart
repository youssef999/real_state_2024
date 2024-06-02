/*
 * File name: api_provider.dart
 * Last modified: 2022.02.14 at 12:25:29
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:convert';

import 'package:get/get.dart';
import 'package:realstate/network/trace.dart';

mixin ApiClient {
  late String baseUrl;
  
  String basicUrl =
      'Basic ${base64Encode(utf8.encode('realStateApp:realStateApp2024'))}';

  Uri getApiBaseUri(String path) {
    return Uri.parse('https://manazelq8.org/brokers/$path');
  }

  Uri getApiBaseUriT(String path) {
    return Uri.parse('https://manazelq8.org/brokers/$path');
  }

  Uri getBaseUri(String path) {
    return Uri.parse('https://manazelq8.org/brokers/$path');
  }

  void printUri(StackTrace stackTrace, Uri uri) {
    Get.log(CustomTrace(stackTrace, message: uri.toString()).toString());
  }
}
