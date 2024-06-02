
import 'package:get/get.dart';
import '../network/laravel.dart';

class PaymentRepository {
  late LaravelApiClient laravelApiClient;

  PaymentRepository() {
    laravelApiClient = Get.find<LaravelApiClient>();
  }


}