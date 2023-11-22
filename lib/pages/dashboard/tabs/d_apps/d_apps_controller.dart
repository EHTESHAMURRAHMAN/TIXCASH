import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/subscriptionReponse.dart';
import 'package:tixcash/pages/dashboard/dashboard_file/dashboard_controller.dart';
import 'package:tixcash/shared/constants/storage.dart';

class DAppsController extends GetxController {
  final DashboardController dashboardController =
      Get.isRegistered() ? Get.find() : Get.put(DashboardController());

  final historyList = RxList<String>();
  final isSearch = false.obs;

  final searchController = TextEditingController();
  final delay = 0.0.obs;
  FocusNode mFocus = FocusNode();

  final issubscriptionResponse = false;

  final lastUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    lastOPen();
  }

  Future<String> lastOPen() async {
    final prefs = Get.find<SharedPreferences>();
    lastUrl.value = prefs.getString(StorageConstants.lastOPen) ?? '';
    return lastUrl.value;
  }

  saveLastOpen(String url) {
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.lastOPen, url);
    lastUrl.value = url;
  }

  getHistoryList(String url) {
    if (url.isEmpty) {
      historyList.value = [];
      return;
    }
    final prefs = Get.find<SharedPreferences>();
    List<String> list = prefs.getStringList(StorageConstants.historyList) ?? [];
    List<String> listTemp = list
        .where((element) =>
            Uri.parse(element.toLowerCase()).host.contains(url.toLowerCase()))
        .toList();
    historyList.value = List.from(listTemp);
  }
}
