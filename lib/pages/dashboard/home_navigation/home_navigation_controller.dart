import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:collection/collection.dart';

import '../../../api/apis.dart';

class HomeNavigationController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final currentSelected = HomeIndex.myWallet.obs;
  final advancedDrawerController = AdvancedDrawerController();
  final title = 'My Wallet'.obs;
  final actions = RxList<Widget>();
  int counter = 0;
  static RxBool onAuthPop = false.obs;

  @override
  void onInit() {
    super.onInit();
    actions.value = actionWallet;
    onAuthPop.listen((val) {
      appController.validateLogin(SizeConfig().buildContext, () {
        showPhrase(SizeConfig().buildContext);
      });
    });
  }

  void navigateToScreen(val) {
    currentSelected.value = val;
    advancedDrawerController.value = AdvancedDrawerValue.hidden();
    switch (val) {
      case HomeIndex.myWallet:
        title.value = 'My Wallet'.tr;
        actions.value = actionWallet;
        Get.offAndToNamed(Routes.Dashboard);
        break;
      case HomeIndex.scanQr:
        title.value = 'RECEIVE LINE'.tr;
        actions.value = [];
        Get.offAndToNamed(Routes.SCAN_QR);
        break;

      case HomeIndex.tyvScan:
        // title.value = 'Transfers'.tr;
        title.value = 'LINE Scan'.tr;
        actions.value = actionTYVScan;
        Get.offAndToNamed(Routes.TYV_SCAN);
        break;

      case HomeIndex.tyvMarket:
        title.value = 'LINE Market'.tr;
        actions.value = [];
        Get.offAndToNamed(Routes.TYV_MARKET);
        break;

      case HomeIndex.contactSupport:
        title.value = 'Contact Support'.tr;
        actions.value = [];
        Get.offAndToNamed(Routes.CONTACT_SUPPORT);
        break;

      case HomeIndex.settings:
        title.value = 'SETTINGS'.tr;
        actions.value = [];
        Get.offAndToNamed(Routes.SETTINGS);
        break;

      case HomeIndex.commissionFee:
        title.value = 'Commission Fee'.tr;
        actions.value = [];
        Get.offAndToNamed(Routes.COMMISSION_FEE);
        break;

      case HomeIndex.addStores:
        title.value = 'Add Store'.tr;
        actions.value = [];
        Get.offAndToNamed(Routes.ADD_STORE);
        break;

      case HomeIndex.notification:
        title.value = 'Add Notification'.tr;
        actions.value = [];
        Get.offAndToNamed(Routes.ADD_NOTIFICATION);
        break;

      default:
        title.value = 'My Wallet'.tr;
        actions.value = actionWallet;
        Get.offAndToNamed(Routes.Dashboard);
    }
  }

  final actionWallet = [
    IconButton(
        onPressed: () {
          Get.toNamed(Routes.SELECT_COIN);
        },
        icon: const Icon(Ionicons.add)),
    PopupMenuButton(
        icon: const Icon(Ionicons.ellipsis_vertical),
        itemBuilder: (context) {
          return <PopupMenuItem<String>>[
            PopupMenuItem<String>(
                value: 'backupWallet', child: Text('Backup Wallet'.tr)),
            PopupMenuItem<String>(
                value: 'rateWallet', child: Text('Rate TIXCASH WALLET'.tr)),
          ];
        },
        onSelected: (String val) {
          if (val == 'backupWallet') {
            onAuthPop.value = !onAuthPop.value;
          }
        })
  ];

  final actionTYVScan = [
    PopupMenuButton(
        icon: const Icon(Ionicons.ellipsis_vertical),
        itemBuilder: (_) => const <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  value: 'transfer', child: Text('Transfers')),
              PopupMenuItem<String>(value: 'holders', child: Text('Holders')),
              PopupMenuItem<String>(value: 'info', child: Text('Info')),
            ],
        onSelected: (value) {})
  ];

  void showPhrase(context) {
    final prefs = Get.find<SharedPreferences>();
    // String? phrase = prefs.getString(StorageConstants.phrase);
    String? phrase = prefs.getString('${userInfo!.id}');
    if (phrase == null) {
      EasyLoading.showToast('Backup you phrase first');
      return;
    }

    List<String> words = phrase.split(',');

    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    color: ColorConstants.secondaryDarkAppColor,
                    height: 50,
                    child: Text(
                      'Passphrase'.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: words.mapIndexed((index, element) {
                        return FittedBox(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2),
                            decoration: BoxDecoration(
                                color: ColorConstants.secondaryDarkAppColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '${index + 1}. $element',
                              style: GoogleFonts.roboto(fontSize: 14),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 1,
                      color: ColorConstants.secondaryDarkAppColor,
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('OK'.tr)),
                      const SizedBox(
                        width: 8,
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}

enum HomeIndex {
  myWallet,
  scanQr,
  tyvScan,
  tyvMarket,
  contactSupport,
  settings,
//  Admin
  commissionFee,
  notification,
  addStores
}
