import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/settings_controller.dart';
import 'package:tixcash/pages/splash/splash_controller.dart';
import 'package:tixcash/pages/splash/start2.dart';

class Startview1 extends GetView<SplashController> {
  Startview1({Key? key}) : super(key: key);

  final SettingsController controller1 = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xff1680ee),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        backgroundColor: const Color(0xff1680ee),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text(
                  //   'Language'.tr,
                  //   style: GoogleFonts.roboto(
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Select Language'.tr,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ListTile(
                                        title: Text('English',
                                            style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: Colors.white,
                                            )),
                                        onTap: () => controller1.updateLocale(
                                            'en', 'US', 'English')),
                                    ListTile(
                                      title: Text('简体中文',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.white,
                                          )),
                                      onTap: () => controller1.updateLocale(
                                          'ch', 'CH', 'Chinese'),
                                    ),
                                    ListTile(
                                      title: Text('ไทย',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.white,
                                          )),
                                      onTap: () => controller1.updateLocale(
                                          'th', 'TH', 'Thai'),
                                    ),
                                    ListTile(
                                      title: Text('Русский',
                                          style:
                                              GoogleFonts.roboto(fontSize: 14)),
                                      onTap: () => controller1.updateLocale(
                                          'ru', 'RU', 'Русский'),
                                    ),
                                    ListTile(
                                      title: Text('日本語',
                                          style:
                                              GoogleFonts.roboto(fontSize: 14)),
                                      onTap: () => controller1.updateLocale(
                                          'jp', 'JP', '日本語'),
                                    ),
                                    ListTile(
                                      title: Text('español',
                                          style:
                                              GoogleFonts.roboto(fontSize: 14)),
                                      onTap: () => controller1.updateLocale(
                                          'sp', 'SP', 'español'),
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          Text(
                            'Language'.tr,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          // Obx(() => Text(
                          //       controller1.appController.language.value.tr,
                          //       style: GoogleFonts.roboto(
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.white,
                          //       ),
                          //     )),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            'assets/SVG_Icons/Ic__arrow_down.svg',
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset('assets/icons/startp1.png'),
              const SizedBox(height: 90),
              Text(
                'Welcome to Tixcash Wallet'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'Your Digital passport'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
              const SizedBox(height: 15),
              Text(
                'Use this wallet to collect and other\napplications running on tixcash Wallet'
                    .tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
        )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30.0),
          child: InkWell(
            onTap: () => Get.to(const Startview2()),
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14), color: Colors.white),
              child: Center(
                child: Text(
                  'Next'.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.blue),
                ),
              ),
            ),
          ),
        ));
  }
}
