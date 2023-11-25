import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/paymentStatus.dart';
import 'package:tixcash/pages/account/create_account/create_account_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateWalletController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final CreateAccountController createController =
      Get.put(CreateAccountController());

  final TextEditingController controllerWords = TextEditingController();
  final TextEditingController controllerRandom = TextEditingController();
  final TextEditingController controllerPrivateKey = TextEditingController();
  final TextEditingController controllerphrase = TextEditingController();

  //get Pymt status
  final paymntStatusResponse = Rxn<PaymentStatusResponse>();
  final ispaymntStatusResponse = false.obs;
  final selectCurrencys = ''.obs;
  final isInputValid = false.obs;
  final isScanEnable = false.obs;
  // void checkIsValid() {
  //   isInputValid.value = controllerWords.text.isNotEmpty && controllerWords.text.length > 15;
  // }

  //
  final selectType = ''.obs;
  final selectid = 0.obs;
  WebViewController mWebViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    ); //

  final searchList = RxList<String>();
  final phraseList = RxList<String>();
  final isCheckedTerms1 = false.obs;
  final isCheckedTerms2 = false.obs;
  final isCheckedTerms3 = false.obs;
  final userdata = GetStorage();

  final selectedEdit = 10001.obs;
  final isActive = false.obs;
  final isphraseActive = false.obs;
  final isActived = false.obs;

  @override
  void onInit() {
    super.onInit();

    appController.backupPharse();
    // _loadHtmlFromAssets();
  }

  // Future<void> getPaymentStatus() async {
  //   String phrase = '';
  //   for (var element in phraseList) {
  //     phrase += '${element.toLowerCase()} ';
  //   }
  //   // phrase = phrase.substring(0, phrase.lastIndexOf(','));
  //   printInfo(info: phrase);

  //   ApiResponse response = await getpaymentstatusAPI(phrase);
  //   paymntStatusResponse.value = response.data;
  //   ispaymntStatusResponse.value = true;
  // }

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

  void showTermsAndConditions(context) async {
    bool isAgreed = GetStorage().read('agreed') ?? false;
    isAgreed
        ? showDialog(
            context: context,
            builder: (context) => Dialog(
                  // showDialog(context: context, builder: (context) => Dialog(
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/slogo.png',
                              width: SizeConfig().screenWidth * 0.15,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: Text(
                              'Terms and Conditions'.tr,
                              style: const TextStyle(
                                  fontSize: CommonConstants.normalText,
                                  color: Colors.black),
                            )),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: WebViewWidget(controller: mWebViewController),
                          // child: WebView(
                          //   initialUrl: 'Terms conditions',
                          //   onWebViewCreated:
                          //       (WebViewController webViewController) {
                          //     mWebViewController = webViewController;
                          //     _loadHtmlFromAssets();
                          //   },
                          // ),
                        ),
                        const Divider(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: Text(
                              'I AGREE'.tr,
                              style: const TextStyle(
                                  fontSize: CommonConstants.smallText),
                            ),
                            onPressed: () {
                              GetStorage().write('agreed', true);
                              Get.toNamed(Routes.CREATE_ACCOUNT);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ))
        : Get.toNamed(Routes.CREATE_ACCOUNT);
  }

  void searchWords(String word) {
    searchList.value = words
        .where((element) => element.toLowerCase().contains(word.toLowerCase()))
        .toList();
  }

  void sendPassphrase({isImportWallet = false}) async {
    // String phrase = '';
    // for (var element in phraseList) {
    //   phrase += '${element.toLowerCase()} ';
    // }

    // // phrase = phrase.substring(0, phrase.lastIndexOf(','));
    // printInfo(info: phrase);
    ApiResponse response = await restoreAccountAPI(controllerphrase.text);
    if (response.status) {
      //userInfo = response.data;

      final prefs = Get.find<SharedPreferences>();
      // prefs.setString(StorageConstants.phrase, phrase);
      prefs.setString('${userInfo!.id}', controllerphrase.text);
      prefs.setBool(StorageConstants.backup, true);
      appController.isBackup.value = true;

      if (isImportWallet) {
        Get.offAllNamed(Routes.Dashboard);
        appController.backupPharse();
        HomeController().getsubs();
      } else {
        createController.changePassword();
        // Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
        //   {'change': true}
        // ]);
        //?.then((value) => Get.offAllNamed(Routes.Dashboard));
      }
    } else {
      EasyLoading.showToast('${response.message}');
    }
  }

  void keyRecovery({isImportWallet = false}) async {
    ApiResponse response = await restorewithKeyAPI(controllerPrivateKey.text);
    if (response.status) {
      //userInfo = response.data;

      final prefs = Get.find<SharedPreferences>();
      prefs.setString('${userInfo!.id}', controllerPrivateKey.text);
      prefs.setBool(StorageConstants.backup, true);
      appController.isBackup.value = true;
      if (isImportWallet) {
        Get.offAllNamed(Routes.Dashboard);
        HomeController().getsubs();
        appController.backupPharse();
      } else {
        createController.changePassword();

        // Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
        //   {'change': true}
        // ]);
        //?.then((value) => Get.offAllNamed(Routes.Dashboard));
      }
    } else {
      EasyLoading.showToast('${response.message}');
    }
  }

  //
  //
  //
  //
  // void paymentforNewImport() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const Icon(Icons.cancel, color: Colors.transparent),
  //             const Text('Pay \$5 For New Wallet',
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold)),
  //             InkWell(
  //               onTap: () => Get.back(),
  //               child: const Icon(Icons.cancel, color: Colors.black, size: 25),
  //             ),
  //           ],
  //         ),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: [
  //               const SizedBox(height: 15),
  //               InkWell(
  //                 onTap: () {
  //                   Get.to(currencyPremium())?.then((value) {
  //                     if (value != null) {
  //                       selectCurrencys.value = value['name'];
  //                     }
  //                   });
  //                 },
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(horizontal: 12),
  //                   height: 50,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(15),
  //                       color: Colors.grey.shade300),
  //                   width: MediaQuery.of(context).size.width,
  //                   child: Row(
  //                     children: [
  //                       Obx(() => selectCurrencys.value.isEmpty
  //                           ? const Text('Select Currency',
  //                               style: TextStyle(
  //                                   color: Colors.black,
  //                                   fontSize: 14,
  //                                   fontWeight: FontWeight.bold))
  //                           : Text(selectCurrencys.value,
  //                               style: const TextStyle(
  //                                   color: Colors.black,
  //                                   fontSize: 15,
  //                                   fontWeight: FontWeight.bold),
  //                               maxLines: 1)),
  //                       const Spacer(),
  //                       const Icon(
  //                         Icons.arrow_drop_down,
  //                         size: 25,
  //                         color: Colors.black,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //       );
  //     },
  //   );
  // }

  // _loadHtmlFromAssets() async {
  //
  //\
  // // String fileText = await rootBundle.loadString('http://syncadmin.bittgc.io/termsconditions.html');
  //   File? file =
  //       await downloadFile('https://linechain.org/termsconditions.html');

  //   mWebViewController.loadRequest(Uri.file(file!.path));

  //   // mWebViewController!.loadRequest(Uri.dataFromString(file!.readAsStringSync(),
  //   //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //   //     .toString());
  // }
}

