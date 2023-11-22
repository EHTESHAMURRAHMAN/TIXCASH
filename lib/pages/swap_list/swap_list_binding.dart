import 'package:get/get.dart';

import 'swap_list_controller.dart';

class SwapListBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<SwapListController>(() => SwapListController());
    Get.put<SwapListController>(SwapListController());
  }
}
