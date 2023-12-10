// import 'package:get/get.dart';
// import 'package:tixcash/api/apis.dart';
// import 'package:tixcash/app_controller.dart';
// import 'package:tixcash/models/models.dart';
//
// class HomeController extends GetxController {
//   final AppController appController = Get.find<AppController>();
//   final currencyListResponse = RxList<CurrencyResponse>();
//   final fundBalance = 0.0.obs;
//   final isCurrencyListResponse = false.obs;
//   RxnInt bottomIndex = RxnInt(0);
//
//   @override
//   void onInit() {
//     super.onInit();
//     userFundbalance();
//     getBalanceCurrencyList();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//   //Add This
//   void updateBottomIndex(int index){
//     bottomIndex.value = index;
//     print('current => $index');
//     refresh();
//   }
//
//   @override
//   InternalFinalCallback<void> get onStart => super.onStart;
//
//   void userFundbalance() async{
//     ApiResponse response = await userFundbalanceAPI(userInfo?.id??1);
//     if(response.status){
//       fundBalance.value = double.parse(response.data['totalAmount']);
//     }
//   }
//
//   Future<void> getBalanceCurrencyList()async{
//     ApiResponse response = await getBalanceCurrencyListAPI(userInfo?.id??1);
//     currencyListResponse.value = response.data;
//     isCurrencyListResponse.value = true;
//     appController.userFundBalance();
//     return;
//   }
//
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/models.dart';
import 'package:tixcash/models/subscriptionReponse.dart';
import 'package:tixcash/models/walletListResp.dart';
import 'package:tixcash/models/world_currency.dart';
import 'package:tixcash/pages/account/backup_words/backup_words_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/settings_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/constants/constants.dart';
import 'package:tixcash/shared/widgets/sa_alert_dialog.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final AppController appController = Get.find<AppController>();
  BackupWordsController backupcontroller = Get.put(BackupWordsController());
  SettingsController stngcontroller = Get.put(SettingsController());

  final currencyListResponse = RxList<CurrencyResponse>();
  final fundBalance = 0.0.obs;
  final fundBalanceUSDT = 0.0.obs;
  final isCurrencyListResponse = false.obs;
  final qrImagefile = Rxn<XFile>();
  RxnInt bottomIndex = RxnInt(0);
  final selectCurrencys = ''.obs;
  int counter = 0;
  var tabIndex = 0;
  final isShowBalance = true.obs;
  final walletListRespResponse = RxList<WalletListResp>();
  final iswalletListRespResponse = false.obs;
  //
  //

  final currentUser = true.obs;
  final isBalanceLoading = true.obs;

  final totalUSD = 0.0.obs;
  final totalEUR = 0.0.obs;
  final totalCNY = 0.0.obs;
  final totalRUB = 0.0.obs;
  final totalJPY = 0.0.obs;
  final totalHKD = 0.0.obs;
  final totalGBP = 0.0.obs;

  final subscriptionResponse = Rxn<SubscriptionResponse>();
  final issubscriptionResponse = false.obs;
  final worldCurrency = Rxn<WorldCurrency>();

  final editingController = TextEditingController();

  final accountName = ''.obs;

  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    initValues();
  }

  initValues() {
    checkBackup();
    userFundBalance();
    getUsdBalance1();
    getBalanceCurrencyList();
    getsubs();
    accountName.value = userInfo?.name ?? '';
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   initValues();
  // }

  // refreshData() {
  //   initValues();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       _timer ??= Timer.periodic(const Duration(seconds: 10), (timer) {
  //         getBalanceCurrencyList();
  //       });
  //       break;
  //     case AppLifecycleState.inactive:
  //       null;
  //       break;
  //     case AppLifecycleState.paused:
  //       print('App is closed');
  //       break;

  //     case AppLifecycleState.detached:
  //       null;
  //       break;
  //     case AppLifecycleState.hidden:
  //       null;
  //       break;
  //   }
  // }

  Future<void> checkBackup() async {
    if (userInfo == null) return;
    var storage = Get.find<SharedPreferences>();
    String? phrase = storage.getString('${userInfo!.id}');
    String? phraseold = storage.getString(StorageConstants.phrase);

    if (phraseold != null && phrase == null) {
      phrase = phraseold;
      storage.setString('${userInfo!.id}', phrase);
      storage.remove(StorageConstants.phrase);
    }

    appController.isBackup.value = phrase != null;
    userFundBalance();
    getsubs();
  }

  //Add This
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  void updateBottomIndex(int index) {
    bottomIndex.value = index;
    print('current => $index');
    refresh();
  }

  @override
  InternalFinalCallback<void> get onStart => super.onStart;

  void userFundBalance() async {
    if (userInfo == null) return;
    ApiResponse response = await userFundbalanceAPI(userInfo!.id, 'TXH');
    if (response.status) {
      fundBalance.value = double.parse(response.data['totalAmount']);
      fundBalanceUSDT.value = double.parse(response.data['usdAmount']);
    }
  }

  void getUsdBalance1() async {
    ApiResponse apiResponse = await getWorldCurrencyAPI();
    if (apiResponse.status) {
      WorldCurrencyResponse response = apiResponse.data;
      worldCurrency.value = response.data;
    } else {}
  }

  Future<void> getBalanceCurrencyList({currency = 'TXH'}) async {
    if (userInfo == null) return;
    isBalanceLoading.value = true;
    ApiResponse response = await getBalanceCurrencyListAPI(userInfo!.id);
    isBalanceLoading.value = false;
    currencyListResponse.value = response.data;
    isCurrencyListResponse.value = true;
    appController.userFundBalance(currency: currency);
    double total = 0.0;
    double total1 = 0.0;
    double total2 = 0.0;
    double total3 = 0.0;
    double total4 = 0.0;
    double total5 = 0.0;
    double total6 = 0.0;

    for (var element in currencyListResponse) {
      total += element.price * element.balance;
      total1 += element.price *
          element.balance *
          double.parse('${worldCurrency.value?.EUR ?? 0.0}');
      total2 += element.price *
          element.balance *
          double.parse('${worldCurrency.value?.CNY ?? 0.0}');
      total3 += element.price *
          element.balance *
          double.parse('${worldCurrency.value?.RUB ?? 0.0}');
      total4 += element.price *
          element.balance *
          double.parse('${worldCurrency.value?.JPY ?? 0.0}');
      total5 += element.price *
          element.balance *
          double.parse('${worldCurrency.value?.HKD ?? 0.0}');
      total6 += element.price *
          element.balance *
          double.parse('${worldCurrency.value?.GBP ?? 0.0}');
    }
    totalUSD.value = total;
    totalEUR.value = total1;
    totalCNY.value = total2;
    totalRUB.value = total3;
    totalJPY.value = total4;
    totalHKD.value = total5;
    totalGBP.value = total6;

    // for (var element in currencyListResponse) {
    //   total += element.price * element.balance;
    // }
    // totalUSD.value = total;
    return;
  }

  Future<void> createNewUser(context) async {
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
                      'Enter Username'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: editingController,
                      style: const TextStyle(color: Colors.black),
                      // obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Username'.tr,
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: InputBorder.none),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 2,
                      color: ColorConstants.secondaryDarkAppColor,
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () => Get.back(),
                          child: Text('Cancel'.tr)),
                      const SizedBox(
                        width: 16,
                      ),
                      TextButton(
                          onPressed: () {
                            if (editingController.text.isEmpty) {
                              EasyLoading.showToast('Enter username'.tr);
                            } else {
                              multipleAccount(context, editingController.text);
                            }
                          },
                          child: Text('CONFIRM'.tr)),
                      const SizedBox(
                        width: 8,
                      )
                    ],
                  )
                ],
              ),
            ));
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
                // Get.back();
                Get.offAllNamed(Routes.Dashboard);
              },
            ),
        barrierDismissible: false);
  }

  void getsubs() async {
    ApiResponse response = await getSubscriptionAPI();
    if (response.message == 'success') {
      subscriptionResponse.value = response.data;
      issubscriptionResponse.value = true;
    } else {
      print(response.message);
    }
  }

  void onCreateUser(context, username) async {
    EasyLoading.show();
    ApiResponse response = await createWalletAccountAPI({
      'Password': userPassword,
      'Pharseword': '',
      'uid': deviceId ?? '',
    });
    EasyLoading.dismiss();
    if (response.status) {
      UserResponse userResponse = response.data;
      userResponse.name = username;
      final prefs = Get.find<SharedPreferences>();
      String? val = prefs.getString(StorageConstants.userInfo);
      List<UserResponse> users = val != null ? userResponseFromJson(val) : [];
      // var mList =
      //     users.where((element) => element.id == userResponse.id).toList();
      // if (mList.isEmpty) {
      //   users.add(userResponse);
      // }
      // prefs.setString(StorageConstants.userInfo, userResponseToJson(userResponse));
      prefs.setString(StorageConstants.userInfo, userResponseToJson(users));
      prefs.setString(StorageConstants.userPassword, userPassword);
      userInfo = response.data;
      //Get.toNamed(Routes.BACKUP_WORDS);

      backupPhrase(context);
      getsubs();
    }
  }

  void multipleAccount(context, username) async {
    if (username == "") {
      Get.snackbar('Failed', 'Please Enter Wallet Name',
          backgroundColor: Theme.of(context).primaryColor);
      return;
    }
    // if (selectCurrencys.value.isEmpty) {
    //   Get.snackbar('Failed', 'Please Select Currency',
    //       backgroundColor: Theme.of(context).primaryColor);
    //   return;
    // }

    EasyLoading.show();
    ApiResponse response = await createmultipleaccountAPI({
      "parentid": userInfo?.id,
      'Password': userPassword,
      'Pharseword': '',
      'uid': deviceId ?? '',
      // "paymentcurrency": selectCurrencys.value.toString(),
    });

    EasyLoading.dismiss();
    if (response.status) {
      UserResponse userResponse = response.data;
      if (userResponse.message == 'succeed') {
        userResponse.name = username;
        final prefs = Get.find<SharedPreferences>();
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
        EasyLoading.showToast(userResponse.message.tr);

        appController.backupPharse();
        Get.offAllNamed(Routes.Dashboard);
        editingController.clear();
      } else {
        EasyLoading.showToast(userResponse.message.tr);
        Get.offAllNamed(Routes.Dashboard);
      }
    } else {
      EasyLoading.showToast('Fail');
      Get.offAllNamed(Routes.Dashboard);
    }
  }

  // void multipleAccount() async {
  //   ApiResponse response = await createmultipleaccountAPI({
  //     "parentid": userInfo?.id,
  //     'Password': userPassword,
  //     'Pharseword': '',
  //     'uid': deviceId ?? '',
  //     "paymentcurrency": selectCurrencys.value.toString(),
  //   });

  //   if (response.status) {
  //     UserResponse userResponse = response.data;
  //     if (userResponse.status == "succeed") {
  //       final prefs = Get.find<SharedPreferences>();
  //       String? val = prefs.getString(StorageConstants.userInfo);
  //       List<UserResponse> users = val != null ? userResponseFromJson(val) : [];
  //       var mList =
  //           users.where((element) => element.id == userResponse.id).toList();
  //       if (mList.isEmpty) {
  //         users.add(userResponse);
  //       }
  //       prefs.setString(StorageConstants.userInfo, userResponseToJson(users));
  //       prefs.setString(StorageConstants.userInfo, userResponseToJson(users));
  //       prefs.setString(StorageConstants.userPassword, userPassword);
  //       userInfo = response.data;
  //       EasyLoading.showToast('${response.message}');
  //       getWalletList();
  //       Get.back();
  //     } else {
  //       EasyLoading.showToast(userResponse.status);
  //     }
  //   } else {
  //     EasyLoading.showToast('${response.message}');
  //   }
  // }

  // Future<void> multipleAccount() async {
  //   Map body = {
  //     "parentid": userInfo?.id,
  //     'Password': userPassword,
  //     'Pharseword': "",
  //     'uid': deviceId ?? '',
  //     "paymentcurrency": selectCurrencys.value.toString(),
  //   };

  //   print(jsonEncode(body));
  //   EasyLoading.show();
  //   ApiResponse apiResponse = await createmultipleaccountAPI(body);
  //   EasyLoading.dismiss();
  //   if (apiResponse.status) {
  //     CommonResponse response = apiResponse.data;
  //     EasyLoading.showToast(response.message);
  //     getWalletList();
  //     Get.back();
  //   } else {
  //     Get.snackbar('Error', 'Something went wrong try again',
  //         backgroundColor: Colors.red);
  //   }
  // }

  // Future<void> getWalletList() async {
  //   if (userInfo == null) return;
  //   isBalanceLoading.value = true;
  //   ApiResponse response = await getwalletlistAPI();
  //   isBalanceLoading.value = false;
  //   walletListRespResponse.value = response.data;
  //   iswalletListRespResponse.value = true;
  //   return;
  // }

  // void addresslogin() async {
  //   ApiResponse response = await addressloginAPI({
  //     "address": userInfo?.address,
  //   });

  //   if (response.status) {
  //     final prefs = Get.find<SharedPreferences>();
  //     String? val = prefs.getString(StorageConstants.userInfo);
  //     List<UserResponse> users = val != null ? userResponseFromJson(val) : [];

  //     prefs.setString(StorageConstants.userInfo, userResponseToJson(users));
  //     prefs.setString(StorageConstants.userPassword, userPassword);
  //     userInfo = response.data;
  //     EasyLoading.showToast('${response.message}');
  //     getWalletList();
  //     Get.back();
  //   } else {
  //     EasyLoading.showToast('${response.message}');
  //   }
  // }
}
