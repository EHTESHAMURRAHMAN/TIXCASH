import 'package:get/get.dart';
import 'package:tixcash/pages/dashboard/tabs/Wallet_Premium/Premium_Controller.dart';

class PremiumBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PremiumController>(PremiumController());
  }
}