class selectCurrency extends StatelessWidget {
  selectCurrency({Key? key}) : super(key: key);
  CreateWalletController controller = Get.put(CreateWalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.cancel, color: Colors.transparent),
              const Text('Pay \$5 For New Wallet',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.cancel, color: Colors.black, size: 25),
              ),
            ],
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              Get.to(currencyPremium())?.then((value) {
                if (value != null) {
                  controller.selectCurrencys.value = value['name'];
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade300),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Obx(() => controller.selectCurrencys.value.isEmpty
                      ? const Text('Select Currency',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold))
                      : Text(controller.selectCurrencys.value,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          maxLines: 1)),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // controller.import();
            },
            child: const Text('Pay \$5'),
          ),
        ],
      )),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateWalletController extends GetxController {
  final AppController appController = Get.find<AppController>();

  final TextEditingController controllerWords = TextEditingController();

  WebViewController mWebViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    ); //

  final searchList = RxList<String>();
  final phraseList = RxList<String>();
  final isCheckedTerms1 = false.obs;
  final isCheckedTerms2 = false.obs;
  final isCheckedTerms3 = false.obs;
  final userdata = GetStorage();

  final selectedEdit = 10001.obs;
  final isActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    // _loadHtmlFromAssets();
  }

  void showTermsAndConditions(context) async {
    bool isAgreed = GetStorage().read('agreed') ?? false;
    isAgreed
        ? showDialog(
            context: context,
            builder: (context) => Dialog(
                  // showDialog(context: context, builder: (context) => Dialog(
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/slogo.png',
                              width: SizeConfig().screenWidth * 0.15,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: Text(
                              'Terms and Conditions'.tr,
                              style: const TextStyle(
                                  fontSize: CommonConstants.normalText,
                                  color: Colors.black),
                            )),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: WebViewWidget(controller: mWebViewController),
                          // child: WebView(
                          //   initialUrl: 'Terms conditions',
                          //   onWebViewCreated:
                          //       (WebViewController webViewController) {
                          //     mWebViewController = webViewController;
                          //     _loadHtmlFromAssets();
                          //   },
                          // ),
                        ),
                        const Divider(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: Text(
                              'I AGREE'.tr,
                              style: const TextStyle(
                                  fontSize: CommonConstants.smallText),
                            ),
                            onPressed: () {
                              GetStorage().write('agreed', true);
                              Get.toNamed(Routes.CREATE_ACCOUNT);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ))
        : Get.toNamed(Routes.CREATE_ACCOUNT);
  }

  void searchWords(String word) {
    searchList.value = words
        .where((element) => element.toLowerCase().contains(word.toLowerCase()))
        .toList();
  }

  void sendPassphrase({isImportWallet = false}) async {
    String phrase = '';
    for (var element in phraseList) {
      phrase += '${element.toLowerCase()},';
    }
    phrase = phrase.substring(0, phrase.lastIndexOf(','));
    printInfo(info: phrase);

    ApiResponse response = await restoreAccountAPI(phrase);
    if (response.status) {
      //userInfo = response.data;

      final prefs = Get.find<SharedPreferences>();
      // prefs.setString(StorageConstants.phrase, phrase);
      prefs.setString('${userInfo!.id}', phrase);
      prefs.setBool(StorageConstants.backup, true);
      appController.isBackup.value = true;

      if (isImportWallet) {
        Get.offAllNamed(Routes.Dashboard);
        HomeController().getsubs();
      } else {
        Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
          {'change': true}
        ]);
        //?.then((value) => Get.offAllNamed(Routes.Dashboard));
      }
    } else {
      EasyLoading.showToast('${response.message}');
    }
  }

  // _loadHtmlFromAssets() async {
  //
  //\
  // // String fileText = await rootBundle.loadString('http://syncadmin.bittgc.io/termsconditions.html');
  //   File? file =
  //       await downloadFile('https://linechain.org/termsconditions.html');

  //   mWebViewController.loadRequest(Uri.file(file!.path));

  //   // mWebViewController!.loadRequest(Uri.dataFromString(file!.readAsStringSync(),
  //   //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //   //     .toString());
  // }
}
*/