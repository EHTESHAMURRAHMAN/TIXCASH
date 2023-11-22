import 'package:get/get.dart';

import 'tyv_scan_controller.dart';

class TyvScanBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<TyvScanController>(() => TyvScanController());
    Get.put<TyvScanController>(TyvScanController());
  }
}
