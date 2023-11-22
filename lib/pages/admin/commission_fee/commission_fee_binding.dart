import 'package:get/get.dart';

import 'commission_fee_controller.dart';

class CommissionFeeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<CommissionFeeController>(() => CommissionFeeController());
    Get.put<CommissionFeeController>(CommissionFeeController());
  }
}
