import 'package:get/get.dart';
import 'package:realstate/models/building_model.dart';

import '../network/laravel.dart';

class CategoryRepository {
 late LaravelApiClient laravelApiClient;

  CategoryRepository() {
    laravelApiClient = Get.find<LaravelApiClient>();
  }

  Future<List<Building>> buildings(String cat,String type ) {
    laravelApiClient = Get.find<LaravelApiClient>();
    return laravelApiClient.buildings(cat,type);
  }


  Future<List<Building>> myBuildings(String userId) {
    laravelApiClient = Get.find<LaravelApiClient>();
    return laravelApiClient.myBuildings(userId);
  }
  Future myAds( ) {
    laravelApiClient = Get.find<LaravelApiClient>();
    return laravelApiClient.getAds();
  }
  Future<bool> deleteBuild(String id) {
    laravelApiClient = Get.find<LaravelApiClient>();
    return laravelApiClient.deleteBuild(id);
  }
}