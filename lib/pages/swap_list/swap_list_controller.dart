import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/swap_currencies.dart';

class SwapListController extends GetxController {
  final swapCurrencyList = RxList<SwapCurrency>();
  var arguments = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    if (arguments != null) {
      getSwapCurrencyList(isToList: arguments[0]['isToList']);
    }
  }

  void getSwapCurrencyList({isToList = false}) async {
    EasyLoading.show();
    ApiResponse response = await getCurrencyListAPI(isToList: isToList);
    EasyLoading.dismiss();
    swapCurrencyList.value = response.data;
  }
}
