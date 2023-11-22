import 'package:get/get.dart';
import 'package:tixcash/pages/Stack_Income/Stackincome_controller.dart';

class StackincomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StackIncomeController>(StackIncomeController());
  }
}
