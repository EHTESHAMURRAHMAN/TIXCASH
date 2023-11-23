import 'package:get/get.dart';

import '../controllers/myReferral_controller.dart';

class MyReferralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MyReferralController>(MyReferralController());
  }
}
