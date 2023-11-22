import 'package:get/get.dart';

import 'd_apps_controller.dart';

class DAppsBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<DAppsController>(() => DAppsController());
    Get.put<DAppsController>(DAppsController());
  }
}
