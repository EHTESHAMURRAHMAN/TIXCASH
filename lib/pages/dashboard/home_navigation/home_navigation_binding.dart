import 'package:get/get.dart';

import 'home_navigation_controller.dart';

class HomeNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeNavigationController>(() => HomeNavigationController());
  }
}
