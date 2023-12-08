import 'package:get/get.dart';
import 'package:tixcash/pages/Stack/Stack_Controller.dart';

class StackIncomeController extends GetxController {
  StackController stackcontroller = Get.put(StackController());
  @override
  void onInit() {
    super.onInit();
    stackcontroller.stakedashboard();
  }
}
