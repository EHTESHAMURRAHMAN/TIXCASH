import 'package:get/get.dart';

import 'send_tyv_controller.dart';

class SendTyvBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<SendTyvController>(() => SendTyvController());
    Get.put<SendTyvController>(SendTyvController());
  }
}
