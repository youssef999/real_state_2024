import 'package:get/get.dart';
import 'package:realstate/features/users/controllers/users_controller.dart';


class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersController>(
      () => UsersController(),
    );
 
  }
}