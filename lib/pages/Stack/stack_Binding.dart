import 'package:get/get.dart';
import 'package:tixcash/pages/Stack/Stack_Controller.dart';

class StackBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StackController>(StackController());
  }
}
