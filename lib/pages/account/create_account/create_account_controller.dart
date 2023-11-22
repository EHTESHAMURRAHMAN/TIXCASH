import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/models.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:tixcash/shared/widgets/sa_alert_dialog.dart';

class CreateAccountController extends GetxController {
  final allCapitals = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final allSmall = "abcdefghijklmnopqrstuvwxyz";

  final TextEditingController controllerNewPass = TextEditingController();
  final TextEditingController controllerConPass = TextEditingController();

  final isNewObscure = true.obs;
  final isConObscure = true.obs;

  final isPasswordValid = 0.obs;
  final isConPasswordValid = 0.obs;

  final isValid = false.obs;
  final isActive = false.obs;

  final isChangePassword = false.obs;
  var arguments = Get.arguments;

  final list = <int, ValidateItem>{
    0: ValidateItem(id: 0, label: '1 uppercase letter'.tr, valid: false.obs),
    1: ValidateItem(id: 1, label: '1 lower letter'.tr, valid: false.obs),
    2: ValidateItem(id: 2, label: '1 number'.tr, valid: false.obs),
    3: ValidateItem(id: 3, label: 'At least 8 characters'.tr, valid: false.obs),
  }.obs;

  @override
  void onInit() {
    super.onInit();
    if (arguments != null) {
      isChangePassword.value = arguments[0]['change'];
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void checkPassword(String val) {
    isPasswordValid.value = controllerNewPass.text.isEmpty
        ? 0
        : controllerNewPass.text.length > 7
            ? 2
            : 1;
    isConPasswordValid.value =
        (controllerNewPass.text.trim() == controllerConPass.text.trim()) &&
                controllerNewPass.text.isNotEmpty
            ? 2
            : 1;
    isValid.value = isPasswordValid.value == 2 &&
        isConPasswordValid.value == 2 &&
        isActive.value;
    validatePassword(controllerNewPass.text.trim());
  }

  void onCreateUser(context) async {
    if (isChangePassword.value) {
      changePassword();
      return;
    }
    EasyLoading.show();
    ApiResponse response = await createWalletAccountAPI({
      'Password': controllerNewPass.text.trim(),
      'Pharseword': '',
      'uid': deviceId ?? ''
    });
    EasyLoading.dismiss();
    if (response.status) {
      UserResponse userResponse = response.data;
      final prefs = Get.find<SharedPreferences>();
      userPassword = controllerNewPass.text;
      String? val = prefs.getString(StorageConstants.userInfo);
      List<UserResponse> users = val != null ? userResponseFromJson(val) : [];
      var mList =
          users.where((element) => element.id == userResponse.id).toList();
      if (mList.isEmpty) {
        users.add(userResponse);
      }
      // prefs.setString(StorageConstants.userInfo, userResponseToJson(userResponse));
      prefs.setString(StorageConstants.userInfo, userResponseToJson(users));
      prefs.setString(StorageConstants.userPassword, userPassword);
      userInfo = response.data;
      Get.toNamed(Routes.BACKUP_WORDS);
      //backupPhrase(context);
    }
  }

  void changePassword() {
    userInfo!.password = controllerNewPass.text.trim();
    userPassword = controllerNewPass.text.trim();
    final prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.userPassword, userPassword);
    EasyLoading.showToast('Password changed successfully');
    Get.offAllNamed(Routes.Dashboard);
  }

  void backupPhrase(context) {
    showDialog(
        context: context,
        builder: (context) => SAAlertDialog(
              title: 'Backup',
              content: 'Do you wish to Backup your wallet now?',
              cancel: 'SKIP',
              confirm: 'BACKUP',
              onConfirm: () {
                Get.toNamed(Routes.BACKUP_WORDS);
              },
              onCancel: () {
                Get.back();
                //Get.offAllNamed(Routes.Dashboard);
              },
            ),
        barrierDismissible: false);
  }

  void validatePassword(text) {
    bool isLen8 = text.length >= 8;
    bool isNumber = RegExp(r"^.*[0-9].*").hasMatch(text);
    bool isCapital = false;
    bool isSmall = false;
    for (int i = 0; i < text.length; i++) {
      if (allCapitals.contains(text[i])) isCapital = true;
      if (allSmall.contains(text[i])) isSmall = true;
    }
    list[0]!.valid.value = isCapital;
    list[1]!.valid.value = isSmall;
    list[2]!.valid.value = isNumber;
    list[3]!.valid.value = isLen8;

    // isCapitalVal.value = isCapital;
    // isNumberVal.value = isNumber;
    // isLen8Val.value = isLen8;
    // isSmallVal.value = isSmall;

    // list.firstWhere((item) => item.id == 3).valid = isLen8;
    // list.firstWhere((item) => item.id == 0).valid = isCapital;
    // list.firstWhere((item) => item.id == 1).valid = isSmall;
    // list.firstWhere((item) => item.id == 2).valid = isNumber;
    // list.value = list;
    isActive.value = isLen8 && isNumber && isCapital && isSmall;
    refresh();
  }
}

class ValidateItem {
  final int id;
  final String label;
  RxBool valid;

  ValidateItem({required this.id, required this.label, required this.valid});
}
