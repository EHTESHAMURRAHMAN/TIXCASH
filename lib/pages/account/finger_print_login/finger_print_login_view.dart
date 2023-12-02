import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'finger_print_login_controller.dart';

class FingerPrintLoginView extends GetView<FingerPrintLoginController> {
  const FingerPrintLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.authenticateWithBiometrics();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff1680ee),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      // backgroundColor: ColorConstants.secondaryDarkAppColor,
      backgroundColor: const Color(0xff1680ee),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Text(
                'Tixcash Wallet'.tr,
                style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
              Text(
                'Blockchain wallet'.tr,
                style: GoogleFonts.kodchasan(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () {
                  controller.authenticateWithBiometrics();
                },
                child: const Icon(
                  Icons.fingerprint,
                  color: Colors.white,
                  size: 70,
                ),
              ),
              // GestureDetector(
              //   child: Image.asset(
              //     'assets/icons/ic_fingerprint.png',
              //     color: Colors.white,
              //     width: 88,
              //   ),
              //   onTap: () {
              //     controller.authenticateWithBiometrics();
              //   },
              // ),
              const SizedBox(
                height: 100,
              ),
              Text(
                'Open wallet with fingerprint'.tr,
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal),
              ),
              const SizedBox(
                height: 14,
              ),
              GestureDetector(
                child: Text(
                  'Unlock with password'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
                onTap: () {
                  controller.loginDialog(context);
                },
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            // insetPadding: EdgeInsets.symmetric(horizontal: 15),

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Icon(Icons.warning,
                                        size: 35, color: Colors.red),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Are You Sure\nYou Want To Erase Your\nWallet?'
                                          .tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Your current wallet, accounts and assets will be removed from this app permanently. This action cannot be undone.'
                                          .tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'You can ONLY recover this wallet with your Secret Recovery Phrase TIXCASH WALLET does not have your Secret Recovery Phrase.'
                                          .tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.red),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.8,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            'I understand, continue'.tr,
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        controller.appController
                                            .validateLogin(context, () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          prefs.remove('userInfo');
                                          prefs.remove('user_pass');
                                          prefs.remove('is_backup');
                                          prefs.remove('phrase');
                                          prefs.remove('remind_later');
                                          prefs.remove('is_fingerprint');
                                          prefs.remove('is_password');
                                          prefs.remove('login_type');
                                          prefs.remove('security_type');
                                          prefs.remove('loc_time');
                                          prefs.remove('locale');
                                          prefs.remove('pause_time');
                                          prefs.remove('autolock_val');
                                          prefs.remove('security_val');
                                          prefs.remove('history_list');
                                          prefs.remove('last_open');
                                          exit(0);
                                        });
                                      },
                                    ),
                                    InkWell(
                                      onTap: () => Get.back(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.8,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            'Cancel'.tr,
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
                child: Text(
                  'Reset'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
