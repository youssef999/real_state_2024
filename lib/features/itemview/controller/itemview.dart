import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:realstate/core/resources/app_strings.dart';
import 'package:realstate/core/widgets/custom_loading.dart';
import 'package:realstate/models/building_model.dart';
import 'package:realstate/models/user_model.dart';
import 'package:realstate/repositories/category_storage.dart';

class ItemViewController extends GetxController {
  late CategoryRepository categoryRepository;

  ItemViewController() {
    categoryRepository = CategoryRepository();
  }
  final users = Users().obs;

  var build = <Building>[].obs;

  @override
  void onInit() async {
    var box = GetStorage();
    try {
      //  meUser.value = box.read('current_user');
      users.value = Users.fromJson(box.read('current_user'));
      Ui.logSuccess('zzzzzzz $users');
      myBuildings(users.value.userId!);
    } catch (e) {
      print(e);
    }

    // await data();
    super.onInit();
  }

  Future<void> myBuildings(String userId) async {
    print("BUILDINGSSSSS................");
    try {
      CustomLoading.showLoading('Loading');
      Ui.logSuccess('start ${userId}');

      build.value = await categoryRepository.myBuildings(userId);
      Ui.logSuccess('zxxc ${build}');
      CustomLoading.cancelLoading();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteBuild(String id) async {
    print("DELETE BUILDINGSSSSS................");
    try {
      CustomLoading.showLoading('Loading');
      Ui.logSuccess('start ${id}');

      bool x = await categoryRepository.deleteBuild(id);
      if (x) {
        Get.showSnackbar(Ui.SuccessSnackBar(message: 'success'));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: 'failed'));
      }
      Ui.logSuccess('zxxc ${build}');
      CustomLoading.cancelLoading();
    } catch (e) {
      print(e);
    }
  }
}
