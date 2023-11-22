import 'package:get/get.dart';

import 'tyv_market_controller.dart';

class TyvMarketBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<TyvMarketController>(() => TyvMarketController());
    Get.put<TyvMarketController>(TyvMarketController());
  }
}
