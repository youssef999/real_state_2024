import 'package:get/get.dart';
import 'package:realstate/features/root/controller/root_controller.dart';


class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
 
  }
}