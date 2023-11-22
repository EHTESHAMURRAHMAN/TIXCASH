import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:tixcash/shared/widgets/preference_cell.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_controller.dart';

// ignore: must_be_immutable
class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);

  StreamController<int> _onPageChange = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<SettingsController>()
        ? Get.find<SettingsController>()
        : Get.put(SettingsController());

    if (_onPageChange.isClosed) {
      _onPageChange = StreamController<int>.broadcast();
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Setting'.tr,
            style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(CupertinoIcons.settings,
                      color: Theme.of(context).primaryColor, size: 25),
                  onTap: () {
                    Get.to(GeneralSetting());
                  },
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 16),
                  title: Text(
                    'General'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                  ),
                  subtitle: Text(
                    'Language, Pop-up notification'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 13, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.security,
                      color: Theme.of(context).primaryColor, size: 25),
                  onTap: () {
                    Get.to(Security());
                  },
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 16),
                  title: Text(
                    'Security & Privacy'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                  ),
                  subtitle: Text(
                    'Backup Phrase, Private Key, Change Password, Security Mode, Unlock Wallet With, Auto-Lock'
                        .tr,
                    style:
                        GoogleFonts.roboto(fontSize: 13, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(CupertinoIcons.forward_end_alt,
                      color: Theme.of(context).primaryColor, size: 25),
                  onTap: () {
                    EasyLoading.showToast('Launching Soon'.tr,
                        toastPosition: EasyLoadingToastPosition.top);
                  },
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 16),
                  title: Text(
                    'Advanced'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                  ),
                  subtitle: Text(
                    'Advanced'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 13, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(CupertinoIcons.profile_circled,
                      color: Theme.of(context).primaryColor, size: 25),
                  onTap: () {
                    EasyLoading.showToast('Launching Soon'.tr,
                        toastPosition: EasyLoadingToastPosition.top);
                  },
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 16),
                  title: Text(
                    'Contact'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                  ),
                  subtitle: Text(
                    'Contact'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 13, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.touch_app,
                      color: Theme.of(context).primaryColor, size: 25),
                  onTap: () {
                    Get.to(GetinTouch());
                  },
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 16),
                  title: Text(
                    'Get In Touch'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                  ),
                  subtitle: Text(
                    'Share This App, Review The App, Join telegram, Support Center'
                        .tr,
                    style:
                        GoogleFonts.roboto(fontSize: 13, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.details,
                      color: Theme.of(context).primaryColor, size: 25),
                  onTap: () {
                    Get.to(About());
                  },
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 16),
                  title: Text(
                    'About Section'.tr,
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                  ),
                  subtitle: Text(
                    'About Tixcash Wallet, Terms & Condition, Privacy Policy, App Version'
                        .tr,
                    style:
                        GoogleFonts.roboto(fontSize: 13, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class phrse extends StatelessWidget {
  phrse({Key? key}) : super(key: key);
  SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios,
                color: Colors.black, size: 18)),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Backup Phrase'.tr,
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Your Secret Recovery Phrase'.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        // title: Text('Flutter Tabs Demo'),
                        backgroundColor: Colors.transparent,
                        toolbarHeight: 0,
                        elevation: 0,
                        bottom: TabBar(
                          indicator: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          unselectedLabelColor: Theme.of(context).primaryColor,
                          labelColor: Colors.white,
                          dividerColor: Colors.black,
                          tabs: const [
                            Tab(icon: Icon(Icons.key_outlined)),
                            Tab(icon: Icon(Icons.qr_code))
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(() => Text(
                                    controller.isShowBalance.value
                                        ? '••••••'
                                        : '${controller.backupPResponse1.value?.backuphrase}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 16))),
                                const SizedBox(height: 10),
                                InkWell(
                                  child: Icon(
                                    controller.isShowBalance.value
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye_fill,
                                    color: controller.isShowBalance.value
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    controller.isShowBalance.value =
                                        !controller.isShowBalance.value;
                                  },
                                ),
                                // Obx(() => Text(
                                //     '${controller.backupPResponse1.value?.backuphrase}',
                                //     textAlign: TextAlign.center,
                                //     style: const TextStyle(
                                //         color: Colors.black, fontSize: 20))),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text:
                                                '${controller.backupPResponse1.value?.backuphrase}'));
                                        EasyLoading.showToast('Address Copied');
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        child: Center(
                                            child: Text(
                                          'Copy'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Share.share(
                                            '${controller.backupPResponse1.value?.backuphrase}');
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        child: Center(
                                            child: Text(
                                          'Share'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                children: [
                                  Screenshot(
                                      controller:
                                          controller.screenshotController,
                                      child: Center(
                                        child: Obx(() => QrImageView(
                                              backgroundColor: Colors.white,
                                              data:
                                                  '${controller.backupPResponse1.value?.backuphrase}',
                                              version: QrVersions.auto,
                                              size: 180.0,
                                            )),
                                      )),
                                  InkWell(
                                    onTap: () {
                                      shareQrCode();
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 24),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      child: Center(
                                          child: Text(
                                        'Share QR'.tr,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(8),
                          //         border: Border.all(color: Theme.of(context).primaryColor)),
                          //     child: Center(
                          //       child: Obx(() => QrImageView(
                          //             data: '${controller.backupPResponse1.value?.backuphrase}',
                          //             version: QrVersions.auto,
                          //             size: 200.0,
                          //           )),
                          //     ),
                          //   ),
                          // )
                          // SecondScreen(),
                        ],
                      ),
                    ),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(20)),
                //   width: MediaQuery.of(context).size.width,
                //   child: Column(
                //     children: [
                //       Obx(
                //         () => Text(
                //           '${controller.backupPResponse1.value?.backuphrase}',
                //           textAlign: TextAlign.center,
                //           style: const TextStyle(color: Colors.black, fontSize: 20),
                //         ),
                //       ),
                //       MaterialButton(
                //         onPressed: () {
                //           Clipboard.setData(ClipboardData(text: '${controller.backupPResponse1.value?.backuphrase}'));
                //           EasyLoading.showToast('Address Copied');
                //         },
                //         child: Container(
                //           width: double.infinity,
                //           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                //           decoration: BoxDecoration(
                //               color: Colors.grey.shade200,
                //               borderRadius: BorderRadius.circular(30),
                //               border: Border.all(color: Theme.of(context).primaryColor)),
                //           child: Center(
                //               child: Text(
                //             'Copy To Clipboard',
                //             style: TextStyle(color: Theme.of(context).primaryColor),
                //           )),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 15),
                Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height / 4.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(9)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Remember :'.tr,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '● Don\'t disclose secret recovery phrase to anyone Once the secret recovery phrase is lost, assets cannot be recovered'
                              .tr,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 13),
                        ),
                        Text(
                          '● Please do not backup and save by screenshots or network transmission'
                              .tr,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 13),
                        ),
                        Text(
                          '● Don\'t uninstall the app when in issues, note the recovery phrase first or contact us for help'
                              .tr,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Center(
                        child: Text(
                      'Done'.tr,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    controller.screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          await imagePath.writeAsBytes(image);

          Share.shareFiles([imagePath.path],
              text: 'This is Backup Phrase\'s QR');
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}

class GeneralSetting extends StatelessWidget {
  GeneralSetting({Key? key}) : super(key: key);

  SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'General'.tr,
          style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Text(
              'Current Language'.tr,
              style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              'Translate the application to a different\nsupport language'.tr,
              style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          elevation: 5,
                          shadowColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                'Select Language'.tr,
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 15),
                              const Divider(
                                color: Colors.red,
                              ),
                              const SizedBox(height: 10),
                              ListTile(
                                  title: Text('English',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.black)),
                                  onTap: () => controller.updateLocale(
                                      'en', 'US', 'English')),
                              // ListTile(
                              //   title: Text('Kyrgyz',
                              //       style: GoogleFonts.roboto(
                              //           fontSize: 14, color: Colors.black)),
                              //   onTap: () => updateLocale('kg', 'KG', 'Kyrgyz'),
                              // ),
                              ListTile(
                                title: Text('简体中文',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () => controller.updateLocale(
                                    'ch', 'CH', '简体中文'.tr),
                              ),
                              ListTile(
                                title: Text('ไทย',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () =>
                                    controller.updateLocale('th', 'TH', 'ไทย'),
                              ),
                              // ListTile(
                              //   title: Text('Russian',
                              //       style: GoogleFonts.roboto(
                              //           fontSize: 14, color: Colors.black)),
                              //   onTap: () =>
                              //       updateLocale('ru', 'RU', 'Russian'),
                              // ),
                              // ListTile(
                              //   title: Text('Turkish',
                              //       style: GoogleFonts.roboto(
                              //           fontSize: 14, color: Colors.black)),
                              //   onTap: () =>
                              //       updateLocale('tr', 'TR', 'Turkish'),
                              // ),
                            ],
                          ),
                        ));
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'Language'.tr,
                      subview: Obx(() => Text(
                            controller.appController.language.value.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 14, color: Colors.white),
                          )),
                      trailing: SvgPicture.asset(
                          'assets/SVG_Icons/Ic__arrow_down.svg'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          elevation: 5,
                          shadowColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                'Select Currency'.tr,
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 15),
                              const Divider(),
                              const SizedBox(height: 5),
                              ListTile(
                                title: Text('USD',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () => controller.cLocale('USD'.tr),
                              ),
                              ListTile(
                                title: Text('EUR',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () => controller.cLocale('EUR'.tr),
                              ),
                              ListTile(
                                title: Text('CNY',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () => controller.cLocale('CNY'.tr),
                              ),
                              ListTile(
                                title: Text('RUB',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () => controller.cLocale('RUB'.tr),
                              ),
                              ListTile(
                                title: Text('JPY',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () => controller.cLocale('JPY'.tr),
                              ),
                              ListTile(
                                title: Text('HKD',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () => controller.cLocale('HKD'.tr),
                              ),
                              ListTile(
                                title: Text('GBP',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black)),
                                onTap: () => controller.cLocale('GBP'.tr),
                              ),
                            ],
                          ),
                        ));
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'Currency'.tr,
                      subview: Obx(() => Text(
                            controller.appController.currency.value.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 14, color: Colors.white),
                          )),
                      trailing: SvgPicture.asset(
                          'assets/SVG_Icons/Ic__arrow_down.svg'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 2,
                shadowColor: Colors.purple[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MineCell(
                    title: 'Pop-Up notifications'.tr,
                    subview: const SizedBox(),
                    trailing: Obx(() => CupertinoSwitch(
                          activeColor: Colors.red,
                          trackColor: Colors.white70,
                          thumbColor: Colors.white,
                          value: controller.switchValue.value,
                          onChanged: (value) {
                            controller.switchValue.value = value;
                          },
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Security extends StatelessWidget {
  Security({Key? key}) : super(key: key);

  SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Security & Privacy'.tr,
          style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                controller.appController.validateLogin(context, () {
                  Get.back();
                  controller.appController.phraseValidate(context);
                });
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'Backup Phrase'.tr,
                      subview: Text(
                        'show'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.white),
                      ),
                      trailing: SvgPicture.asset(
                        'assets/SVG_Icons/Ic__arrow_down.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                controller.appController.validateLogin(context, () {
                  Get.back();
                  //Get.toNamed(Routes.AUTH_FINGERPRINT);
                  controller.appController.showPrivateKey(context);
                });
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'Backup Private Key'.tr,
                      subview: Text(
                        'show'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.white),
                      ),
                      trailing: SvgPicture.asset(
                        'assets/SVG_Icons/Ic__arrow_down.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                controller.appController.validateLogin(context, () {
                  Get.back();
                  Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
                    {'change': true}
                  ]);
                });
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'Change password'.tr,
                      subview: Text(
                        '*****',
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 2,
                shadowColor: Colors.purple[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: PopupMenuButton(
                      elevation: 5,
                      shadowColor: Colors.red,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Text(
                            'Security mode'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 14, color: Colors.white),
                          ),
                          const Spacer(),
                          Obx(() => Text(
                                controller.securityValue.value.tr,
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.white),
                              )),
                          const SizedBox(
                            width: 24,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 24,
                          )
                        ],
                      ),
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                value: controller.securityOption
                                    .elementAt(0)
                                    .value,
                                child: Text(
                                    controller.securityOption
                                        .elementAt(0)
                                        .title
                                        .tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black))),
                            PopupMenuItem<String>(
                                value: controller.securityOption
                                    .elementAt(1)
                                    .value,
                                child: Text(
                                    controller.securityOption
                                        .elementAt(1)
                                        .title
                                        .tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black))),
                          ],
                      onSelected: (String val) {
                        controller.appController.validateLogin(context, () {
                          controller.securityValue.value = controller
                              .securityOption
                              .elementAt(int.parse(val))
                              .title;
                          var storage = Get.find<SharedPreferences>();
                          storage.setString(StorageConstants.securityVal,
                              controller.securityValue.value);
                          storage.setInt(
                              StorageConstants.securityType, int.parse(val));
                        });
                      }),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 2,
                shadowColor: Colors.purple[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: PopupMenuButton(
                      elevation: 5,
                      shadowColor: Colors.red,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Text(
                            'Unlock Wallet With'.tr,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                          Spacer(),
                          Obx(() => Text(
                                controller.unlockValue.value.tr,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                          const SizedBox(
                            width: 24,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 24,
                          )
                        ],
                      ),
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                value:
                                    controller.unlockOption.elementAt(0).value,
                                child: Text(
                                    controller.unlockOption
                                        .elementAt(0)
                                        .title
                                        .tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black))),
                            PopupMenuItem<String>(
                                value:
                                    controller.unlockOption.elementAt(1).value,
                                child: Text(
                                    controller.unlockOption
                                        .elementAt(1)
                                        .title
                                        .tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black))),
                            PopupMenuItem<String>(
                                value:
                                    controller.unlockOption.elementAt(2).value,
                                child: Text(
                                    controller.unlockOption
                                        .elementAt(2)
                                        .title
                                        .tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black))),
                          ],
                      onSelected: (String val) {
                        controller.unlockValue.value = controller.unlockOption
                            .elementAt(int.parse(val))
                            .title;

                        var storage = Get.find<SharedPreferences>();
                        storage.setString(StorageConstants.unlockVal,
                            controller.unlockValue.value);
                        storage.setInt(
                            StorageConstants.loginType, int.parse(val));
                      }),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 2,
                shadowColor: Colors.purple[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: PopupMenuButton(
                    elevation: 5,
                    shadowColor: Colors.red,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Text(
                          'Auto-lock'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Obx(() => Text(
                              controller.autoLockValue.value.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )),
                        const SizedBox(
                          width: 24,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                          size: 24,
                        )
                      ],
                    ),
                    itemBuilder: (_) => <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                          value: controller.autoLockOption.elementAt(0).value,
                          child: Text(
                              controller.autoLockOption.elementAt(0).title.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))),
                      PopupMenuItem<String>(
                          value: controller.autoLockOption.elementAt(1).value,
                          child: Text(
                              controller.autoLockOption.elementAt(1).title.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))),
                      PopupMenuItem<String>(
                          value: controller.autoLockOption.elementAt(2).value,
                          child: Text(
                              controller.autoLockOption.elementAt(2).title.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))),
                      PopupMenuItem<String>(
                          value: controller.autoLockOption.elementAt(3).value,
                          child: Text(
                              controller.autoLockOption.elementAt(3).title.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))),
                      PopupMenuItem<String>(
                          value: controller.autoLockOption.elementAt(4).value,
                          child: Text(
                              controller.autoLockOption.elementAt(4).title.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))),
                      PopupMenuItem<String>(
                          value: controller.autoLockOption.elementAt(5).value,
                          child: Text(
                              controller.autoLockOption.elementAt(5).title.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))),
                      PopupMenuItem<String>(
                          value: controller.autoLockOption.elementAt(6).value,
                          child: Text(
                              controller.autoLockOption.elementAt(6).title.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))),
                    ],
                    onSelected: (String val) {
                      List<String> str = val.split('#');
                      var storage = Get.find<SharedPreferences>();
                      storage.setInt(
                          StorageConstants.locTime, int.parse(str[0]));
                      storage.setString(
                          StorageConstants.autoLockVal,
                          controller.autoLockOption
                              .elementAt(int.parse(str[1]))
                              .title);

                      printInfo(
                          info:
                              'Autolock ${controller.autoLockOption.elementAt(int.parse(str[1])).title}');

                      controller.autoLockValue.value = controller.autoLockOption
                          .elementAt(int.parse(str[1]))
                          .title;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetinTouch extends StatelessWidget {
  GetinTouch({Key? key}) : super(key: key);

  SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Get In Touch'.tr,
          style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Share.share(
                    'Download the TIXCASH WALLET app from play store\n\nhttps://play.google.com/store/apps/details?id=com.wallet.line');
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'Share this app'.tr,
                      svgIcon: 'assets/SVG_Icons/Ic_share.svg',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 2,
                shadowColor: Colors.purple[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MineCell(
                    title: 'Review the App'.tr,
                    svgIcon: 'assets/SVG_Icons/Ic_google_play.svg',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 2,
                shadowColor: Colors.purple[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MineCell(
                    title: 'Join Telegram'.tr,
                    svgIcon: 'assets/SVG_Icons/Ic_telegram.svg',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 2,
                shadowColor: Colors.purple[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MineCell(
                    title: 'Support Center'.tr,
                    svgIcon: 'assets/SVG_Icons/Ic_lifebuoy.svg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);

  SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'About Tixcash Wallet'.tr,
          style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                const url = 'https://www.tixcash.org/';
                openBrowserUrl(url: url, inApp: true);
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'About TIXCASH WALLET'.tr,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'Terms and Conditions'.tr,
                      onPressed: () => Get.to(const Term_Condition()),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'Privacy Policy'.tr,
                      onPressed: () => Get.to(const PrivacyandPolicy()),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shadowColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MineCell(
                      title: 'App Version'.tr,
                      trailing: Text(
                        '1.15.1.2341',
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '@2023 Tixcash. All rights reserved'.tr,
              style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Future openBrowserUrl({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }
}
// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share/share.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tixcash/routes/app_pages.dart';
// import 'package:tixcash/shared/shared.dart';
// import 'package:tixcash/shared/widgets/preference_cell.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'settings_controller.dart';

// // ignore: must_be_immutable
// class SettingsView extends GetView<SettingsController> {
//   SettingsView({Key? key}) : super(key: key);

//   StreamController<int> _onPageChange = StreamController<int>.broadcast();

//   @override
//   Widget build(BuildContext context) {
//     Get.isRegistered<SettingsController>()
//         ? Get.find<SettingsController>()
//         : Get.put(SettingsController());

//     if (_onPageChange.isClosed) {
//       _onPageChange = StreamController<int>.broadcast();
//     }
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: Text(
//             'Settings'.tr,
//             style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
//           ),
//           systemOverlayStyle: const SystemUiOverlayStyle(
//             statusBarColor: Colors.white,
//             statusBarIconBrightness: Brightness.dark,
//             statusBarBrightness: Brightness.dark,
//           ),
//         ),
//         body: Container(
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: ListView(
//               children: [
//                 ListTile(
//                   onTap: () {
//                     Get.to(GeneralSetting());
//                   },
//                   trailing: const Icon(Icons.arrow_forward_ios,
//                       color: Colors.black, size: 19),
//                   title: Text(
//                     'General'.tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 20, color: Colors.black),
//                   ),
//                   subtitle: Text(
//                     'Language, Pop-up notification'.tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//                 // const Divider(color: Colors.white12,),
//                 const SizedBox(height: 5),
//                 const Divider(),
//                 const SizedBox(height: 5),
//                 ListTile(
//                   onTap: () {
//                     Get.to(Security());
//                   },
//                   trailing: const Icon(Icons.arrow_forward_ios,
//                       color: Colors.black, size: 19),
//                   title: Text(
//                     'Security & Privacy'.tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 20, color: Colors.black),
//                   ),
//                   subtitle: Text(
//                     'Backup Phrase, Private Key, Change Password, Security Mode, Unlock Wallet With, Auto-Lock'
//                         .tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 const Divider(),
//                 const SizedBox(height: 5),
//                 ListTile(
//                   onTap: () {
//                     Get.to(GetinTouch());
//                   },
//                   trailing: const Icon(Icons.arrow_forward_ios,
//                       color: Colors.black, size: 19),
//                   title: Text(
//                     'Get In Touch'.tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 20, color: Colors.black),
//                   ),
//                   subtitle: Text(
//                     'Share This App, Review The App, Join telegram, Support Center'
//                         .tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 const Divider(),
//                 const SizedBox(height: 5),
//                 ListTile(
//                   onTap: () {
//                     Get.to(About());
//                   },
//                   trailing: const Icon(Icons.arrow_forward_ios,
//                       color: Colors.black, size: 19),
//                   title: Text(
//                     'About Section'.tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 20, color: Colors.black),
//                   ),
//                   subtitle: Text(
//                     'About Tixcash Wallet, Terms & Condition, Privacy Policy, App Version'
//                         .tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//                 // MineCell(
//                 //   title: 'VIP Access'.tr,
//                 //   subview: Text(
//                 //     'Get Premium'.tr,
//                 //     style:
//                 //         GoogleFonts.roboto(fontSize: 14, color: Colors.black),
//                 //   ),
//                 //   onPressed: () {
//                 //     Get.toNamed(Routes.PREMIUM_VIEW);
//                 //   },
//                 // ),

//                 MineCell(
//                   title: 'Language'.tr,
//                   subview: Obx(() => Text(
//                         controller.appController.language.value.tr,
//                         style: GoogleFonts.roboto(
//                             fontSize: 14, color: Colors.black),
//                       )),
//                   onPressed: () {
//                     showDialog(
//                         context: context,
//                         builder: (context) => Dialog(
//                               backgroundColor: Colors.white,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Text(
//                                     'Select Language'.tr,
//                                     style: GoogleFonts.roboto(
//                                         fontSize: 14, color: Colors.black),
//                                   ),
//                                   ListTile(
//                                       title: Text('English',
//                                           style: GoogleFonts.roboto(
//                                               fontSize: 14,
//                                               color: Colors.black)),
//                                       onTap: () => controller.updateLocale(
//                                           'en', 'US', 'English')),
//                                   // ListTile(
//                                   //   title: Text('Kyrgyz',
//                                   //       style: GoogleFonts.roboto(
//                                   //           fontSize: 14, color: Colors.black)),
//                                   //   onTap: () => updateLocale('kg', 'KG', 'Kyrgyz'),
//                                   // ),
//                                   ListTile(
//                                     title: Text('简体中文',
//                                         style: GoogleFonts.roboto(
//                                             fontSize: 14, color: Colors.black)),
//                                     onTap: () => controller.updateLocale(
//                                         'ch', 'CH', '简体中文'.tr),
//                                   ),
//                                   ListTile(
//                                     title: Text('ไทย',
//                                         style: GoogleFonts.roboto(
//                                             fontSize: 14, color: Colors.black)),
//                                     onTap: () => controller.updateLocale(
//                                         'th', 'TH', 'ไทย'),
//                                   ),
//                                   // ListTile(
//                                   //   title: Text('Russian',
//                                   //       style: GoogleFonts.roboto(
//                                   //           fontSize: 14, color: Colors.black)),
//                                   //   onTap: () =>
//                                   //       updateLocale('ru', 'RU', 'Russian'),
//                                   // ),
//                                   // ListTile(
//                                   //   title: Text('Turkish',
//                                   //       style: GoogleFonts.roboto(
//                                   //           fontSize: 14, color: Colors.black)),
//                                   //   onTap: () =>
//                                   //       updateLocale('tr', 'TR', 'Turkish'),
//                                   // ),
//                                 ],
//                               ),
//                             ));
//                   },
//                   trailing: SvgPicture.asset(
//                     'assets/SVG_Icons/Ic__arrow_down.svg',
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 MineCell(
//                   title: 'Pop-Up notifications'.tr,
//                   subview: const SizedBox(),
//                   trailing: Obx(() => CupertinoSwitch(
//                         activeColor: Theme.of(context).primaryColor,
//                         thumbColor: Colors.white,
//                         value: controller.switchValue.value,
//                         onChanged: (value) {
//                           controller.switchValue.value = value;
//                         },
//                       )),
//                 ),

//                 const SizedBox(height: 40),
//                 // Divider(color: Colors.white12,),

//                 Text(
//                   'Security & Privacy'.tr,
//                   style: GoogleFonts.roboto(
//                       fontSize: 16, color: const Color(0xff1680ee)),
//                 ),
//                 // const Divider(color: Colors.white12,),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 // MineCell(
//                 //   title: 'Delete Wallet'.tr,
//                 //   onPressed: () {
//                 //     // CreateAccountController().backupPhrase(context);
//                 //     controller.appController.validateLogin(context, () {
//                 //       Get.back();
//                 //       Get.to(const AccountDelete());
//                 //     });

//                 //     // controller.appController.loginDialog(context, () {
//                 //     //   Get.back();
//                 //     //   controller.appController.phraseValidate(context);

//                 //     //   //controller.appController.showPhrase(context);
//                 //     // });
//                 //   },
//                 // ),

//                 MineCell(
//                   title: 'Backup phrase'.tr,
//                   subview: Text(
//                     'show'.tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 14, color: Colors.black),
//                   ),
//                   onPressed: () {
//                     // CreateAccountController().backupPhrase(context);
//                     controller.appController.validateLogin(context, () {
//                       Get.back();
//                       controller.appController.phraseValidate(context);
//                     });

//                     // controller.appController.loginDialog(context, () {
//                     //   Get.back();
//                     //   controller.appController.phraseValidate(context);

//                     //   //controller.appController.showPhrase(context);
//                     // });
//                   },
//                 ),

//                 MineCell(
//                   title: 'Backup Private Key'.tr,
//                   subview: Text(
//                     'show'.tr,
//                     style:
//                         GoogleFonts.roboto(fontSize: 14, color: Colors.black),
//                   ),
//                   onPressed: () {
//                     controller.appController.validateLogin(context, () {
//                       Get.back();
//                       //Get.toNamed(Routes.AUTH_FINGERPRINT);
//                       controller.appController.showPrivateKey(context);
//                     });
//                     // controller.appController.loginDialog(context, () {
//                     //   Get.back();
//                     //   controller.appController.showPrivateKey(context);
//                     // });
//                   },
//                 ),

//                 MineCell(
//                   title: 'Change password'.tr,
//                   subview: Text(
//                     '*****',
//                     style:
//                         GoogleFonts.roboto(fontSize: 14, color: Colors.black),
//                   ),
//                   onPressed: () {
//                     controller.appController.validateLogin(context, () {
//                       Get.back();
//                       Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
//                         {'change': true}
//                       ]);
//                     });
//                     // controller.appController.loginDialog(context, () {
//                     //   Get.back();
//                     //   Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
//                     //     {'change': true}
//                     //   ]);
//                     // });
//                   },
//                 ),

//                 // MineCell(title: 'Security mode', subview:  Obx(() => Text(controller.securityValue.value, style: const TextStyle(fontSize: 16),)),
//                 MineCell(
//                   title: 'Security mode'.tr,
//                   subview: PopupMenuButton(
//                       color: Colors.white,
//                       child: Row(
//                         children: [
//                           Obx(() => Text(
//                                 controller.securityValue.value.tr,
//                                 style: GoogleFonts.roboto(
//                                     fontSize: 14, color: Colors.black),
//                               )),
//                           const SizedBox(
//                             width: 24,
//                           ),
//                           Icon(
//                             Icons.keyboard_arrow_down_outlined,
//                             color: Theme.of(context).primaryColor,
//                             size: 24,
//                           )
//                         ],
//                       ),
//                       itemBuilder: (_) => <PopupMenuItem<String>>[
//                             PopupMenuItem<String>(
//                                 value: controller.securityOption
//                                     .elementAt(0)
//                                     .value,
//                                 child: Text(
//                                     controller.securityOption
//                                         .elementAt(0)
//                                         .title
//                                         .tr,
//                                     style: GoogleFonts.roboto(
//                                         fontSize: 14, color: Colors.black))),
//                             PopupMenuItem<String>(
//                                 value: controller.securityOption
//                                     .elementAt(1)
//                                     .value,
//                                 child: Text(
//                                     controller.securityOption
//                                         .elementAt(1)
//                                         .title
//                                         .tr,
//                                     style: GoogleFonts.roboto(
//                                         fontSize: 14, color: Colors.black))),
//                           ],
//                       onSelected: (String val) {
//                         controller.appController.validateLogin(context, () {
//                           controller.securityValue.value = controller
//                               .securityOption
//                               .elementAt(int.parse(val))
//                               .title;
//                           var storage = Get.find<SharedPreferences>();
//                           storage.setString(StorageConstants.securityVal,
//                               controller.securityValue.value);
//                           storage.setInt(
//                               StorageConstants.securityType, int.parse(val));
//                         });
//                       }),
//                   isTrailing: false,
//                 ),
//                 MineCell(
//                   title: 'Unlock Wallet With'.tr,
//                   subview: PopupMenuButton(
//                       color: Colors.white,
//                       child: Row(
//                         children: [
//                           Obx(() => Text(
//                                 controller.unlockValue.value.tr,
//                                 style: const TextStyle(
//                                     fontSize: 16, color: Colors.black),
//                               )),
//                           const SizedBox(
//                             width: 24,
//                           ),
//                           Icon(
//                             Icons.keyboard_arrow_down_outlined,
//                             color: Theme.of(context).primaryColor,
//                             size: 24,
//                           )
//                         ],
//                       ),
//                       itemBuilder: (_) => <PopupMenuItem<String>>[
//                             PopupMenuItem<String>(
//                                 value:
//                                     controller.unlockOption.elementAt(0).value,
//                                 child: Text(
//                                     controller.unlockOption
//                                         .elementAt(0)
//                                         .title
//                                         .tr,
//                                     style: GoogleFonts.roboto(
//                                         fontSize: 14, color: Colors.black))),
//                             PopupMenuItem<String>(
//                                 value:
//                                     controller.unlockOption.elementAt(1).value,
//                                 child: Text(
//                                     controller.unlockOption
//                                         .elementAt(1)
//                                         .title
//                                         .tr,
//                                     style: GoogleFonts.roboto(
//                                         fontSize: 14, color: Colors.black))),
//                             PopupMenuItem<String>(
//                                 value:
//                                     controller.unlockOption.elementAt(2).value,
//                                 child: Text(
//                                     controller.unlockOption
//                                         .elementAt(2)
//                                         .title
//                                         .tr,
//                                     style: GoogleFonts.roboto(
//                                         fontSize: 14, color: Colors.black))),
//                           ],
//                       onSelected: (String val) {
//                         controller.unlockValue.value = controller.unlockOption
//                             .elementAt(int.parse(val))
//                             .title;

//                         var storage = Get.find<SharedPreferences>();
//                         storage.setString(StorageConstants.unlockVal,
//                             controller.unlockValue.value);
//                         storage.setInt(
//                             StorageConstants.loginType, int.parse(val));
//                       }),
//                   isTrailing: false,
//                 ),

//                 MineCell(
//                   title: 'Auto-lock'.tr,
//                   subview: PopupMenuButton(
//                     color: Colors.white,
//                     child: Row(
//                       children: [
//                         Obx(() => Text(
//                               controller.autoLockValue.value.tr,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                               ),
//                             )),
//                         const SizedBox(
//                           width: 24,
//                         ),
//                         Icon(
//                           Icons.keyboard_arrow_down_outlined,
//                           color: Theme.of(context).primaryColor,
//                           size: 24,
//                         )
//                       ],
//                     ),
//                     itemBuilder: (_) => <PopupMenuItem<String>>[
//                       PopupMenuItem<String>(
//                           value: controller.autoLockOption.elementAt(0).value,
//                           child: Text(
//                               controller.autoLockOption.elementAt(0).title.tr,
//                               style: GoogleFonts.roboto(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w400))),
//                       PopupMenuItem<String>(
//                           value: controller.autoLockOption.elementAt(1).value,
//                           child: Text(
//                               controller.autoLockOption.elementAt(1).title.tr,
//                               style: GoogleFonts.roboto(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w400))),
//                       PopupMenuItem<String>(
//                           value: controller.autoLockOption.elementAt(2).value,
//                           child: Text(
//                               controller.autoLockOption.elementAt(2).title.tr,
//                               style: GoogleFonts.roboto(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w400))),
//                       PopupMenuItem<String>(
//                           value: controller.autoLockOption.elementAt(3).value,
//                           child: Text(
//                               controller.autoLockOption.elementAt(3).title.tr,
//                               style: GoogleFonts.roboto(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w400))),
//                       PopupMenuItem<String>(
//                           value: controller.autoLockOption.elementAt(4).value,
//                           child: Text(
//                               controller.autoLockOption.elementAt(4).title.tr,
//                               style: GoogleFonts.roboto(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w400))),
//                       PopupMenuItem<String>(
//                           value: controller.autoLockOption.elementAt(5).value,
//                           child: Text(
//                               controller.autoLockOption.elementAt(5).title.tr,
//                               style: GoogleFonts.roboto(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w400))),
//                       PopupMenuItem<String>(
//                           value: controller.autoLockOption.elementAt(6).value,
//                           child: Text(
//                               controller.autoLockOption.elementAt(6).title.tr,
//                               style: GoogleFonts.roboto(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w400))),
//                     ],
//                     onSelected: (String val) {
//                       List<String> str = val.split('#');
//                       var storage = Get.find<SharedPreferences>();
//                       storage.setInt(
//                           StorageConstants.locTime, int.parse(str[0]));
//                       storage.setString(
//                           StorageConstants.autoLockVal,
//                           controller.autoLockOption
//                               .elementAt(int.parse(str[1]))
//                               .title);

//                       printInfo(
//                           info:
//                               'Autolock ${controller.autoLockOption.elementAt(int.parse(str[1])).title}');

//                       controller.autoLockValue.value = controller.autoLockOption
//                           .elementAt(int.parse(str[1]))
//                           .title;
//                     },
//                   ),
//                   isTrailing: false,
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   'ADVANCED'.tr,
//                   style: GoogleFonts.roboto(
//                       fontSize: 16, color: const Color(0xff1680ee)),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   'CONTACT'.tr,
//                   style: GoogleFonts.roboto(
//                       fontSize: 16, color: const Color(0xff1680ee)),
//                 ),

//                 // const Divider(color: Colors.white12,),

//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   'GET IN TOUCH'.tr,
//                   style: GoogleFonts.roboto(
//                       fontSize: 16, color: const Color(0xff1680ee)),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 // const Divider(color: Colors.white12,),
//                 MineCell(
//                   title: 'Share this app'.tr,
//                   svgIcon: 'assets/SVG_Icons/Ic_share.svg',
//                   onPressed: () {
//                     Share.share(
//                         'Download the TIXCASH WALLET app from play store\n\nhttps://play.google.com/store/apps/details?id=com.wallet.line');
//                     // Share.share(
//                     //     'download_app'.trParams({'name': 'https://play.google.com/store/apps/details?id=com.wallet.line'}));
//                   },
//                 ),
//                 MineCell(
//                   title: 'Review the App'.tr,
//                   svgIcon: 'assets/SVG_Icons/Ic_google_play.svg',
//                   onPressed: () {
//                     //launch('https://play.google.com/store/apps/details?id=com.wallet.line');
//                   },
//                 ),
//                 MineCell(
//                   title: 'Join Telegram'.tr,
//                   svgIcon: 'assets/SVG_Icons/Ic_telegram.svg',
//                   onPressed: () {
//                     // launchUrlString('https://t.me/reliwelltechnologies',
//                     //     mode: LaunchMode.externalApplication);
//                   },
//                 ),
//                 MineCell(
//                   title: 'Support Center'.tr,
//                   svgIcon: 'assets/SVG_Icons/Ic_lifebuoy.svg',
//                   onPressed: () {
//                     //  Get.toNamed(Routes.CONTACT_SUPPORT);
//                   },
//                 ),

//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   'ABOUT'.tr,
//                   style: GoogleFonts.roboto(
//                       fontSize: 16, color: const Color(0xff1680ee)),
//                 ),
//                 // const Divider(color: Colors.white12,),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 // MineCell(title: 'Terms and Conditions'.tr, onPressed: () => Get.to(() => const TermsPolicy(title: 'Terms of Service', fileName: 'TYV_Terms_Conditions')),),
//                 MineCell(
//                   title: 'About TIXCASH WALLET'.tr,
//                   onPressed: () async {
//                     const url = 'https://www.tixcash.org/';
//                     openBrowserUrl(url: url, inApp: true);
//                   },
//                 ),
//                 MineCell(
//                   title: 'Terms and Conditions'.tr,
//                   onPressed: () => Get.to(const Term_Condition()),
//                 ),
//                 MineCell(
//                   title: 'Privacy Policy'.tr,
//                   onPressed: () => Get.to(const PrivacyandPolicy()),
//                 ),
//                 MineCell(
//                   title: 'App Version'.tr,
//                   trailing: Text(
//                     '1.15.1.2341',
//                     style:
//                         GoogleFonts.roboto(fontSize: 14, color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }

//   // void updateLocale(loc, country, language) {
//   //   var locale = Locale(loc, country);
//   //   controller.appController.language.value = language;
//   //   Get.find<SharedPreferences>().setString(StorageConstants.locale, '$loc#$country#$language');
//   //   Get.updateLocale(locale);
//   //   Get.back();
//   // }

//   Future openBrowserUrl({
//     required String url,
//     bool inApp = false,
//   }) async {
//     if (await canLaunch(url)) {
//       await launch(
//         url,
//         forceSafariVC: inApp,
//         forceWebView: inApp,
//         enableJavaScript: true,
//       );
//     }
//   }
// }