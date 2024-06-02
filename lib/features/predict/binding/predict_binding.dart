import 'package:get/get.dart';
import 'package:realstate/features/predict/controller/predict_controller.dart';


class PredictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PredictController>(
      () => PredictController(),
    );
 
  }
}