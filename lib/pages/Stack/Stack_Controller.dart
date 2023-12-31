import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/SponCode.dart';
import 'package:tixcash/models/StakeDashboardResp.dart';
import 'package:tixcash/models/StakeDateRsp.dart';
import 'package:tixcash/models/Stake_List_Resp.dart';
import 'package:tixcash/models/common_model.dart';
import 'package:tixcash/models/stackingList.dart';
import 'package:tixcash/models/stackingListHistory.dart';
import 'package:tixcash/models/whiteList_Resp.dart';
import 'package:tixcash/pages/Stack/Stack_Views.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/routes/app_pages.dart';

class StackController extends GetxController {
  final controller1 = Get.put(HomeController());
  final selectStakeDays = ''.obs;
  final selectid = 0.obs;
  final controllerStakeAmount = TextEditingController();
  final controllerRefral = TextEditingController();
  final isStakeAmountValid = 0.obs;
  final isRefralValid = 0.obs;
  final isActive = false.obs;
  final isActived = false.obs;
  final stakingListModelResponse = RxList<StakingListModel>();
  final isstakingListModelResponse = false.obs;
  final isStakingListLoading = true.obs;
  final ischeckreferall = false.obs;
  final isScanEnable = false.obs;
  final stakingListHistoryModelResponse = RxList<StakingListHistoryModel>();
  final isstakingListHistoryModelResponse = false.obs;
  final isStakingHistoryListLoading = true.obs;
  final stakingHistoryListLoading = true.obs;
  final stakedateResponse = Rxn<StakedateResponse>();
  final isstakedateResponse = false.obs;
  final sponCodeResponse = Rxn<SponCode>();
  final issponCodeResponse = false.obs;
  final whiteListResponse = Rxn<WhiteListResponse>();
  final iswhiteListResponse = false.obs;
  final stakeListModelResponse = RxList<StakeListModel>();
  final isstakeListModellResponse = false.obs;
  final stakeDashboardResponse = Rxn<StakeDashboardResponse>();
  final isstakeDashboardResponse = false.obs;
  final isListLoading = true.obs;
  final userclaim = ''.obs;
  final activeButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    getStakingList();
    getStakingListHistory();
    getstakedate();
    getsponcode();
    getwhiteliststatus();
    getstakingDaylist();
    stakedashboard();
  }

  Future<void> stakedashboard() async {
    ApiResponse response = await getstakedashboardAPI(selectid.value);
    if (response.data == '') {
    } else {
      stakeDashboardResponse.value = response.data;
      isstakeDashboardResponse.value = true;
    }
  }

  void getwhiteliststatus() async {
    ApiResponse response = await getwhiteliststatusAPI();
    whiteListResponse.value = response.data;
    iswhiteListResponse.value = true;
  }

  Future<void> getsponcode() async {
    ApiResponse response = await getsponcodeAPI();
    sponCodeResponse.value = response.data;
    issponCodeResponse.value = true;
  }

  Future<void> getstakedate() async {
    ApiResponse response = await getstakedateAPI(selectid.value);
    if (response.data == '') {
      print(response.message);
    } else {
      stakedateResponse.value = response.data ?? '';
      isstakedateResponse.value = true;
    }
  }

  Future<void> getStakingListHistory() async {
    if (userInfo == null) return;
    stakingHistoryListLoading.value = true;
    ApiResponse response = await getstakingclaimlistAPI();
    isStakingHistoryListLoading.value = false;
    stakingListHistoryModelResponse.value = response.data;
    isstakingListHistoryModelResponse.value = true;
    return;
  }

  Future<void> getstakingDaylist() async {
    if (userInfo == null) return;
    isListLoading.value = true;
    ApiResponse response = await getactivestakinglistAPI();
    isListLoading.value = false;
    stakeListModelResponse.value = response.data;
    isstakeListModellResponse.value = true;
    return;
  }

  Future<void> checkStakeAmount() async {
    isActived.value = controllerStakeAmount.text.isNotEmpty;
    return;
  }

  Future<void> getStakingList() async {
    if (userInfo == null) return;
    isStakingListLoading.value = true;
    ApiResponse response = await getStakingListAPI();
    isStakingListLoading.value = false;
    stakingListModelResponse.value = response.data;
    isstakingListModelResponse.value = true;
    getStakingListHistory();
    return;
  }

  void stake() async {
    if (controllerStakeAmount.text.isEmpty) {
      EasyLoading.showToast('Please Enter Balance'.tr);
      return;
    } else if (selectStakeDays.value.isEmpty) {
      EasyLoading.showToast('Please Select Staking Plan'.tr);
      return;
    } else if (selectid.value == 5) {
    } else if (double.parse(controllerStakeAmount.text.toString()) > 50000) {
      EasyLoading.showToast('Please Enter Balance Less than 50000 TXH'.tr);
      return;
    } else if (double.parse(controllerStakeAmount.text.toString()) < 500) {
      EasyLoading.showToast('Please Enter Balance More than 500 TXH'.tr);
      return;
    }
    Map body = {
      'userid': userInfo!.id,
      "amount": double.parse(controllerStakeAmount.text),
      "staketype": selectid.value,
    };

    print(jsonEncode(body));
    EasyLoading.show();
    ApiResponse apiResponse = await stakpackageAPI(body);
    EasyLoading.dismiss();
    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      EasyLoading.showToast(response.message.tr);
      getStakingList();

      response.message == 'Staking Successfully'
          ? Get.toNamed(Routes.STACKINCOME)
          : Get.back();
      controllerStakeAmount.clear();
      controllerRefral.clear();
    } else {
      Get.snackbar('Error', 'Something went wrong try again',
          backgroundColor: Colors.red);
    }
  }

  void claimStake() async {
    Map body = {"userid": userInfo!.id, "staketype": selectid.value};

    print(jsonEncode(body));
    EasyLoading.show();
    ApiResponse apiResponse = await claimstakingrewardAPI(body);
    EasyLoading.dismiss();
    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      EasyLoading.showToast(response.message.tr);
      getStakingList();
      activeButton.value = true;
      response.message == 'Claim Successfully'.tr
          ? Get.to(stakingIncomeHistory())
          : Get.back();
      controllerStakeAmount.clear();
      controllerRefral.clear();
    } else {
      Get.snackbar('Error', 'Something went wrong try again',
          backgroundColor: Colors.red);
    }
  }
}
