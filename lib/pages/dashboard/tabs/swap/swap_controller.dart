import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/common_model.dart';
import 'package:tixcash/models/currency_rate.dart';
import 'package:tixcash/models/swap_currencies.dart';

class SwapController extends GetxController {
  // final fromCurrency = SwapCurrency(currency: 'LINE', icon: 'line@2x.png').obs;
  // final toCurrency   = SwapCurrency(currency: 'TRX', icon: 'trx@2x.png').obs;

  final fromCurrency = Rxn<SwapCurrency>();
  final toCurrency = Rxn<SwapCurrency>();
  final selectcurrency = 'TXH'.obs;

  final currencyRate = Rxn<CurrencyRate>();
  final fromController = TextEditingController(text: '0.0');
  final toController = TextEditingController(text: '0.0');

  final fromBalanceTotal = 0.0.obs;
  final fromBalanceUSD = 0.0.obs;
  final toBalanceTotal = 0.0.obs;
  final toBalanceUSD = 0.0.obs;

  final isBalanceLoading = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    getSwapCurrencyList(isToList: true);
    getSwapCurrencyList(isToList: false);
    getCurrencyPairPrice();
  }

  void getCurrencyPairPrice() async {
    try {
      EasyLoading.show();
      ApiResponse response = await getCurrencyPairPriceAPI(
          from: fromCurrency.value?.currency ?? 'Line',
          to: toCurrency.value?.currency ?? 'Line');
      EasyLoading.dismiss();
      currencyRate.value = response.data;
      toController.text =
          '${double.parse(fromController.text) / (currencyRate.value?.price ?? 1.0)}';
    } catch (e) {
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(e);
      }
    }

    await userFundBalance(
        isTo: false, currency: fromCurrency.value?.currency ?? 'LINE');
    await userFundBalance(
        isTo: true, currency: toCurrency.value?.currency ?? 'LINE');
    EasyLoading.dismiss();
  }

  Future<void> userFundBalance({isTo = false, currency = 'USDT-TRC20'}) async {
    if (userInfo == null) return;
    ApiResponse response = await userFundbalanceAPI(userInfo!.id, currency);
    if (response.status) {
      if (!isTo) {
        fromBalanceTotal.value = double.parse(response.data['totalAmount']);
        fromBalanceUSD.value = double.parse(response.data['usdAmount']);
      } else {
        toBalanceTotal.value = double.parse(response.data['totalAmount']);
        toBalanceUSD.value = double.parse(response.data['usdAmount']);
      }
    }
  }

  void fundTransferAccount() async {
    if (fromController.text.isEmpty || double.parse(fromController.text) <= 0) {
      Get.snackbar('Empty', 'Enter amount',
          backgroundColor: Colors.yellow[800],
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Map body = {
      'userid': userInfo!.id,
      'fromcurrency': fromCurrency.value?.currency ?? 'LINE',
      'tocurrency': toCurrency.value?.currency ?? 'LINE',
      'amount': double.parse(fromController.text)
    };
    EasyLoading.show();
    ApiResponse response = await fundTransferAccountAPI(body);
    EasyLoading.dismiss();
    if (response.status) {
      CommonResponse data = response.data;
      Get.snackbar('Success', data.message,
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      fromController.text = '';
      toController.text = '';
    } else {
      Get.snackbar('Failed', '${response.data['message']}',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
    // userFundBalance(isTo: false, currency: fromCurrency.value.currency);
    // userFundBalance(isTo: true, currency: toCurrency.value.currency);
    _checkFund();
  }

  _checkFund() async {
    double tempBalance = fromBalanceTotal.value;
    isBalanceLoading.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (tempBalance == fromBalanceTotal.value) {
        userFundBalance(
            isTo: false, currency: fromCurrency.value?.currency ?? 'LINE');
        userFundBalance(
            isTo: true, currency: toCurrency.value?.currency ?? 'LINE');
      } else {
        isBalanceLoading.value = false;
        _timer?.cancel();
      }
    });
  }

  void getSwapCurrencyList({isToList = false}) async {
    EasyLoading.show();
    ApiResponse response = await getCurrencyListAPI(isToList: isToList);
    EasyLoading.dismiss();
    if (response.data.isNotEmpty) {
      if (isToList) {
        toCurrency.value = response.data.last;
      } else {
        fromCurrency.value = response.data.last;
      }
    }
  }
}
