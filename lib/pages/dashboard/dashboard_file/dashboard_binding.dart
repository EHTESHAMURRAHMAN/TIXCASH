import 'package:get/get.dart';
import 'package:tixcash/pages/dashboard/dashboard_file/dashboard_controller.dart';
import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/d_apps/d_apps_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/settings_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.put(HomeController(), permanent: true);
    Get.put(ScanQrController(), permanent: true);
    Get.put(SendTyvController(), permanent: true);
    // Get.put(SwapController(), permanent: true);
    Get.put(DAppsController(), permanent: true);
    Get.put(SettingsController(), permanent: true);
    //Get.put(SendTyvController(),permanent: true);
  }
}

class SendBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
