import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/LevelitemModel.dart';

class MyReferralController extends GetxController {
  final levelitemModelResponse = RxList<LevelitemModel>();
  final islevelitemModelResponse = false.obs;
  final isBalanceLoading = true.obs;
  final levelTeam = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getlevelItemList(levelTeam.value);
  }

  Future<void> getlevelItemList(level) async {
    if (userInfo == null) return;
    isBalanceLoading.value = true;
    ApiResponse response = await getLevelItemAPI(levelTeam.value);
    isBalanceLoading.value = false;
    levelitemModelResponse.value = response.data;
    islevelitemModelResponse.value = true;
    return;
  }
}
