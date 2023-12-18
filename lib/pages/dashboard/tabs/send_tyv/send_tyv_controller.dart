import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/models.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';

class SendTyvController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final HomeController homecontroller = Get.find<HomeController>();

  // final ScanController controllerScan = ScanController();

  String qrcode = 'Unknown';

  final TextEditingController controllerReceiver = TextEditingController();
  final TextEditingController controllerAmount = TextEditingController();
  final currencyResponse = Rxn<CurrencyResponse>();

  final isInputValid = false.obs;
  var arguments = Get.arguments;
  final sendOption = true.obs;

  final isSendToWallet = true.obs;
  final isScanEnable = false.obs;

  final commissionAmount = 0.3.obs;
  final mCurrency = 'TXH'.obs;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // final sController = Rxn<QRViewController>();

  final fundBalance = 0.0.obs;
  final fundBalanceUSDT = 0.0.obs;
  final isLoadingBalance = true.obs;
  final sum = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (arguments != null) currencyResponse.value = arguments[0]['currency'];
    refreshData();
    isSendToWallet.value = false;
    sendOption.value = false;
    getCommissionAmount(0);

    // sController.listen((p0) {
    //   if (Platform.isAndroid) {
    //     sController.value!.pauseCamera();
    //   } else if (Platform.isIOS) {
    //     sController.value!.resumeCamera();
    //   }
    // });
    getUserFundBalance();
  }

  @override
  void onReady() {
    super.onReady();
    refreshData();
  }

  void refreshData() {
    try {
      currencyResponse.value ??=
          homecontroller.currencyListResponse.elementAt(0);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    getCommissionAmount(0);

    // if(arguments!=null){
    //   currencyResponse.value = arguments[0]['currency'];
    // }else{
    //   currencyResponse.value = homeController.currencyListResponse.elementAt(0);
    // }
  }

  void checkIsValid() {
    isInputValid.value =
        controllerAmount.text.isNotEmpty && controllerReceiver.text.length > 10;
  }

  void maxValueCalculate() {
    final val1 = int.parse(controllerAmount.text);
    final val2 = commissionAmount.value;
    final sum = val1 + val2;
    print(sum);
  }

  void fundTransferAccount() async {
    EasyLoading.show();
    ApiResponse? response;
    if (isSendToWallet.value) {
      Map body = {
        'userid': userInfo!.id,
        'Toaddress': controllerReceiver.text.trim(),
        //     'currency': 'TXH',
        'currency': currencyResponse.value?.currency ?? 'TXH',
        'amount': double.parse(controllerAmount.text.trim())
      };
      response = await fundTransferaccountAPI(body);
    } else {
      Map body = {
        'userid': userInfo!.id,
        'address': controllerReceiver.text.trim(),
        'currency': currencyResponse.value?.currency ?? 'TXH',
        'amount': double.parse(controllerAmount.text.trim())
      };

      response = await fundWithdrwaluserAPI(body);
    }

    EasyLoading.dismiss();
    if (response.status) {
      CommonResponse res = response.data;
      EasyLoading.showToast(res.message.tr);
      double amount = double.parse(controllerAmount.text.trim());
      controllerReceiver.text = '';
      controllerAmount.text = '';
      Get.back(result: {'amount': amount});
      appController.userFundBalance(
        currency: currencyResponse.value?.currency ?? 'TXH',
      );
    } else {
      Get.snackbar('Error', 'Something went wrong try again',
          backgroundColor: Colors.red);
    }
  }

  void getCommissionAmount(amount) {
    isSendToWallet.value
        ? userInternalCommission(amount)
        : userExternalCommission(amount);
  }

  void userInternalCommission(amount) async {
    // ApiResponse response = await userInternalCommissionAPI(amount);
    ApiResponse response = await userInternalCommissionAPI(
        currencyResponse.value?.currency ?? 'TXH');
    if (response.status) {
      // commissionAmount.value = double.parse(response.data['commissionAmt']);
      commissionAmount.value = double.parse('${response.data['fee']}');
      mCurrency.value = response.data['currency'];
    }
  }

  void userExternalCommission(amount) async {
    // ApiResponse response = await userExternalCommissionAPI(amount);
    ApiResponse response = await userExternalCommissionAPI(
        currencyResponse.value?.currency ?? 'TXH');
    if (response.status) {
      // commissionAmount.value = double.parse(response.data['commissionAmt']);
      commissionAmount.value = double.parse('${response.data['fee']}');
      mCurrency.value = response.data['currency'];
    }
  }

  void getUserFundBalance() async {
    isLoadingBalance.value = true;
    ApiResponse apiResponse = await userFundbalanceAPI(
        userInfo!.id, currencyResponse.value?.currency ?? 'TXH');
    isLoadingBalance.value = false;
    if (apiResponse.status) {
      fundBalance.value = double.parse(apiResponse.data['totalAmount']);
      fundBalanceUSDT.value = double.parse(apiResponse.data['usdAmount']);
    }
  }
}
