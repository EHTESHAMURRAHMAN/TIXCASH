import 'package:get/get.dart';

import 'finger_print_login_controller.dart';

class FingerPrintLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FingerPrintLoginController>(FingerPrintLoginController());
  }
}
