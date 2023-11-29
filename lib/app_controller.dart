import 'dart:async';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:screenshot/screenshot.dart';
//import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/models/BackupPhraseresponse.dart';
import 'package:tixcash/models/currency_response.dart';
import 'package:tixcash/pages/account/create_account/create_account_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/settings_view.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'api/apis.dart';
import 'shared/shared.dart';
import 'package:collection/collection.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:tixcash/models/push_notification.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
// }

class AppController extends GetxController {
  final isShowBalance = true.obs;
  ScreenshotController screenshotController = ScreenshotController();
  final fundBalance = 0.0.obs;
  final fundBalanceUSDT = 0.0.obs;
  final isBackup = true.obs;
  final language = 'English'.obs;
  final currency = 'USD'.obs;
  final LocalAuthentication auth = LocalAuthentication();

  final isUpdateChecked = false.obs;
  final firmwareVersion = 'V4.0.0.4.'.obs;
  //backup Pharse
  final backupPResponse = Rxn<BackupPResponse>();
  final isbackupPResponse = false.obs;
  //

  //____________PUSH NOTIFICATIONS______________
  //late final FirebaseMessaging _messaging;
  // late int _totalNotifications;
  PushNotification? notificationInfo;

  // Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    backupPharse();
    loadLocale();
    currencyloadLocale();
  }

  Future<void> backupPharse() async {
    ApiResponse response = await getbackuphrase();
    if (response.message == 'success') {
      backupPResponse.value = response.data;
      isbackupPResponse.value = true;
    } else {
      print(response.message);
    }
  }

  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   backupPharse();
  //   //await Firebase.initializeApp();
  //   // registerNotification();
  //   // checkForInitialMessage();

  //   // For handling notification when the app is in background
  //   // but not terminated
  //   // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   //   PushNotification notification = PushNotification(
  //   //     title: message.notification?.title,
  //   //     body: message.notification?.body,
  //   //     dataTitle: message.data['title'],
  //   //     dataBody: message.data['body'],
  //   //   );
  //   //
  //   //   notificationInfo = notification;
  //   //   // _totalNotifications++;
  //   //
  //   // });

  //   loadLocale();
  //   // var storage = Get.find<SharedPreferences>();
  //   // isBackup.value = storage.getBool(StorageConstants.backup)??false;
  //   // String? phrase = storage.getString('${userInfo!.id}');
  //   // isBackup.value = phrase != null;
  // }

  // void registerNotification() async {
  //   await Firebase.initializeApp();
  //   _messaging = FirebaseMessaging.instance;
  //   _messaging.getToken().then((value){
  //     print('tooken => $value');
  //     deviceId = value;
  //   });
  //
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  //   NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       print(
  //           'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
  //
  //       // Parse the message received
  //       PushNotification notification = PushNotification(
  //         title: message.notification?.title,
  //         body: message.notification?.body,
  //         dataTitle: message.data['title'],
  //         dataBody: message.data['body'],
  //       );
  //
  //         notificationInfo = notification;
  //         // _totalNotifications++;
  //
  //       if (notificationInfo != null) {
  //         // For displaying the notification as an overlay
  //         showSimpleNotification(
  //           Text(notificationInfo!.title!),
  //           leading: Image.asset('assets/images/slogo.png', width: 48,),
  //           subtitle: Text(notificationInfo!.body!),
  //           background: ColorConstants.primaryAppColor,
  //           duration: const Duration(seconds: 5),
  //         );
  //       }
  //     });
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }
  //
  // checkForInitialMessage() async {
  //   await Firebase.initializeApp();
  //   RemoteMessage? initialMessage =
  //   await FirebaseMessaging.instance.getInitialMessage();
  //
  //   if (initialMessage != null) {
  //     PushNotification notification = PushNotification(
  //       title: initialMessage.notification?.title,
  //       body: initialMessage.notification?.body,
  //       dataTitle: initialMessage.data['title'],
  //       dataBody: initialMessage.data['body'],
  //     );
  //
  //       notificationInfo = notification;
  //       // _totalNotifications++;
  //   }
  // }

  void loadLocale() {
    final pref = Get.find<SharedPreferences>();
    String locale = pref.getString(StorageConstants.locale) ?? 'en#US#English';
    List<String> values = locale.split('#');
    String loc = values[0];
    String country = values[1];
    language.value = values[2];

    Get.updateLocale(Locale(loc, country));
  }

  void currencyloadLocale() {
    final pref = Get.find<SharedPreferences>();
    String locale = pref.getString(StorageConstants.currency) ?? 'USD';
    currency.value = locale;
  }

  @override
  void onReady() {
    super.onReady();
  }

  void userFundBalance({required String currency}) async {
    if (userInfo == null) return;
    ApiResponse response = await userFundbalanceAPI(userInfo!.id, currency);
    if (response.status) {
      fundBalance.value = double.parse(response.data['totalAmount']);
      fundBalanceUSDT.value = double.parse(response.data['usdAmount']);
    }
  }

  void validateLogin(context, Function() onConfirm) {
    var storage = Get.find<SharedPreferences>();
    int security = storage.getInt(StorageConstants.securityType) ?? 0;
    if (security == 0) {
      loginDialog(context, () {
        Get.back();
        onConfirm();
      });
    } else {
      checkFingerPrint((auth) {
        if (auth) {
          onConfirm();
        } else {
          EasyLoading.showToast('Not authorized'.tr);

          loginDialog(context, () {
            Get.back();
            onConfirm();
          });
        }
      });
    }
  }

  void checkFingerPrint(Function(bool) isAuth) async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool _supportState = await auth.isDeviceSupported();
    bool authenticated = false;
    if (_supportState) {
      try {
        // authenticated = await auth.authenticate(
        //     localizedReason:
        //     'scanFringer'.tr,
        //     useErrorDialogs: true,
        //     stickyAuth: true,
        //     biometricOnly: true);
        authenticated = await auth.authenticate(
          localizedReason: 'auth_message'.tr,
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Open wallet with fingerprint'.tr,
              cancelButton: 'No thanks',
            ),
            IOSAuthMessages(
              lockOut: 'Open wallet with fingerprint'.tr,
              cancelButton: 'No thanks',
            ),
          ],
        );

        isAuth(authenticated);
      } catch (e) {
        isAuth(authenticated);
      }
    }
  }

  void loginDialog(context, Function() onConfirm) {
    final TextEditingController editingController = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: ColorConstants.secondaryDarkAppColor),
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Enter Password'.tr,
                          style: GoogleFonts.roboto(
                              color: ColorConstants.secondaryDarkAppColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: 67,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        obscureText: true,
                        controller: editingController,
                        decoration: InputDecoration(
                            hintText: 'Password'.tr,
                            hintStyle: const TextStyle(),
                            labelStyle: const TextStyle(fontSize: 12),
                            label: Text('Password'.tr),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.secondaryAppColor),
                                borderRadius: BorderRadius.circular(15)),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.secondaryAppColor),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      // child: TextFormField(
                      //   controller: editingController,
                      //   style: const TextStyle(color: Colors.black),
                      //   obscureText: true,
                      //   decoration: InputDecoration(
                      //       hintText: 'Password'.tr,
                      //       hintStyle: const TextStyle(color: Colors.black26),
                      //       border: InputBorder.none),
                      // ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Container(
                    //     height: 2,
                    //     color: ColorConstants.secondaryDarkAppColor,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 12),
                        TextButton(
                            onPressed: () => Get.back(),
                            child: Text('Cancel'.tr)),
                        TextButton(
                            onPressed: () {
                              var storage = Get.find<SharedPreferences>();
                              String? mPass = storage
                                  .getString(StorageConstants.userPassword);
                              mPass ??= userInfo!.password;
                              userPassword = mPass;
                              userPassword = storage.getString(
                                      StorageConstants.userPassword) ??
                                  userInfo!.password;
                              print('userPass $userPassword');
                              // if(userInfo!.password !=editingController.text.trim()){
                              if (userPassword.isEmpty ||
                                  userPassword !=
                                      editingController.text.trim()) {
                                EasyLoading.showToast(
                                    'Enter correct password'.tr);
                              } else {
                                onConfirm();
                                // Get.offAndToNamed(Routes.HOME);
                              }
                            },
                            child: Text('CONFIRM'.tr)),
                        const SizedBox(width: 12)
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Widget walletBalance(context, currency, screen) {
    print('$screen => Sending currency =>  $currency');
    userFundBalance(currency: currency);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Text('$currency'.tr.toUpperCase(), style: GoogleFonts.roboto(
          //    fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF40C4FF),),),
          // const SizedBox(height: 8,),
          Row(
            children: [
              LogoBuilder(logoUrl: currency),
              const SizedBox(
                width: 8,
              ),
              Row(
                children: [
                  Obx(
                    () => Text(fundBalance.value.toStringAsFixed(6),
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Obx(
                    () => Text('\$${fundBalanceUSDT.value}',
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFF40C4FF))),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget currencyWalletBalance(context, CurrencyResponse currency) {
    userFundBalance(currency: currency.currency);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'param_Balance'.trParams({'name': currency.currency}),
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    fontSize: CommonConstants.normalText,
                    color: Color(0xFF40C4FF))),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              LogoBuilder(logoUrl: currency.icon),
              const SizedBox(
                width: 8,
              ),
              Text('${currency.balance}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget backupWallet(context) => Obx(() => isBackup.value
      ? const SizedBox()
      : Container(
          padding: const EdgeInsets.all(16),
          color: Colors.red,
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'not_backed'.tr,
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('backup_msg'.tr)
                ],
              )),
              Column(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      color: Colors.black26,
                      child: Text(
                        'BACKUP'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      var storage = Get.find<SharedPreferences>();
                      int security =
                          storage.getInt(StorageConstants.securityType) ?? 0;
                      if (security == 0) {
                        loginDialog(context, () {
                          Get.back();
                          Get.toNamed(Routes.BACKUP_WORDS);
                        });
                      } else {
                        checkFingerPrint((auth) {
                          if (auth) {
                            Get.toNamed(Routes.BACKUP_WORDS);
                          } else {
                            EasyLoading.showToast('Not authorized'.tr);
                          }
                        });
                      }

                      // Get.toNamed(Routes.BACKUP_WORDS);
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        isBackup.value = true;
                      },
                      child: Text(
                        'Remind me later'.tr,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: ColorConstants.white,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      ))
                ],
              )
            ],
          ),
        ));

  void phraseValidate(context) {
    // final prefs = Get.find<SharedPreferences>();
    // String? phrase = prefs.getString('${userInfo!.id}');

    if (backupPResponse.value?.backuphrase == "") {
      CreateAccountController().backupPhrase(context);
    } else {
      Get.to(phrse());
      //showPhrase(context);
    }
  }

  void showPhrase(context) {
    if (userInfo == null) {
      return;
    }

    final prefs = Get.find<SharedPreferences>();
    String? phraseold = prefs.getString(StorageConstants.phrase);
    String? phrase = prefs.getString('${userInfo!.id}');

    if (phraseold != null && phrase == null) {
      phrase = phraseold;
      prefs.setString('${userInfo!.id}', phrase);
      prefs.remove(StorageConstants.phrase);
    }

    if (phrase == null) {
      EasyLoading.showToast('Backup you phrase first');
      return;
    }

    List<String> words = phrase.split(',');
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 12;
    final double itemWidth = size.width / 2;
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Passphrase'.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: (itemWidth / itemHeight),
                children: words.mapIndexed((index, element) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9)),
                    child: Center(
                      child: Text(
                        '${index + 1}. $element',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Container(
              //   alignment: Alignment.center,
              //   child: Wrap(
              //     children: words.mapIndexed((index, element) {
              //       return Container(
              //         margin: EdgeInsets.symmetric(vertical: 2),
              //         height: 40,
              //         width: MediaQuery.of(context).size.width / 3,
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //             color: ColorConstants.secondaryDarkAppColor,
              //             borderRadius: BorderRadius.circular(14)),
              //         child: Align(
              //           alignment: Alignment.center,
              //           child: Text(
              //             '${index + 1}. $element',
              //             style: GoogleFonts.roboto(fontSize: 14),
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(18)),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'OK'.tr,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }

  void showPrivateKey(context) {
    Get.toNamed(Routes.AUTH_FINGERPRINT);

    return;

    // checkFingerPrint(is)
  }

/*  void getAppVersion(context)async{

    if(!isUpdateChecked.value){
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      firmwareVersion.value = 'V$version$buildNumber';
      printLog(appName+'\t'+packageName+'\t'+version+'\t'+buildNumber);

      ApiResponse response = await getAppVersionAPI();
      if(response.status){
        String biuldno    = response.data['biuldno'];
        String versionno  = response.data['versionno'];

        printLog(biuldno+'\t\t'+versionno);

        if(double.parse(biuldno)>double.parse(buildNumber)){
          showDialog(context: context, builder: (context) => Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16,),
                  const Text('Update app'),

                  const SizedBox(height: 16,),
                  const Text('New version of application is available\nupdate app to get new features'),

                  const SizedBox(height: 16,),
                  Row(children: [
                    Expanded(child: TextButton(onPressed: (){
                      Get.back();
                    }, child: const Text('Cancel'))),
                    Expanded(child: ElevatedButton(onPressed: (){
                      Get.back();
                      launch('https://play.google.com/store/apps/details?id=com.wallet.line');
                    }, child: const Text('Update'))),
                  ],)
                ],),),
          ));
        }
      }
      isUpdateChecked.value = true;
    }
  }*/
}
