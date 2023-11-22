import 'package:get/get.dart';

import 'transaction_detail_controller.dart';

class TransactionDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<TransactionDetailController>(() => TransactionDetailController());
    Get.put(() => TransactionDetailController());
  }
}
