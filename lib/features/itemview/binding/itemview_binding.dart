import 'package:get/get.dart';
import 'package:realstate/features/itemview/controller/itemview.dart';
import 'package:realstate/features/profile/controller/profile_controller.dart';


class ItemViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemViewController>(
      () => ItemViewController(),
    );
 
  }
}