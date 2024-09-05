import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/view/splash_screen.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.routeHOME; //home
  // static const PARTIAL = Routes.LOGIN; //Login

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.pathHOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
