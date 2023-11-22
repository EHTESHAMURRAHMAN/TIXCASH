import 'package:get/get.dart';

import 'transaction_history_controller.dart';

class TransactionHistoryBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<TransactionHistoryController>(() => TransactionHistoryController());
    // Get.put<TransactionHistoryController>(3.001HistoryController(), permanent: true);
    Get.put<TransactionHistoryController>(
      TransactionHistoryController(),
    );
  }
}
