import 'package:get/get.dart';

import 'add_store_controller.dart';

class AddStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStoreController>(() => AddStoreController());
  }
}
