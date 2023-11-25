import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/pages/account/backup_words/backup_words_view.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';

class BackupWordsController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final TextEditingController controllerRandom = TextEditingController();

  // final String recoveryMessage = 'recoveryMessage'.tr;
  // final String recoveryMessage =
  //     'Your recovery phrase consist of 24 words. It is used to restore your wallet or funds in the event you loss your device or forget your password'
  //         .tr;
  final String recoveryMessage =
      'Your recovery phrase consist of 24 words. It is used to restore your wallet'
          .tr;

  final String veryfyPhrase = ''.tr;

  final list_1_4 = ['gas', 'situate', 'harsh', 'decorate'].obs;
  final list_5_8 = ['gas', 'situate', 'harsh', 'decorate'].obs;
  final list_9_12 = ['gas', 'situate', 'harsh', 'decorate'].obs;
  final list_13_16 = ['gas', 'situate', 'harsh', 'decorate'].obs;
  final list_17_20 = ['gas', 'situate', 'harsh', 'decorate'].obs;
  final list_21_24 = ['gas', 'situate', 'harsh', 'decorate'].obs;

  final phraseList = <String>[].obs;
  final isActive = false.obs;
  final list_labels = [
    '1_4'.tr,
    '5_8'.tr,
    '9_12'.tr,
    '13_16'.tr,
    '17_20'.tr,
    '21_24'.tr,
    'Confirm'.tr
  ];

  final PageController pageController = PageController();
  final currentPage = 0.obs;
  final searchList = RxList<String>();
  final searchWord = ''.obs;

  final randomNumber = 0.obs;
  final randomCount = 0.obs;
  final randomWord = ''.obs;
  final viewIndex = 0.obs;
  final selectedEdit = 10001.obs;

  @override
  void onInit() {
    super.onInit();
    appController.backupPharse();
  }

  @override
  void onReady() {
    super.onReady();
    words.shuffle();
    list_1_4.value = words.sublist(0, 4);
    list_5_8.value = words.sublist(5, 9);
    list_9_12.value = words.sublist(10, 14);
    list_13_16.value = words.sublist(15, 19);
    list_17_20.value = words.sublist(20, 24);
    list_21_24.value = words.sublist(25, 29);

    phraseList.value = [
      ...list_1_4,
      ...list_5_8,
      ...list_9_12,
      ...list_13_16,
      ...list_17_20,
      ...list_21_24
    ];

    for (int i = 0; i < 24; i++) {
      printInfo(info: '$i - ${words.elementAt(i)}');
    }
    randomNumber.listen((rad) {
      randomWord.value = words.elementAt(rad);
      printInfo(info: randomWord.value);
    });
  }

  void validate({isImportWallet = false}) async {
    String phrase = '';
    for (var element in phraseList) {
      phrase += element.toLowerCase();
    }
    phrase = phrase.substring(0, phrase.lastIndexOf(''));
    printInfo(info: phrase);

    // ApiResponse response = await restoreAccountAPI(phrase);
    // if (response.status) {
    //   //userInfo = response.data;

    //   final prefs = Get.find<SharedPreferences>();
    //   // prefs.setString(StorageConstants.phrase, phrase);
    //   prefs.setString('${userInfo!.id}', phrase);
    //   prefs.setBool(StorageConstants.backup, true);
    //   appController.isBackup.value = true;

    //   if (isImportWallet) {
    //     Get.offAllNamed(Routes.Dashboard);
    //     HomeController().getsubs();
    //   } else {
    //     Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
    //       {'change': true}
    //     ]);
    //     //?.then((value) => Get.offAllNamed(Routes.Dashboard));
    //   }
    // } else {
    //   EasyLoading.showToast('${response.message}');
    // }
  }

  void createBackup() async {
    // if (kDebugMode) {
    //   print('${randomWord.value}${controllerRandom.text.trim()}');
    // }

    var search = phraseList
        .where((p) => p.toLowerCase().contains(randomWord.value.toLowerCase()))
        .toList();
    if (search.isNotEmpty) {
      // if(randomWord.value.toLowerCase()==phraseList[randomNumber.value].toLowerCase()){
      // if (randomCount.value == 0) {
      //   randomCount.value += 1;
      //   int rad = Random().nextInt(24);
      //   randomNumber.value = rad;
      //   randomWord.value = phraseList.elementAt(rad);
      //   controllerRandom.text = '';
      //   randomWord.value = '';
      //   return;
      // }
      printInfo(info: phraseList.toString());
      String phrase = '';
      for (var element in phraseList) {
        phrase += '${element.toLowerCase()} ';
      }
      //phrase = phrase.substring(0, phrase.lastIndexOf(""));
      printInfo(info: phrase);

      Map body = {'id': userInfo!.id, 'Pharseword': phrase};

      ApiResponse response = await updateBackupPharseAPI(body);
      if (response.status) {
        final prefs = Get.find<SharedPreferences>();
        // prefs.setString(StorageConstants.phrase, phrase);
        prefs.setString('${userInfo!.id}', phrase);
        prefs.setBool(StorageConstants.backup, true);
        appController.isBackup.value = true;
        appController.backupPharse();
        Get.to(Verify());
      } else {
        EasyLoading.showToast(response.data['message']);
      }
    } else {
      EasyLoading.showToast('Wrong word'.tr);
    }
  }

  void verify() async {
    String phrase = '';
    for (var element in phraseList) {
      phrase += '${element.toLowerCase()} ';
    }
    //  phrase = phrase.substring(0, phrase.lastIndexOf(','));
    printInfo(info: phrase);

    if (phrase == appController.backupPResponse.value?.backuphrase) {
      Get.offAllNamed(Routes.Dashboard);
    } else {
      EasyLoading.showToast('Wrong Phrase Key');
    }
  }

  void createBackup1() async {
    // if (kDebugMode) {
    //   print('${randomWord.value}${controllerRandom.text.trim()}');
    // }

    var search = phraseList
        .where((p) => p.toLowerCase().contains(randomWord.value.toLowerCase()))
        .toList();
    if (search.isNotEmpty) {
      // if(randomWord.value.toLowerCase()==phraseList[randomNumber.value].toLowerCase()){
      // if (randomCount.value == 0) {
      //   randomCount.value += 1;
      //   int rad = Random().nextInt(24);
      //   randomNumber.value = rad;
      //   randomWord.value = phraseList.elementAt(rad);
      //   controllerRandom.text = '';
      //   randomWord.value = '';
      //   return;
      // }
      printInfo(info: phraseList.toString());
      String phrase = '';
      for (var element in phraseList) {
        phrase += '${element.toLowerCase()} ';
      }
      //phrase = phrase.substring(0, phrase.lastIndexOf(""));
      printInfo(info: phrase);

      Map body = {'id': userInfo!.id, 'Pharseword': phrase};

      ApiResponse response = await updateBackupPharseAPI(body);
      if (response.status) {
        final prefs = Get.find<SharedPreferences>();
        // prefs.setString(StorageConstants.phrase, phrase);
        prefs.setString('${userInfo!.id}', phrase);
        prefs.setBool(StorageConstants.backup, true);
        appController.isBackup.value = true;
        appController.backupPharse();
        Get.offAllNamed(Routes.Dashboard);
      } else {
        EasyLoading.showToast(response.data['message']);
      }
    } else {
      EasyLoading.showToast('Wrong word'.tr);
    }
  }

  void searchWords(String word) {
    searchList.value = words
        .where((element) => element.toLowerCase().contains(word.toLowerCase()))
        .toList();
  }
}


