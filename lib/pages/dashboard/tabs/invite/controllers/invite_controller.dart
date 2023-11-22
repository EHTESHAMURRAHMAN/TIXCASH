import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/common_model.dart';
import 'package:tixcash/models/directIncome.dart';
import 'package:tixcash/models/referalclaimResp.dart';
import 'package:tixcash/models/refralincome.dart';
import 'package:tixcash/models/usercode.dart';

class InviteController extends GetxController {
  final usercodeResponse = Rxn<UsercodeResponse>();
  final isusercodeResponse = false.obs;
  final shareMessage = "MY referral code is @@  ";

  final referalIncomeModelResponse = RxList<ReferalIncomeModel>();
  ScreenshotController screenshotController = ScreenshotController();
  final isreferalIncomeModelResponse = false.obs;
  final isreferalIncomeLoading = true.obs;
  final directincome = Rxn<DirectincomeModel>();
  final isdirectincome = false.obs;
  final referralClaimlistModelResponse = RxList<ReferralClaimlistModel>();
  final isreferralClaimlistModelResponse = false.obs;
  final isreferralClaimlistLoading = true.obs;
  final referralClaimlistLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    inviteInits();
  }

  void inviteInits() {
    getUserRefral();
    pendingdirectincome();
    getReferalIncomeList();
    getrefrallclaimlist();
  }

  Future<void> getrefrallclaimlist() async {
    if (userInfo == null) return;
    referralClaimlistLoading.value = true;
    ApiResponse response = await getrefrallclaimlistAPI();
    isreferralClaimlistLoading.value = false;
    referralClaimlistModelResponse.value = response.data;
    isreferralClaimlistModelResponse.value = true;

    return;
  }

  Future<void> pendingdirectincome() async {
    ApiResponse response = await pendingdirectincomeAPI();
    directincome.value = response.data;
    isdirectincome.value = true;
  }

//ReferralClaimlistModel
  Future<void> getReferalIncomeList() async {
    if (userInfo == null) return;
    isreferalIncomeLoading.value = true;
    ApiResponse response = await getReferalIncomeListAPI();
    isreferalIncomeLoading.value = false;
    referalIncomeModelResponse.value = response.data;
    isreferalIncomeModelResponse.value = true;

    return;
  }

  Future<void> getUserRefral() async {
    ApiResponse response = await getusercodeAPI();
    usercodeResponse.value = response.data;
    //isusercodeResponse.value = true;
  }

  void claimdirectreward() async {
    Map body = {
      "userid": userInfo!.id,
      "amount": directincome.value?.claimamount
    };

    print(jsonEncode(body));
    EasyLoading.show();
    ApiResponse apiResponse = await claimdirectrewardAPI(body);
    EasyLoading.dismiss();
    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      EasyLoading.showToast(response.message);

      getrefrallclaimlist();
      Get.back();
    } else {
      Get.snackbar('Error', 'Something went wrong try again',
          backgroundColor: Colors.red);
    }
  }
}
