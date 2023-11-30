import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/models.dart';
import 'package:intl/intl.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';

class TransactionHistoryController extends GetxController {
  final AppController appController = Get.find<AppController>();
  HomeController homecontroller = Get.put(HomeController());
  final currencyResponse = Rxn<CurrencyResponse>();
  var arguments = Get.arguments;

  final transactionListResponse = RxList<TransactionListResponse>();
  final transactionListResponseSearch = RxList<TransactionListResponse>();
  final isTransLoaded = false.obs;

  final fundBalance = 0.0.obs;
  final fundBalanceUSDT = 0.0.obs;
  final isBalanceLoading = true.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    initValue();
    if (kDebugMode) {
      print(currencyResponse.value!.currency);
    }
    getUserFundBalance().then((value) => isBalanceLoading.value = false);
    getTransactionList();
  }

  @override
  void onReady() {
    super.onReady();
    initValue();
  }

  initValue() {
    currencyResponse.value = arguments[0]['currency'];
    if (kDebugMode) {
      print('response => ${currencyResponse.value?.currency}');
    }
  }

  void getTransactionList() async {
    ApiResponse response =
        await getTransactionListAPI(currencyResponse.value!.currency);
    transactionListResponse.value = response.data;
    transactionListResponse.sort((a, b) =>
        formatDate(b.transactionDate).compareTo(formatDate(a.transactionDate)));
    transactionListResponseSearch.value = response.data;
    isTransLoaded.value = true;
  }

  Future<void> getUserFundBalance() async {
    // isBalanceLoading.value = true;
    ApiResponse apiResponse = await userFundbalanceAPI(
        userInfo!.id, currencyResponse.value?.currency ?? 'LINE');
    if (apiResponse.status) {
      fundBalance.value = double.parse(apiResponse.data['totalAmount']);
      fundBalanceUSDT.value = double.parse(apiResponse.data['usdAmount']);
    }
  }

  checkFund() async {
    double tempBalance = fundBalance.value;
    isBalanceLoading.value = true;
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (tempBalance == fundBalance.value) {
        getUserFundBalance();
      } else {
        isBalanceLoading.value = false;
        _timer?.cancel();
      }
    });
  }

  DateTime formatDate(String date) {
    // DateTime time = DateTime.fromMillisecondsSinceEpoch(date is int?date:int.parse(date));
    DateTime time = DateFormat('MM/dd/yyyy hh:mm:ss').parse(date);
    return time;
  }
}
