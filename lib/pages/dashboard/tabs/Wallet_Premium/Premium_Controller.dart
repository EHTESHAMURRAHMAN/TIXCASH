import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/common_model.dart';
import 'package:tixcash/models/premium_Model.dart';
import 'package:tixcash/models/subscriptionReponse.dart';

class PremiumController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final totalUSD = 0.0.obs;

  final subscriptionResponse = Rxn<SubscriptionResponse>();
  final issubscriptionResponse = false.obs;
  final isActived = true.obs;
  TextEditingController rcontroller = TextEditingController();
  final isScanEnable = false.obs;
  final isCheckedTerms = false.obs;
  final termsAndConditions = 'Skip Referral Code'.tr;

  @override
  void onInit() {
    super.onInit();
    getsubs();
    getpremiumList();
  }

  Future<void> getcheckreferall() async {
    isActived.value = rcontroller.text.isEmpty;
    return;
  }

  refreshData() {
    Timer(const Duration(milliseconds: 2000), () {
      getsubs();
    });
  }

  final premiumModelResponse = RxList<PremiumModel>();
  final ispremiumModelResponse = false.obs;
  final isBalanceLoading = true.obs;
  final selectPlan = ''.obs;
  final selectCurrencys = ''.obs;
  final selectid = 0.obs;
  // Future<void> getpremiumList() async {
  //   if (userInfo == null) return;
  //   ApiResponse response = await getPremiumAPI();
  //   premiumModelResponse.value = response.data;
  //   ispremiumModelResponse.value = true;
  //   return;
  // }

  Future<void> getpremiumList() async {
    if (userInfo == null) return;
    isBalanceLoading.value = true;
    ApiResponse response = await getPremiumAPI();
    isBalanceLoading.value = false;
    premiumModelResponse.value = response.data;
    ispremiumModelResponse.value = true;

    return;
  }

  File? image;
  Future<void> pickImage() async {
    await Permission.storage.request();
    var status = await Permission.storage.status;

    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    }
  }

  Future<void> getaccess() async {
    Map body = {
      'userid': userInfo!.id,
      "pid": selectid.value,
      "paymentcurrency": selectCurrencys.value.toString(),
      "refrellcode": rcontroller.text,
    };

    print(jsonEncode(body));
    //EasyLoading.show();
    ApiResponse apiResponse = await addpremiumAccessAPI(body);
    //EasyLoading.dismiss();
    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      EasyLoading.showToast(response.message.tr);

      // Get.snackbar(response.status, response.message,
      //     backgroundColor:
      //         response.status == 'succeed' ? Colors.green : Colors.red);
      getsubs();
      Get.back();
    } else {
      Get.snackbar('Error', 'Something went wrong try again',
          backgroundColor: Colors.red);
    }
  }

  Future<void> getsubs() async {
    ApiResponse response = await getSubscriptionAPI();
    if (response.data == '') {
      print(response.message);
    } else {
      subscriptionResponse.value = response.data;
      issubscriptionResponse.value = true;
    }
  }
}
