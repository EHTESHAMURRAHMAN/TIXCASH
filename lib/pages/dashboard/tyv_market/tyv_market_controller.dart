import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/models.dart';

class TyvMarketController extends GetxController {
  final marketResponse = RxList<MarketResponse>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    marketListuser();
  }

  Future<void> marketListuser() async {
    EasyLoading.show();
    ApiResponse response = await marketListuserAPI();
    EasyLoading.dismiss();
    marketResponse.value = response.data;
    return;
  }
}
