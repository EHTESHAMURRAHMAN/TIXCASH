import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/StakeDashboardResp.dart';
import 'package:tixcash/pages/Stack/Stack_Controller.dart';

class StackIncomeController extends GetxController {
  StackController stackcontroller = Get.put(StackController());

  final stakeDashboardResponse = Rxn<StakeDashboardResponse>();
  final isstakeDashboardResponse = false.obs;

  @override
  void onInit() {
    super.onInit();
    stakedashboard();
  }

  Future<void> stakedashboard() async {
    ApiResponse response =
        await getstakedashboardAPI(stackcontroller.selectid.value);
    if (response.data == '') {
    } else {
      stakeDashboardResponse.value = response.data;
      isstakeDashboardResponse.value = true;
    }
  }
}
