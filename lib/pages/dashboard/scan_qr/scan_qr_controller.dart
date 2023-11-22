import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/models.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';

class ScanQrController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final HomeController homeController = Get.find<HomeController>();

  final TextEditingController controllerHash = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController tfController = TextEditingController();

  final address = ''.obs;
  final isTransferFromExchange = false.obs;

  // final currencyResponse = Rxn<CurrencyResponse>();
  // var arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    address.value = userInfo!.address;
  }

  final count = 0.obs;
  increment() => count.value++;

  void getAddressId(addressType) async {
    EasyLoading.show();
    ApiResponse response = await getAddressIdAPI(addressType);
    EasyLoading.dismiss();
    if (response.status) {
      address.value = response.data['address'];
    }
  }

  void depositFund() async {
    if (controllerHash.text.trim().length < 10) {
      EasyLoading.showToast('Enter valid hash code');
      return;
    }
    Map body = {'userid': userInfo!.id, 'txthash': controllerHash.text.trim()};
    EasyLoading.show();
    ApiResponse response = await depositFundAPI(body);
    // EasyLoading.dismiss();

    if (response.status) {
      appController.userFundBalance(currency: 'TXH');
      Get.back();
      CommonResponse data = response.data;
      EasyLoading.showToast(data.message);
    } else {
      EasyLoading.showToast(
          response.data['message'] ?? 'Something went wrong try again');
    }
  }

  void refreshData() {
    // if(arguments!=null){
    //   currencyResponse.value = arguments[0]['currency'];
    // }else{
    //   currencyResponse.value = homeController.currencyListResponse.elementAt(0);//arguments[0]['currency'];
    // }
    // currencyResponse.value = homeController.currencyListResponse.elementAt(0);//arguments[0]['currency'];
  }
}
