import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';
import '../repositories/user_storage.dart';

class AuthService extends GetxService {
  final user = Users().obs;
  late GetStorage _box;

  late UserRepository usersRepo;

  AuthService() {
    usersRepo =  UserRepository();
    _box =  GetStorage();
  }

  Future<AuthService> init() async {
    user.listen((Users _user) {
      _box.write('current_user', _user.toJson());
    });
    await getCurrentUser();
    return this;
  }

  Future getCurrentUser() async {
    if (user.value.auth == null && _box.hasData('current_user')) {
      user.value = Users.fromJson(await _box.read('current_user'));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future removeCurrentUser() async {
    user.value =  Users();
    await _box.remove('current_user');
  }

  bool get isAuth => user.value.auth ?? false;

  String get apiToken => (user.value.auth ?? false) ? user.value.apiToken! : '';
}
