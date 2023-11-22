import 'package:get/get.dart';

import 'liquidity_controller.dart';

class LiquidityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiquidityController>(() => LiquidityController());
  }
}
