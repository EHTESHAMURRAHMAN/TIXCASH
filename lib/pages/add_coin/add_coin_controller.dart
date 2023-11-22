import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/common_model.dart';
import 'package:tixcash/models/network_list_response.dart';
import 'package:tixcash/models/token_detail.dart';

class AddCoinController extends GetxController {
  final contractController = TextEditingController();
  final nameController = TextEditingController();
  final symbolController = TextEditingController();
  final decimalController = TextEditingController();

  final network = 'Tron'.obs;
  final isInputValid = false.obs;
  final isScanEnable = false.obs;

  final networkList = RxList<NetworkListResponse>();
  final tokenDetail = Rxn<TokenDetail>();
  @override
  void onInit() {
    super.onInit();
    getNetwork();
    contractController.text = '';
    nameController.text = '';
    symbolController.text = '';
    decimalController.text = '';
  }

  void checkIsValid() {
    // isInputValid.value = controllerAmount.text.isNotEmpty&&controllerReceiver.text.length>10;
  }

  Future<void> getNetwork() async {
    EasyLoading.show();
    ApiResponse apiResponse = await getNetworkAPI();
    EasyLoading.dismiss();
    if (apiResponse.status) {
      networkList.value = apiResponse.data;
      network.value = networkList.single.network;
    } else {}
  }

  Future<void> addCurrency() async {
    if (contractController.text.length < 10) {
      Get.snackbar('Empty Box', 'Enter Address', backgroundColor: Colors.amber);
      return;
    }

    if (contractController.text.startsWith('0x') &&
        contractController.text.length >= 40) {
    } else {
      EasyLoading.showToast('Invalid address');
      Get.snackbar('Invalid address', 'Invalid address',
          backgroundColor: Colors.red);
      return;
    }

    if (nameController.text.isEmpty) {
      Get.snackbar('Empty Name', 'Enter Token Name',
          backgroundColor: Colors.amber);
      return;
    }

    if (symbolController.text.isEmpty) {
      Get.snackbar('Empty Symbol', 'Enter Symbol',
          backgroundColor: Colors.amber);
      return;
    }

    if (decimalController.text.isEmpty) {
      Get.snackbar('Empty Decimal', 'Enter Decimal',
          backgroundColor: Colors.amber);
      return;
    }

    Map body = {
      'userid': userInfo!.id,
      'currencyname': nameController.text,
      'currencysymbol': symbolController.text,
      'contractaddress': contractController.text,
      'decimals': int.parse(decimalController.text),
      'network': network.value
    };

    print(jsonEncode(body));
    EasyLoading.show();
    ApiResponse apiResponse = await addCurrencyAPI(body);
    EasyLoading.dismiss();
    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      Get.snackbar(response.status, response.message,
          backgroundColor:
              response.status == 'succeed' ? Colors.green : Colors.red);
      // Get.back();
      if (response.status == 'succeed') {
        nameController.text = '';
        symbolController.text = '';
        decimalController.text = '';
        contractController.text = '';
      }
    } else {
      Get.snackbar('Error', 'Something went wrong try again',
          backgroundColor: Colors.red);
    }
  }

  Future<void> getTokenDetailByContract(address) async {
    ApiResponse apiResponse = await getTokenDetailByContractAPI(address);
    if (apiResponse.status) {
      tokenDetail.value = apiResponse.data;

      nameController.text = tokenDetail.value?.currencyname ?? '';
      symbolController.text = tokenDetail.value?.currencysymbol ?? '';
      decimalController.text = '${tokenDetail.value?.decimals ?? ''}';
    }
  }
}
