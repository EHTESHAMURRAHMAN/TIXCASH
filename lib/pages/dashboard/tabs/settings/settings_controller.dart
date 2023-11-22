import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/BackupPhraseresponse.dart';
import 'package:tixcash/models/common_model.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final switchValue = false.obs;
  ScreenshotController screenshotController = ScreenshotController();
  final isShowBalance = true.obs;
  //backup Pharse
  final backupPResponse1 = Rxn<BackupPResponse>();
  final isbackupPResponse1 = false.obs;
  //

  final List<PopupItem> securityOption = [
    PopupItem(title: 'Password', value: '0'),
    PopupItem(title: 'Fingerprint', value: '1'),
  ];

  final List<PopupItem> unlockOption = [
    PopupItem(title: 'Password', value: '0'),
    PopupItem(title: 'Fingerprint', value: '1'),
    PopupItem(title: 'Do not lock', value: '2'),
  ];

  final List<PopupItem> autoLockOption = [
    PopupItem(title: 'Disabled', value: '10000000#0'),
    PopupItem(title: 'Immediately', value: '10#1'),
    PopupItem(title: '1_min', value: '60#2'),
    PopupItem(title: '5_min', value: '300#3'),
    PopupItem(title: '30_min', value: '1800#4'),
    PopupItem(title: '1_hour', value: '3600#5'),
    PopupItem(title: '5_hour', value: '18000#6'),
  ];

  final securityValue = 'Password'.obs;
  final unlockValue = 'Fingerprint'.obs;
  final autoLockValue = '5_min'.obs;

  WebViewController mWebViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white)
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
    )
    ..loadRequest(Uri.parse('https://dapp.tronlink.org/#/'));

  @override
  void onInit() {
    super.onInit();

    backupPharse1();
    backupPResponse1.value;
    var storage = Get.find<SharedPreferences>();
    securityValue.value =
        storage.getString(StorageConstants.securityVal) ?? 'Password'.tr;
    unlockValue.value =
        storage.getString(StorageConstants.unlockVal) ?? 'Fingerprint'.tr;
    autoLockValue.value =
        storage.getString(StorageConstants.autoLockVal) ?? '5_min'.tr;
  }

  Future<void> backupPharse1() async {
    ApiResponse response = await getbackuphrase();
    if (response.message == 'success') {
      backupPResponse1.value = response.data;
      isbackupPResponse1.value = true;
    } else {
      print(response.message);
    }
  }

  void updateLocale(loc, country, language) {
    var locale = Locale(loc, country);
    appController.language.value = language;
    Get.find<SharedPreferences>()
        .setString(StorageConstants.locale, '$loc#$country#$language');
    Get.updateLocale(locale);
    Get.back();
  }

  void cLocale(currency) {
    var locale1 = Locale(currency);
    appController.currency.value = currency;
    Get.find<SharedPreferences>()
        .setString(StorageConstants.currency, '$currency');
    Get.updateLocale(locale1);
    Get.back();
  }

  void showTermsAndConditions(context, bool isTermCondition) async {
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();

    //_loadHtmlFromAssets(isTermCondition);

    showDialog(
        context: context,
        builder: (context) => Dialog(
              // showDialog(context: context, builder: (context) => Dialog(

              backgroundColor: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Image.asset(
                    //       'assets/icons/logo.png',
                    //       width: SizeConfig().screenWidth * 0.15,
                    //     ),
                    //     const SizedBox(
                    //       width: 16,
                    //     ),
                    //     Expanded(
                    //         child: Text(
                    //       isTermCondition ? 'Terms and Conditions'.tr : 'Privacy policy'.tr,
                    //       style: const TextStyle(fontSize: CommonConstants.normalText, color: Colors.black),
                    //     )),
                    //   ],
                    // ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),

                    Expanded(child: SfPdfViewer.asset('assets/tix_terms.pdf')),
                    const Divider(),
                    // Expanded(
                    //   child: WebViewWidget(
                    //     controller: mWebViewController,
                    //     // initialUrl: 'http://syncadmin.bittgc.io/termsconditions.html',
                    //     // initialUrl: isTermCondition?'https://linechain.org/termsconditions.html'
                    //     //     :'https://linechain.org/peivacyPolicy.html',
                    //     // onWebViewCreated: (WebViewController webViewController) {
                    //     //   mWebViewController = webViewController;
                    //     //   // mWebViewController!.loadUrl('http://syncadmin.bittgc.io/termsconditions.html');
                    //     //   _loadHtmlFromAssets(isTermCondition);
                    //     // },
                    //   ),
                    // ),
                    // const Divider(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        child: Text(
                          'I AGREE'.tr,
                          style: const TextStyle(
                              fontSize: CommonConstants.smallText),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  _loadHtmlFromAssets(isTermCondition) async {
    // String fileText = await rootBundle.loadString('http://syncadmin.bittgc.io/termsconditions.html');
    File? file = await downloadFile(isTermCondition
        ? 'https://linechain.org/termsconditions.html'
        : 'https://linechain.org/peivacyPolicy.html');

    mWebViewController.loadFile(file!.path);

    // mWebViewController!.loadUrl( Uri.dataFromString(
    //     file!.readAsStringSync(),
    //     mimeType: 'text/html',
    //     encoding: Encoding.getByName('utf-8')
    // ).toString());
  }
}

class PrivacyandPolicy extends StatelessWidget {
  const PrivacyandPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Privacy Policy'.tr),
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SfPdfViewer.asset("assets/tix_privacy.pdf"),
    );
  }
}

class Term_Condition extends StatelessWidget {
  const Term_Condition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'.tr),
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SfPdfViewer.asset("assets/tix_terms.pdf"),
    );
  }
}

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:tixcash/app_controller.dart';
// import 'package:tixcash/models/common_model.dart';
// import 'package:tixcash/shared/constants/storage.dart';
// import 'package:tixcash/shared/shared.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class SettingsController extends GetxController {
//   final AppController appController = Get.find<AppController>();
//   final switchValue = false.obs;

