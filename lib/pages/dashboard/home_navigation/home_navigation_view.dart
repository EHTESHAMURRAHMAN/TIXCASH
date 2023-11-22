import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_navigation_controller.dart';

class HomeNavigationView extends GetView<HomeNavigationController> {
  final Widget child;
  final List<Widget>? actions;

  const HomeNavigationView({Key? key, required this.child, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    controller.appController.userFundBalance(currency: 'TIX');
    return WillPopScope(
        onWillPop: _backPressed,
        child: AdvancedDrawer(
          backdropColor: const Color(0xFF1680ee),
          controller: controller.advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            // NOTICE: Uncomment if you want to add shadow behind the page.
            // Keep in mind that it may cause animation jerks.
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: SafeArea(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              selectedColor: const Color(0xFF40C4FF),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
                    child: Text("TIX WALLET".tr.toUpperCase(),
                        style: GoogleFonts.kodchasan(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold))),
                  ),
                  Obx(() => ListTile(
                        onTap: () =>
                            controller.navigateToScreen(HomeIndex.myWallet),
                        // leading: const Icon(Icons.home),
                        title: Text(
                          'My Wallet'.tr.toUpperCase(),
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal)),
                        ),
                        selected: controller.currentSelected.value ==
                            HomeIndex.myWallet,
                      )),

                  Obx(() => ListTile(
                        onTap: () =>
                            controller.navigateToScreen(HomeIndex.scanQr),
                        // leading: const Icon(Icons.qr_code),
                        title: Text('RECEIVE TIX'.tr.toUpperCase(),
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal))),
                        selected: controller.currentSelected.value ==
                            HomeIndex.scanQr,
                      )),

                  Obx(() => ListTile(
                        onTap: () =>
                            controller.navigateToScreen(HomeIndex.tyvScan),
                        title: Text('TIX Scan'.tr.toUpperCase(),
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal))),
                        selected: controller.currentSelected.value ==
                            HomeIndex.tyvScan,
                      )),

                  Obx(() => ListTile(
                        onTap: () =>
                            controller.navigateToScreen(HomeIndex.tyvMarket),
                        title: Text('TIX Market'.tr.toUpperCase(),
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal))),
                        selected: controller.currentSelected.value ==
                            HomeIndex.tyvMarket,
                      )),

                  Obx(() => ListTile(
                        onTap: () => controller
                            .navigateToScreen(HomeIndex.contactSupport),
                        title: Text('Contact Support'.tr.toUpperCase(),
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal))),
                        selected: controller.currentSelected.value ==
                            HomeIndex.contactSupport,
                      )),

                  Obx(() => ListTile(
                        onTap: () =>
                            controller.navigateToScreen(HomeIndex.settings),
                        title: Text('SETTINGS'.tr.toUpperCase(),
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal))),
                        selected: controller.currentSelected.value ==
                            HomeIndex.settings,
                      )),

                  const Spacer(),

                  ListTile(
                    onTap: () {
                      postMessage(deviceId ?? '', 'TIX Wallet',
                          'Message from TIX Wallet');
                    },
                    title: Text(''.tr.toUpperCase(),
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal))),
                    selected:
                        controller.currentSelected.value == HomeIndex.settings,
                  )
                  // DefaultTextStyle(
                  //   style: const TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.white54,
                  //   ),
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(
                  //       vertical: 16.0,
                  //     ),
                  //     alignment: Alignment.center,
                  //     child:  Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //       GestureDetector(child:  Text('Terms of Service'.tr), onTap: (){
                  //         launch('http://syncadmin.bittgc.io/termsconditions.html');
                  //       },),
                  //       const Text(' | '),
                  //       GestureDetector(child:  Text('Privacy Policy'.tr), onTap: (){
                  //         launch('http://syncadmin.bittgc.io/peivacyPolicy.html');
                  //       },),
                  //     ],),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Obx(() => Text(
                      controller.title.value.tr.toUpperCase(),
                      style: GoogleFonts.roboto(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                leading: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: controller.advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                ),
                actions: actions ?? controller.actions,
              ),
              body: child),
        ));
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    controller.advancedDrawerController.value = AdvancedDrawerValue.visible();
    controller.advancedDrawerController.showDrawer();
  }

  Future<bool> _backPressed() async {
    printInfo(
        info:
            'drawaer info: ${controller.advancedDrawerController.value.visible}');
    // if(controller.currentSelected.value==HomeIndex.settings){
    if (!controller.advancedDrawerController.value.visible) {
      controller.advancedDrawerController.showDrawer();
      return false;
    }

    // }
    controller.counter += 1;
    Future.delayed(const Duration(seconds: 1), () {
      controller.counter = 0;
    });
    if (controller.counter == 1) {
      EasyLoading.showToast('Press two times to Exit'.tr,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    return controller.counter >= 2;
  }
}
