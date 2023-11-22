import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tixcash/api/apis.dart';

class AuthFingerprintController extends GetxController {
  final saveItMessage = 'Save it somewhere safe and secret'.tr;
  ScreenshotController screenshotController = ScreenshotController();

  final isShowBalance = true.obs;
  final privateKey = ''.obs;
  final warningMsg =
      'Never disclose this key. Anyone with your private key can fully control your account, including transferring away any of your fund'
          .tr;

  // final stackIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getPrivateKey();
  }

  Future<void> getPrivateKey() async {
    EasyLoading.show();
    ApiResponse apiResponse = await getPrivateKeyAPI();
    EasyLoading.dismiss();
    if (apiResponse.status) {
      privateKey.value = apiResponse.data['privateKey'];
      //  stackIndex.value = 1;
    } else {
      EasyLoading.showToast(apiResponse.message ?? 'Something went wrong');
    }
  }
}


// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:tixcash/api/apis.dart';
// import 'package:tixcash/app_controller.dart';

// class AuthFingerprintController extends AppController {
//   final saveItMessage = 'Save it somewhere safe and secret';

//   final warningMsg =
//       'Never disclose this key. Anyone with your private key can fully '
//       'control your account, including transferring away any of your fund';

//   final stackIndex = 0.obs;
//   final privateKey = ''.obs;

//   authFingerPrint() {
//     checkFingerPrint((auth) {
//       if (auth) {
//         getPrivateKey();
//       } else {
//         EasyLoading.showToast('Not authorized'.tr);
//       }
//     });
//   }

//   Future<void> getPrivateKey() async {
//     EasyLoading.show();
//     ApiResponse apiResponse = await getPrivateKeyAPI();
//     EasyLoading.dismiss();
//     if (apiResponse.status) {
//       privateKey.value = apiResponse.data['privateKey'];
//       stackIndex.value = 1;
//     } else {
//       EasyLoading.showToast(apiResponse.message ?? 'Something went wrong');
//     }
//   }
// }