//   final List<PopupItem> securityOption = [
//     PopupItem(title: 'Password', value: '0'),
//     PopupItem(title: 'Fingerprint', value: '1'),
//   ];

//   final List<PopupItem> unlockOption = [
//     PopupItem(title: 'Password', value: '0'),
//     PopupItem(title: 'Fingerprint', value: '1'),
//     PopupItem(title: 'Do not lock', value: '2'),
//   ];

//   final List<PopupItem> autoLockOption = [
//     PopupItem(title: 'Disabled', value: '10000000#0'),
//     PopupItem(title: 'Immediately', value: '10#1'),
//     PopupItem(title: '1_min', value: '60#2'),
//     PopupItem(title: '5_min', value: '300#3'),
//     PopupItem(title: '30_min', value: '1800#4'),
//     PopupItem(title: '1_hour', value: '3600#5'),
//     PopupItem(title: '5_hour', value: '18000#6'),
//   ];

//   final securityValue = 'Password'.obs;
//   final unlockValue = 'Fingerprint'.obs;
//   final autoLockValue = '5_min'.obs;

//   WebViewController mWebViewController = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(Colors.white)
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {
//           // Update loading bar.
//         },
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           if (request.url.startsWith('https://www.youtube.com/')) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(Uri.parse('https://dapp.tronlink.org/#/'));

//   @override
//   void onInit() {
//     super.onInit();
//     var storage = Get.find<SharedPreferences>();
//     securityValue.value =
//         storage.getString(StorageConstants.securityVal) ?? 'Password'.tr;
//     unlockValue.value =
//         storage.getString(StorageConstants.unlockVal) ?? 'Fingerprint'.tr;
//     autoLockValue.value =
//         storage.getString(StorageConstants.autoLockVal) ?? '5_min'.tr;
//   }

//   void showTermsAndConditions(context, bool isTermCondition) async {
//     // if (Platform.isAndroid) WebView.platform = AndroidWebView();

//     //_loadHtmlFromAssets(isTermCondition);

//     showDialog(
//         context: context,
//         builder: (context) => Dialog(
//               // showDialog(context: context, builder: (context) => Dialog(

//               backgroundColor: Colors.white,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//                     // Row(
//                     //   children: [
//                     //     Image.asset(
//                     //       'assets/icons/logo.png',
//                     //       width: SizeConfig().screenWidth * 0.15,
//                     //     ),
//                     //     const SizedBox(
//                     //       width: 16,
//                     //     ),
//                     //     Expanded(
//                     //         child: Text(
//                     //       isTermCondition ? 'Terms and Conditions'.tr : 'Privacy policy'.tr,
//                     //       style: const TextStyle(fontSize: CommonConstants.normalText, color: Colors.black),
//                     //     )),
//                     //   ],
//                     // ),
//                     const Divider(),
//                     const SizedBox(
//                       height: 16,
//                     ),

//                     Expanded(child: SfPdfViewer.asset('assets/tix_terms.pdf')),
//                     const Divider(),
//                     // Expanded(
//                     //   child: WebViewWidget(
//                     //     controller: mWebViewController,
//                     //     // initialUrl: 'http://syncadmin.bittgc.io/termsconditions.html',
//                     //     // initialUrl: isTermCondition?'https://linechain.org/termsconditions.html'
//                     //     //     :'https://linechain.org/peivacyPolicy.html',
//                     //     // onWebViewCreated: (WebViewController webViewController) {
//                     //     //   mWebViewController = webViewController;
//                     //     //   // mWebViewController!.loadUrl('http://syncadmin.bittgc.io/termsconditions.html');
//                     //     //   _loadHtmlFromAssets(isTermCondition);
//                     //     // },
//                     //   ),
//                     // ),
//                     // const Divider(),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: TextButton(
//                         child: Text(
//                           'I AGREE'.tr,
//                           style: const TextStyle(
//                               fontSize: CommonConstants.smallText),
//                         ),
//                         onPressed: () {
//                           Get.back();
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ));
//   }

