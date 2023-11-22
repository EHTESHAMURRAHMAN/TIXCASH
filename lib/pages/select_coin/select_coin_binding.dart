import 'package:get/get.dart';

import 'select_coin_controller.dart';

class SelectCoinBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<SelectCoinController>(() => SelectCoinController());
    Get.put<SelectCoinController>(SelectCoinController());
  }
}
