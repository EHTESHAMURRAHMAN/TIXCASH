import 'package:get/get.dart';

import '../controllers/auth_fingerprint_controller.dart';

class AuthFingerprintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthFingerprintController>(
      () => AuthFingerprintController(),
    );
  }
}
