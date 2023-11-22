import 'package:get/get.dart';

import 'add_coin_controller.dart';

class AddCoinBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AddCoinController>(() => AddCoinController());
    Get.put<AddCoinController>(AddCoinController());
  }
}
