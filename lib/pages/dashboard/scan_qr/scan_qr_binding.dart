import 'package:get/get.dart';

import 'scan_qr_controller.dart';

class ScanQrBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ScanQrController>(() => ScanQrController());
    Get.put<ScanQrController>(ScanQrController());
  }
}
