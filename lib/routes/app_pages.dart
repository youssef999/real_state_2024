import 'package:get/get.dart';
import 'package:realstate/features/auth/binding/auth_binding.dart';
import 'package:realstate/features/auth/views/login_view.dart';
import 'package:realstate/features/auth/views/register_view2.dart';
import 'package:realstate/features/auth/views/select_location2.dart';
import 'package:realstate/features/home/binding/home_binding.dart';
import 'package:realstate/features/home/views/home_view.dart';
import 'package:realstate/features/item/binding/item_binding.dart';
import 'package:realstate/features/item/view/item_view.dart';
import 'package:realstate/features/itemview/binding/itemview_binding.dart';
import 'package:realstate/features/itemview/view/itemview_view.dart';
import 'package:realstate/features/predict/binding/predict_binding.dart';
import 'package:realstate/features/predict/view/predict_view.dart';
import 'package:realstate/features/profile/binding/profile_binding.dart';
import 'package:realstate/features/profile/view/profile_view.dart';
import 'package:realstate/features/root/binding/root_binding.dart';
import 'package:realstate/features/root/view/root_view.dart';
import 'package:realstate/features/splash/splash_view.dart';
import 'package:realstate/features/users/binding/users_binding.dart';
import 'package:realstate/features/users/views/users_view.dart';

import 'app_routes.dart';

class Theme1AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => const SplashView()),
    GetPage(name: Routes.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(name: Routes.ROOT, page: () => RootView(), binding: RootBinding()),
    GetPage(
        name: Routes.PROFILE,
        page: () => const ProfileView(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.LOGIN,
        page: () => const LoginView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.LOCATION,
        page: () => const SearchPlacesView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.ITEM,
        page: () => const ItemView(),
        binding: ItemsBinding()),
    GetPage(
        name: Routes.ITEMV,
        page: () => const ItemVView(),
        binding: ItemViewBinding()),
    GetPage(
        name: Routes.PREDICT,
        page: () => const PredictView(),
        binding: PredictBinding()),
    GetPage(
        name: Routes.REGISTER,
        page: () => const SignUpView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.USERS,
        page: () => const UsersView(),
        binding: UsersBinding()),
  ];
}
