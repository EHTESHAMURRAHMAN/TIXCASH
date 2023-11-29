import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/constants/colors.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class FingerPrintLoginController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final AppController appController = Get.find<AppController>();
  final fingerAuthenticated = false.obs;
  final TextEditingController _editingController = TextEditingController();

  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized'.tr;
  bool _isAuthenticating = false;

  @override
  void onInit() {
    super.onInit();
    fingerAuthenticated.listen((val) {
      if (val) {
        Get.offAndToNamed(Routes.Dashboard);
      }
    });
  }

  void checkFingerPrint() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    auth.isDeviceSupported().then(
      (bool isSupported) {
        _supportState =
            isSupported ? _SupportState.supported : _SupportState.unsupported;
      },
    );

    authenticateWithBiometrics();
  }

  void loginDialog(context) {
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
                        controller: _editingController,
                        decoration: InputDecoration(
                            hintText: 'Password'.tr,
                            hintStyle: const TextStyle(fontSize: 12),
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
                            child: Text('CANCEL'.tr)),
                        TextButton(
                            onPressed: () {
                              // if(userInfo!.password !=_editingController.text.trim()){
                              if (userPassword.isEmpty ||
                                  userPassword !=
                                      _editingController.text.trim()) {
                                EasyLoading.showToast(
                                    'Enter correct password'.tr);
                              } else {
                                Get.offAndToNamed(Routes.Dashboard);
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

  // void loginDialog1(context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => Dialog(
  //             backgroundColor: Colors.white,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.all(8),
  //                   width: double.infinity,
  //                   color: ColorConstants.secondaryDarkAppColor,
  //                   height: 50,
  //                   child: Text(
  //                     'Enter Password'.tr,
  //                     style: TextStyle(fontSize: 16),
  //                   ),
  //                 ),
  //                 Container(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                   alignment: Alignment.centerLeft,
  //                   child: TextFormField(
  //                     controller: _editingController,
  //                     style: const TextStyle(color: Colors.black),
  //                     obscureText: true,
  //                     decoration: InputDecoration(
  //                         hintText: 'Password'.tr,
  //                         hintStyle: TextStyle(color: Colors.black26),
  //                         border: InputBorder.none),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16),
  //                   child: Container(
  //                     height: 2,
  //                     color: ColorConstants.secondaryDarkAppColor,
  //                   ),
  //                 ),
  //                 Row(
  //                   children: [
  //                     const Spacer(),
  //                     TextButton(onPressed: () {}, child: Text('CANCEL'.tr)),
  //                     const SizedBox(
  //                       width: 16,
  //                     ),
  //                     TextButton(
  //                         onPressed: () {
  //                           // if(userInfo!.password !=_editingController.text.trim()){
  //                           if (userPassword.isEmpty ||
  //                               userPassword !=
  //                                   _editingController.text.trim()) {
  //                             EasyLoading.showToast(
  //                                 'Enter correct password'.tr);
  //                           } else {
  //                             Get.offAndToNamed(Routes.Dashboard);
  //                           }
  //                         },
  //                         child: Text('CONFIRM'.tr)),
  //                     const SizedBox(
  //                       width: 8,
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ));
  // }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    _canCheckBiometrics = canCheckBiometrics;
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }

    _availableBiometrics = availableBiometrics;
  }

  // Future<void> _authenticate() async {
  //   bool authenticated = false;
  //   try {
  //       _isAuthenticating = true;
  //       _authorized = 'Authenticating';
  //     authenticated = await auth.authenticate(
  //         localizedReason: 'Let OS determine authentication method',
  //         useErrorDialogs: true,
  //         stickyAuth: true);
  //
  //       _isAuthenticating = false;
  //
  //   } on PlatformException catch (e) {
  //     print(e);
  //       _isAuthenticating = false;
  //       _authorized = 'Error - ${e.message}';
  //     return;
  //   }
  //
  //   _authorized = authenticated ? 'Authorized' : 'Not Authorized';
  // }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';

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

        // useErrorDialogs: true,
        // stickyAuth: true,
        // androidAuthStrings:  AndroidAuthMessages(
        //     signInTitle: 'Open wallet with fingerprint'.tr,
        // ),
        // iOSAuthStrings: IOSAuthMessages(
        // lockOut: 'Open wallet with fingerprint'.tr,
        // ),
        //biometricOnly: true
      );

      _isAuthenticating = false;
      _authorized = 'Authenticating';
    } on PlatformException catch (e) {
      print(e);
      _isAuthenticating = false;
      _authorized = 'Error - ${e.message}';
      return;
    }

    fingerAuthenticated.value = authenticated;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    _authorized = message;
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    _isAuthenticating = false;
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
