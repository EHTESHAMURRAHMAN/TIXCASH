import 'package:get/get.dart';
import 'package:tixcash/pages/dashboard/dashboard_file/dashboard_controller.dart';
import 'app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<AppController>(AppController(), permanent: true);
    Get.put<DashboardController>(DashboardController(), permanent: true);
  }
}
