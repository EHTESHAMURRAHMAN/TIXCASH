import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/models.dart';
// import 'package:tixcash/pages/dashboard/home/home_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';

class SelectCoinController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final currencyListResponse = RxList<CurrencyListResponse>();
  final isLoadingDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrencyList();
  }

  void getCurrencyList() async {
    EasyLoading.show();
    ApiResponse response = await getcurrencylistAPI();
    EasyLoading.dismiss();
    currencyListResponse.value = response.data;
    // for (var element in currencyListResponse) {
    //   element.active.value = hasIcon(element);
    // }
  }

  void userUpdateCurrency(currency, active) async {
    Map body = {
      'userid': userInfo!.id,
      'currencysymbol': currency,
      'active': active ? 1 : 0
    };
    print(jsonEncode(body));
    EasyLoading.show();
    ApiResponse response = await userUpdateCurrencyAPI(body);
    EasyLoading.dismiss();
    homeController.getBalanceCurrencyList();
  }

  bool hasIcon(CurrencyListResponse element) {
    var list = homeController.currencyListResponse.where(
        (p0) => p0.currency.toLowerCase() == element.currency.toLowerCase());
    element.active.value = list.isNotEmpty;
    return element.active.value;
  }
}
