import 'package:get/get.dart';
import 'package:realstate/features/item/controller/item_controller.dart';

class ItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(
      () => ItemController(),
    );
  }
}