/*import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';

class BackupWordsController extends GetxController {
  final AppController appController = Get.find<AppController>();

  // final String recoveryMessage = 'recoveryMessage'.tr;
  final String recoveryMessage =
      'Your recovery phrase consist of 12 words. It is used to restore your wallet or funds in the event you loss your device or forget your password'
          .tr;

  final String veryfyPhrase = 'veryfyPhrase'.tr;

  final list_1_4 = ['gas', 'situate', 'harsh', 'decorate'].obs;
  final list_5_8 = ['gas', 'situate', 'harsh', 'decorate'].obs;
  final list_9_12 = ['gas', 'situate', 'harsh', 'decorate'].obs;

  final phraseList = <String>[].obs;

  final list_labels = ['1_4'.tr, '5_8'.tr, '9_12'.tr, 'Confirm'.tr];

  final PageController pageController = PageController();
  final currentPage = 0.obs;
  final searchList = RxList<String>();
  final searchWord = ''.obs;

  final randomNumber = 0.obs;
  final randomCount = 0.obs;
  final randomWord = ''.obs;
  final viewIndex = 0.obs;
  final TextEditingController controllerRandom = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    words.shuffle();
    list_1_4.value = words.sublist(0, 4);
    list_5_8.value = words.sublist(5, 9);
    list_9_12.value = words.sublist(10, 14);

    phraseList.value = [...list_1_4, ...list_5_8, ...list_9_12];

    for (int i = 0; i < 12; i++) {
      printInfo(info: '$i - ${words.elementAt(i)}');
    }
    randomNumber.listen((rad) {
      randomWord.value = words.elementAt(rad);
      printInfo(info: randomWord.value);
    });
  }

  void createBackup() async {
    if (kDebugMode) {
      print('${randomWord.value}${controllerRandom.text.trim()}');
    }

    var search = phraseList
        .where((p) => p.toLowerCase().contains(randomWord.value.toLowerCase()))
        .toList();
    if (search.isNotEmpty) {
      // if(randomWord.value.toLowerCase()==phraseList[randomNumber.value].toLowerCase()){
      if (randomCount.value == 0) {
        randomCount.value += 1;
        int rad = Random().nextInt(12);
        randomNumber.value = rad;
        randomWord.value = phraseList.elementAt(rad);
        controllerRandom.text = '';
        randomWord.value = '';
        return;
      }
      printInfo(info: phraseList.toString());
      String phrase = '';
      for (var element in phraseList) {
        phrase += '${element.toLowerCase()},';
      }
      phrase = phrase.substring(0, phrase.lastIndexOf(','));
      printInfo(info: phrase);

      Map body = {'id': userInfo!.id, 'Pharseword': phrase};

      ApiResponse response = await updateBackupPharseAPI(body);
      if (response.status) {
        final prefs = Get.find<SharedPreferences>();
        // prefs.setString(StorageConstants.phrase, phrase);
        prefs.setString('${userInfo!.id}', phrase);
        prefs.setBool(StorageConstants.backup, true);
        appController.isBackup.value = true;
        Get.offAllNamed(Routes.Dashboard);
      } else {
        EasyLoading.showToast(response.data['message']);
      }
    } else {
      EasyLoading.showToast('Wrong word'.tr);
    }
  }

  void searchWords(String word) {
    searchList.value = words
        .where((element) => element.toLowerCase().contains(word.toLowerCase()))
        .toList();
  }
}
*/