//   _loadHtmlFromAssets(isTermCondition) async {
//     // String fileText = await rootBundle.loadString('http://syncadmin.bittgc.io/termsconditions.html');
//     File? file = await downloadFile(isTermCondition
//         ? 'https://linechain.org/termsconditions.html'
//         : 'https://linechain.org/peivacyPolicy.html');

//     mWebViewController.loadFile(file!.path);

//     // mWebViewController!.loadUrl( Uri.dataFromString(
//     //     file!.readAsStringSync(),
//     //     mimeType: 'text/html',
//     //     encoding: Encoding.getByName('utf-8')
//     // ).toString());
//   }
// }

// class PrivacyandPolicy extends StatelessWidget {
//   const PrivacyandPolicy({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Privacy Policy'),
//         foregroundColor: Colors.black,
//         centerTitle: true,
//         leading: InkWell(
//             onTap: () => Get.back(),
//             child: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             )),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarIconBrightness: Brightness.dark,
//           statusBarBrightness: Brightness.dark,
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: SfPdfViewer.asset("assets/tix_privacy.pdf"),
//     );
//   }
// }

// class Term_Condition extends StatelessWidget {
//   const Term_Condition({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Terms and Conditions'),
//         foregroundColor: Colors.black,
//         centerTitle: true,
//         leading: InkWell(
//             onTap: () => Get.back(),
//             child: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             )),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarIconBrightness: Brightness.dark,
//           statusBarBrightness: Brightness.dark,
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: SfPdfViewer.asset("assets/tix_terms.pdf"),
//     );
//   }
// }
