//
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tixcash/pages/dashboard/bottom_navigation/bottom_view.dart';
// import 'package:tixcash/pages/dashboard/home_navigation/home_navigation_view.dart';
// import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_child_view.dart';
// import 'package:tixcash/routes/app_pages.dart';
// import 'package:tixcash/shared/shared.dart';
//
// import 'home_controller.dart';
//
// class HomeView extends GetView<HomeController> {
//   const HomeView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var mcontroller = Get.isRegistered<HomeController>()
//         ? Get.find<HomeController>()
//         : Get.put(HomeController());
//     Size size = MediaQuery.of(context).size;
//     SizeConfig().init(context);
//     return ButtomNavigationView(
//       child: Column(
//         children: [
//           controller.appController.backupWallet(context),
//           const SizedBox(
//             height: 16,
//           ),
//           controller.appController.walletBalance(context),
//           Container(
//             padding: const EdgeInsets.all(8),
//             color: ColorConstants.secondaryDarkAppColor,
//             child: Row(
//               children: [
//                 Text(
//                   'Coin'.tr,
//                   style: GoogleFonts.roboto(
//                       fontSize: 13, fontWeight: FontWeight.w450),
//                 ),
//                 const Expanded(child: SizedBox()),
//                 Text(
//                   'Balance'.tr,
//                   style: GoogleFonts.roboto(
//                       fontSize: 13, fontWeight: FontWeight.w450),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//               child: RefreshIndicator(
//             child: Obx(() => controller.isCurrencyListResponse.value
//                 ? ListView(
//                     children: controller.currencyListResponse.map((element) {
//                       return Slidable(
//                         // Specify a key if the Slidable is dismissible.
//                         // key: const ValueKey(0),
//                         endActionPane: ActionPane(
//                           motion: const ScrollMotion(),
//                           extentRatio: 1.0,
//                           children: [
//                             Container(
//                               width: SizeConfig().screenWidth * .30,
//                               height: double.infinity,
//                               alignment: Alignment.center,
//                               child: Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 16,
//                                   ),
//                                   LogoBuilder(logoUrl: element.icon),
//                                   const SizedBox(
//                                     width: 16,
//                                   ),
//                                   Text(
//                                     element.currency,
//                                     style: GoogleFonts.roboto(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w400),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             GestureDetector(
//                               child: Container(
//                                 width: SizeConfig().screenWidth * .35,
//                                 height: double.infinity,
//                                 color: const Color(0xFF3D5AFE),
//                                 alignment: Alignment.center,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     const Icon(Icons.arrow_upward),
//                                     const SizedBox(
//                                       width: 16,
//                                     ),
//                                     Text(
//                                       'Send'.tr,
//                                       style: GoogleFonts.roboto(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w400),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               onTap: () =>
//                                   Get.toNamed(Routes.SEND_TYV, arguments: [
//                                 {'currency': element}
//                               ]),
//                             ),
//                             GestureDetector(
//                               child: Container(
//                                 width: SizeConfig().screenWidth * .35,
//                                 height: double.infinity,
//                                 color: const Color(0xFF3D5AFE),
//                                 alignment: Alignment.center,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     const Icon(Icons.arrow_downward),
//                                     const SizedBox(
//                                       width: 16,
//                                     ),
//                                     Text(
//                                       'Receive'.tr,
//                                       style: GoogleFonts.roboto(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w400),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               onTap: () => Get.to(() => const ScanQRChild()),
//                             ),
//                           ],
//                         ),
//
//                         // The child of the Slidable is what the user sees when the
//                         // component is not dragged.
//                         child: Container(
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                             child: ListTile(
//                               leading: LogoBuilder(logoUrl: element.icon),
//                               title: Text(
//                                 element.currency,
//                                 style: GoogleFonts.roboto(fontSize: 16),
//                               ),
//                               trailing: Text(
//                                 '${element.balance}',
//                                 style: GoogleFonts.roboto(fontSize: 18),
//                               ),
//                               onTap: () {
//                                 Get.toNamed(Routes.TRANSACTION_HISTORY,
//                                     arguments: [
//                                       {'currency': element}
//                                     ])?.then((value) {
//                                   controller.getBalanceCurrencyList();
//                                 });
//                               },
//                             ),
//                             decoration: const BoxDecoration(
//                                 border: Border(
//                                     bottom:
//                                         BorderSide(color: Colors.white24)))),
//                       );
//                     }).toList(),
//                   )
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   )),
//             onRefresh: controller.getBalanceCurrencyList,
//           ))
//         ],
//       ),
//     );
//   }
//
//   void doNothing() {}
// }
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/pages/dashboard/dashboard_file/Receive_List.dart';
import 'package:tixcash/pages/dashboard/dashboard_file/Send_List.dart';
import 'package:tixcash/pages/dashboard/dashboard_file/dashboard_controller.dart';
import 'package:tixcash/pages/dashboard/dashboard_file/market_web.dart';
import 'package:tixcash/pages/dashboard/tabs/d_apps/d_apps_view.dart';
//import 'package:tixcash/pages/dashboard/send_tyv/send_tyv_view.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_view.dart';
// import 'package:tixcash/pages/dashboard/settings/settings_view.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/settings_view.dart';
import 'package:tixcash/pages/dashboard/tabs/swap/swap_view.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _bottomnavigationbarState();
}

class _bottomnavigationbarState extends State<DashboardView> {
  DashboardController controller = Get.put(DashboardController());
  int currentTab = 0;
  // ignore: non_constant_identifier_names
  final List<Widget> Sceens = [
    const HomeView(),
    const DAppsView(),
    const marketq(),
    const explore(),
    SettingsView(),
  ];

  //

  Widget currentScreen = const HomeView();
//
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),

        //
        bottomNavigationBar: BottomAppBar(
          height: 60,
          color: Colors.white,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(
                    () {
                      currentScreen = const HomeView();
                      currentTab = 1;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_balance_wallet,
                        size: 19,
                        color: currentTab == 1
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    const SizedBox(height: 4),
                    Text(
                      'Wallet'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          color: currentTab == 1
                              ? Theme.of(context).primaryColor
                              : Colors.grey),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(
                    () {
                      currentScreen = const DAppsView();
                      currentTab = 2;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(CupertinoIcons.doc_append,
                        size: 19,
                        color: currentTab == 2
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    const SizedBox(height: 4),
                    Text(
                      'dApps',
                      style: TextStyle(
                          fontSize: 14,
                          color: currentTab == 2
                              ? Theme.of(context).primaryColor
                              : Colors.grey),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(
                    () {
                      currentScreen = const marketq();
                      currentTab = 3;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.line_style,
                        size: 19,
                        color: currentTab == 3
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    const SizedBox(height: 4),
                    Text(
                      'Market'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          color: currentTab == 3
                              ? Theme.of(context).primaryColor
                              : Colors.grey),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(
                    () {
                      currentScreen = const explore();
                      currentTab = 4;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.explore,
                        size: 19,
                        color: currentTab == 4
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    const SizedBox(height: 4),
                    Text(
                      'Explorer'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          color: currentTab == 4
                              ? Theme.of(context).primaryColor
                              : Colors.grey),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(
                    () {
                      currentScreen = SettingsView();
                      currentTab = 5;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.settings,
                        size: 19,
                        color: currentTab == 5
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    const SizedBox(height: 3),
                    Text(
                      'Setting'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          color: currentTab == 5
                              ? Theme.of(context).primaryColor
                              : Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _backPressed() async {
    controller.counter += 1;
    Future.delayed(const Duration(seconds: 1), () {
      controller.counter = 0;
    });
    if (controller.counter == 1) {
      EasyLoading.showToast('Press two times to Exit'.tr,
          toastPosition: EasyLoadingToastPosition.bottom);
    }

    bool isBackEnable = controller.counter >= 2;

    // if(isBackEnable){
    //   controller.appController.isAppInForeground.value = false;
    // }
    return isBackEnable;
    // return controller.counter >=2;
  }
}

// ignore: must_be_immutable
class DashboardView1 extends GetView<DashboardController> {
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    // isLocalAuth = true;

    Timer(const Duration(seconds: 10), () {
      // isLocalAuth = true;
    });

    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              // onPageChanged: (page){
              //   // controller.bottomAppIndex.value = page;
              //   // controller.pageController.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.linear);
              // },
              children: [
                const HomeView(),
                const DAppsView(),
                const marketq(),
                const explore(),
                SettingsView(),
              ],
            )),
            const BottomAppbarView()
          ],
        ),
      ),
    );
  }

  Future<bool> _backPressed() async {
    controller.counter += 1;
    Future.delayed(const Duration(seconds: 1), () {
      controller.counter = 0;
    });
    if (controller.counter == 1) {
      EasyLoading.showToast('Press two times to Exit',
          toastPosition: EasyLoadingToastPosition.bottom);
    }

    bool isBackEnable = controller.counter >= 2;

    // if(isBackEnable){
    //   controller.appController.isAppInForeground.value = false;
    // }
    return isBackEnable;
    // return controller.counter >=2;
  }

  // DashboardView({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   //appController.getAppVersion(context);
  //   // controller.updateBottomIndex(0);
  //   return WillPopScope(
  //     onWillPop: _backPressed,
  //     child: Scaffold(
  //       backgroundColor: Colors.white,
  //       body: Column(
  //         children: [
  //           Expanded(
  //             child: PageView(
  //               controller: controller.pageController,
  //               physics: const NeverScrollableScrollPhysics(),
  //               children: [
  //                 const HomeView(),
  //                 //const ScanQRChild(),
  //                 //SendTyvView(),
  //                 const DAppsView(),
  //                 SwapView(),

  //                 SettingsView(),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //       bottomNavigationBar: Obx(() => BottomNavigationBar(
  //               backgroundColor: Colors.white,
  //               fixedColor: ColorConstants.secondaryAppColor,
  //               showSelectedLabels: true,
  //               onTap: (index) {
  //                 if (kDebugMode) {
  //                   print('Index => $index');
  //                 }
  //                 controller.updateBottomIndex(index);
  //                 controller.pageController.animateToPage(index,
  //                     duration: const Duration(
  //                       milliseconds: 450,
  //                     ),
  //                     curve: Curves.bounceIn);
  //               },
  //               currentIndex: controller.bottomIndex.value!,
  //               type: BottomNavigationBarType.fixed,
  //               unselectedItemColor: Colors.grey.shade700,
  //               items: [
  //                 BottomNavigationBarItem(
  //                     icon: const Icon(Icons.account_balance_wallet),
  //                     label: 'Wallet'.tr),
  //                 //BottomNavigationBarItem(icon: const Icon(Ionicons.arrow_up_circle), label: 'Receive'.tr),
  //                 //BottomNavigationBarItem(icon: const Icon(Ionicons.arrow_down_circle), label: 'Send'.tr),
  //                 BottomNavigationBarItem(
  //                     icon: const Icon(CupertinoIcons.doc_append),
  //                     label: 'dApps'.tr),
  //                 BottomNavigationBarItem(
  //                     icon: const Icon(Ionicons.swap_horizontal),
  //                     label: 'Swap'.tr),
  //                 BottomNavigationBarItem(
  //                     icon: const Icon(Ionicons.settings_sharp),
  //                     label: 'Setting'.tr),
  //               ])),
  //     ),
  //   );
  // }

  // int counter = 0;

  // Future<bool> _backPressed() async {
  //   counter += 1;
  //   Future.delayed(const Duration(seconds: 1), () {
  //     counter = 0;
  //   });
  //   if (counter == 1) {
  //     EasyLoading.showToast('Press two times to Exit',
  //         toastPosition: EasyLoadingToastPosition.bottom);
  //   }
  //   return counter >= 2;
  // }
}

class BottomAppbarView extends GetView<DashboardController> {
  const BottomAppbarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      color: Colors.white,
      height: 55,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            BottomIconCellBar(0,
                icon: Icons.account_balance_wallet,
                title: 'Wallet'.tr,
                onTap: (val) {}),
            BottomIconCellBar(1,
                icon: CupertinoIcons.doc_append,
                title: 'dApps'.tr,
                onTap: (val) {}),
            BottomIconCellBar(2,
                icon: Icons.line_style, title: 'Market'.tr, onTap: (val) {}),
            BottomIconCellBar(3,
                icon: Icons.explore, title: 'Explorer'.tr, onTap: (val) {}),
            BottomIconCellBar(4,
                icon: Ionicons.settings_sharp,
                title: 'Setting'.tr,
                onTap: (val) {}),
          ]),
          // Positioned(
          //     top: 0,
          // child: FloatingActionButton(
          //     heroTag: 'gift',
          //     onPressed: () => Get.toNamed(Routes.INVITE),
          // backgroundColor: Colors.yellow[800],
          //   child: Image.asset('assets/icons/gift_box.png', width: 32, height: 32,)),
          // )
        ],
      ),
    );
  }
}

class TopMenu extends StatelessWidget {
  TopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.to(Send_List());
          },
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Color(0xff1680ee),
                        size: 22,
                      ),
                    )),
              ),
              const SizedBox(height: 5),
              Text(
                'Send'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(width: 30),
        InkWell(
          onTap: () => Get.to(Receive_List()),
          child: Column(
            children: [
              // Image.asset(
              //       'assets/icons/peer-to-peer.png',
              //       height: 30,
              //
              //     )
              SizedBox(
                height: 50,
                width: 50,
                child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: const Center(
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Color(0xff1680ee),
                        size: 22,
                      ),
                    )),
              ),
              const SizedBox(height: 5),
              Text(
                'Receive'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(width: 30),
        InkWell(
          onTap: () async {
            Get.to(SwapView());
          },
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.arrow_swap,
                        color: Color(0xff1680ee),
                        size: 22,
                      ),
                    )),
              ),
              const SizedBox(height: 5),
              Text(
                'Swap'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     Get.toNamed(Routes.SELECT_COIN);
        //   },
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 40,
        //         width: 40,
        //         child: Card(
        //             elevation: 5,
        //             color: Colors.white,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(18)),
        //             child: const Center(
        //               child: Icon(
        //                 Icons.currency_bitcoin,
        //                 color: Color(0xff1680ee),
        //                 size: 22,
        //               ),
        //             )),
        //       ),
        //       const SizedBox(height: 5),
        //       Text(
        //         'Assets'.tr,
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //     ],
        //   ),
        // ),
        // InkWell(
        //   onTap: () {
        //     EasyLoading.showToast('Launching Soon',
        //         toastPosition: EasyLoadingToastPosition.top);
        //   },
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 40,
        //         width: 40,
        //         child: Card(
        //             elevation: 5,
        //             color: Colors.white,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(18)),
        //             child: const Center(
        //               child: Icon(
        //                 Icons.image,
        //                 color: Color(0xff1680ee),
        //                 size: 22,
        //               ),
        //             )),
        //       ),
        //       const SizedBox(height: 5),
        //       Text(
        //         'NFTs'.tr,
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //     ],
        //   ),
        // ),
        // InkWell(
        //   onTap: () {
        //     Get.to(Send_List());
        //   },
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 40,
        //         width: 40,
        //         child: Card(
        //             elevation: 5,
        //             color: Colors.white,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(18)),
        //             child: Center(
        //                 child: Image.network(
        //                     'https://static.thenounproject.com/png/3890734-200.png',
        //                     height: 30,
        //                     color: Colors.blue))),
        //       ),
        //       const SizedBox(height: 5),
        //       Text(
        //         'DeFi'.tr,
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //     ],
        //   ),
        // ),
        // InkWell(
        //   onTap: () {
        //     // controller.subscriptionResponse.value?.pid == 0
        //     //     ? Get.toNamed(Routes.PREMIUM_VIEW)
        //     //     : Get.toNamed(Routes.STACK);
        //   },
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 45,
        //         width: 45,
        //         child: Card(
        //             elevation: 5,
        //             color: Colors.white,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(15)),
        //             child: const Center(
        //               child: Icon(
        //                 Icons.account_balance,
        //                 color: Color(0xff1680ee),
        //                 size: 22,
        //               ),
        //             )),
        //       ),
        //       const SizedBox(height: 5),
        //       Text(
        //         'Stake'.tr,
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //     ],
        //   ),
        // ),
        // InkWell(
        //   onTap: () async {
        //     // controller.subscriptionResponse.value?.pid == 0
        //     //     ? Get.toNamed(Routes.PREMIUM_VIEW)
        //     //     : Get.toNamed(Routes.REFRAL);
        //   },
        //   child: Column(
        //     children: [
        //       // Image.asset(
        //       //       'assets/icons/list.png',
        //       //       height: 30,
        //       //
        //       //     )
        //       SizedBox(
        //         height: 45,
        //         width: 45,
        //         child: Card(
        //             elevation: 5,
        //             color: Colors.white,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(15)),
        //             child: const Center(
        //               child: Icon(
        //                 Icons.card_giftcard,
        //                 color: Color(0xff1680ee),
        //                 size: 22,
        //               ),
        //             )),
        //       ),
        //       const SizedBox(height: 5),
        //       Text(
        //         'Referal'.tr,
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //     ],
        //   ),
        // ),
      ],
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

class BottomIconCellBar extends GetView<DashboardController> {
  final int index;
  final IconData icon;
  final String title;
  final Offset size;
  final Function(int) onTap;
  const BottomIconCellBar(this.index,
      {Key? key,
      required this.icon,
      required this.title,
      this.size = const Offset(24, 24),
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.bottomAppIndex.value = index;
      },
      child: Obx(() => Column(
            children: [
              Icon(icon,
                  size: 19,
                  color: controller.bottomAppIndex.value == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              const SizedBox(
                height: 4,
              ),
              Text(title,
                  style: TextStyle(
                      fontSize: 14,
                      color: controller.bottomAppIndex.value == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey))
            ],
          )),
    );
  }
}

// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_slidable/flutter_slidable.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:tixcash/pages/dashboard/bottom_navigation/bottom_view.dart';
// // import 'package:tixcash/pages/dashboard/home_navigation/home_navigation_view.dart';
// // import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_child_view.dart';
// // import 'package:tixcash/routes/app_pages.dart';
// // import 'package:tixcash/shared/shared.dart';
// //
// // import 'home_controller.dart';
// //
// // class HomeView extends GetView<HomeController> {
// //   const HomeView({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var mcontroller = Get.isRegistered<HomeController>()
// //         ? Get.find<HomeController>()
// //         : Get.put(HomeController());
// //     Size size = MediaQuery.of(context).size;
// //     SizeConfig().init(context);
// //     return ButtomNavigationView(
// //       child: Column(
// //         children: [
// //           controller.appController.backupWallet(context),
// //           const SizedBox(
// //             height: 16,
// //           ),
// //           controller.appController.walletBalance(context),
// //           Container(
// //             padding: const EdgeInsets.all(8),
// //             color: ColorConstants.secondaryDarkAppColor,
// //             child: Row(
// //               children: [
// //                 Text(
// //                   'Coin'.tr,
// //                   style: GoogleFonts.roboto(
// //                       fontSize: 13, fontWeight: FontWeight.w450),
// //                 ),
// //                 const Expanded(child: SizedBox()),
// //                 Text(
// //                   'Balance'.tr,
// //                   style: GoogleFonts.roboto(
// //                       fontSize: 13, fontWeight: FontWeight.w450),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Expanded(
// //               child: RefreshIndicator(
// //             child: Obx(() => controller.isCurrencyListResponse.value
// //                 ? ListView(
// //                     children: controller.currencyListResponse.map((element) {
// //                       return Slidable(
// //                         // Specify a key if the Slidable is dismissible.
// //                         // key: const ValueKey(0),
// //                         endActionPane: ActionPane(
// //                           motion: const ScrollMotion(),
// //                           extentRatio: 1.0,
// //                           children: [
// //                             Container(
// //                               width: SizeConfig().screenWidth * .30,
// //                               height: double.infinity,
// //                               alignment: Alignment.center,
// //                               child: Row(
// //                                 children: [
// //                                   const SizedBox(
// //                                     width: 16,
// //                                   ),
// //                                   LogoBuilder(logoUrl: element.icon),
// //                                   const SizedBox(
// //                                     width: 16,
// //                                   ),
// //                                   Text(
// //                                     element.currency,
// //                                     style: GoogleFonts.roboto(
// //                                         fontSize: 16,
// //                                         fontWeight: FontWeight.w400),
// //                                   )
// //                                 ],
// //                               ),
// //                             ),
// //                             GestureDetector(
// //                               child: Container(
// //                                 width: SizeConfig().screenWidth * .35,
// //                                 height: double.infinity,
// //                                 color: const Color(0xFF3D5AFE),
// //                                 alignment: Alignment.center,
// //                                 child: Row(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   children: [
// //                                     const Icon(Icons.arrow_upward),
// //                                     const SizedBox(
// //                                       width: 16,
// //                                     ),
// //                                     Text(
// //                                       'Send'.tr,
// //                                       style: GoogleFonts.roboto(
// //                                           fontSize: 13,
// //                                           fontWeight: FontWeight.w400),
// //                                     )
// //                                   ],
// //                                 ),
// //                               ),
// //                               onTap: () =>
// //                                   Get.toNamed(Routes.SEND_TYV, arguments: [
// //                                 {'currency': element}
// //                               ]),
// //                             ),
// //                             GestureDetector(
// //                               child: Container(
// //                                 width: SizeConfig().screenWidth * .35,
// //                                 height: double.infinity,
// //                                 color: const Color(0xFF3D5AFE),
// //                                 alignment: Alignment.center,
// //                                 child: Row(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   children: [
// //                                     const Icon(Icons.arrow_downward),
// //                                     const SizedBox(
// //                                       width: 16,
// //                                     ),
// //                                     Text(
// //                                       'Receive'.tr,
// //                                       style: GoogleFonts.roboto(
// //                                           fontSize: 13,
// //                                           fontWeight: FontWeight.w400),
// //                                     )
// //                                   ],
// //                                 ),
// //                               ),
// //                               onTap: () => Get.to(() => const ScanQRChild()),
// //                             ),
// //                           ],
// //                         ),
// //
// //                         // The child of the Slidable is what the user sees when the
// //                         // component is not dragged.
// //                         child: Container(
// //                             padding: const EdgeInsets.symmetric(vertical: 8),
// //                             child: ListTile(
// //                               leading: LogoBuilder(logoUrl: element.icon),
// //                               title: Text(
// //                                 element.currency,
// //                                 style: GoogleFonts.roboto(fontSize: 16),
// //                               ),
// //                               trailing: Text(
// //                                 '${element.balance}',
// //                                 style: GoogleFonts.roboto(fontSize: 18),
// //                               ),
// //                               onTap: () {
// //                                 Get.toNamed(Routes.TRANSACTION_HISTORY,
// //                                     arguments: [
// //                                       {'currency': element}
// //                                     ])?.then((value) {
// //                                   controller.getBalanceCurrencyList();
// //                                 });
// //                               },
// //                             ),
// //                             decoration: const BoxDecoration(
// //                                 border: Border(
// //                                     bottom:
// //                                         BorderSide(color: Colors.white24)))),
// //                       );
// //                     }).toList(),
// //                   )
// //                 : const Center(
// //                     child: CircularProgressIndicator(),
// //                   )),
// //             onRefresh: controller.getBalanceCurrencyList,
// //           ))
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void doNothing() {}
// // }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:get/get.dart';
// import 'package:tixcash/app_controller.dart';
// import 'package:tixcash/pages/dashboard/dashboard_file/Receive_List.dart';
// import 'package:tixcash/pages/dashboard/dashboard_file/Send_List.dart';
// import 'package:tixcash/pages/dashboard/dashboard_file/dashboard_controller.dart';
// import 'package:tixcash/pages/dashboard/tabs/d_apps/d_apps_view.dart';
// //import 'package:tixcash/pages/dashboard/send_tyv/send_tyv_view.dart';
// import 'package:tixcash/pages/dashboard/tabs/home/home_view.dart';
// // import 'package:tixcash/pages/dashboard/settings/settings_view.dart';
// import 'package:tixcash/pages/dashboard/tabs/settings/settings_view.dart';
// import 'package:tixcash/pages/dashboard/tabs/swap/swap_view.dart';
// import 'package:tixcash/shared/constants/colors.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// // ignore: must_be_immutable
// class DashboardView extends GetView<DashboardController> {
//   final AppController appController = Get.find<AppController>();

//   DashboardView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //appController.getAppVersion(context);
//     // controller.updateBottomIndex(0);
//     return WillPopScope(
//       onWillPop: _backPressed,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: controller.pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   const HomeView(),
//                   //const ScanQRChild(),
//                   //SendTyvView(),
//                   const DAppsView(),
//                   SwapView(),

//                   SettingsView(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: Obx(() => BottomNavigationBar(
//                 backgroundColor: Colors.white,
//                 fixedColor: ColorConstants.secondaryAppColor,
//                 showSelectedLabels: true,
//                 onTap: (index) {
//                   if (kDebugMode) {
//                     print('Index => $index');
//                   }
//                   controller.updateBottomIndex(index);
//                   controller.pageController.animateToPage(index,
//                       duration: const Duration(
//                         milliseconds: 450,
//                       ),
//                       curve: Curves.ease);
//                 },
//                 currentIndex: controller.bottomIndex.value!,
//                 type: BottomNavigationBarType.fixed,
//                 unselectedItemColor: Colors.grey.shade700,
//                 items: [
//                   BottomNavigationBarItem(
//                       icon: const Icon(Icons.account_balance_wallet),
//                       label: 'Wallet'.tr),
//                   //BottomNavigationBarItem(icon: const Icon(Ionicons.arrow_up_circle), label: 'Receive'.tr),
//                   //BottomNavigationBarItem(icon: const Icon(Ionicons.arrow_down_circle), label: 'Send'.tr),
//                   BottomNavigationBarItem(
//                       icon: const Icon(CupertinoIcons.doc_append),
//                       label: 'dApps'.tr),
//                   BottomNavigationBarItem(
//                       icon: const Icon(Ionicons.swap_horizontal),
//                       label: 'Swap'.tr),
//                   BottomNavigationBarItem(
//                       icon: const Icon(Ionicons.settings_sharp),
//                       label: 'Setting'.tr),
//                 ])),
//       ),
//     );
//   }

//   int counter = 0;

//   Future<bool> _backPressed() async {
//     counter += 1;
//     Future.delayed(const Duration(seconds: 1), () {
//       counter = 0;
//     });
//     if (counter == 1) {
//       EasyLoading.showToast('Press two times to Exit',
//           toastPosition: EasyLoadingToastPosition.bottom);
//     }
//     return counter >= 2;
//   }
// }

// class TopMenu extends StatelessWidget {
//   const TopMenu({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         InkWell(
//           onTap: () {
//             Get.to(Send_List());
//           },
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 45,
//                 width: 45,
//                 child: Card(
//                     elevation: 5,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     child: const Center(
//                       child: Icon(
//                         Icons.send,
//                         color: Color(0xff1680ee),
//                         size: 22,
//                       ),
//                     )),
//               ),
//               const SizedBox(height: 5),
//               const Text(
//                 'Send',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () => Get.to(Receive_List()),
//           child: Column(
//             children: [
//               // Image.asset(
//               //       'assets/icons/peer-to-peer.png',
//               //       height: 30,
//               //
//               //     )
//               SizedBox(
//                 height: 45,
//                 width: 45,
//                 child: Card(
//                     elevation: 5,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     child: const Center(
//                       child: Icon(
//                         Icons.account_balance_wallet,
//                         color: Color(0xff1680ee),
//                         size: 22,
//                       ),
//                     )),
//               ),
//               const SizedBox(height: 5),
//               const Text(
//                 'Receive',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () async {
//             //launchUrlString('https://coinmarketcap.com/', mode: LaunchMode.externalApplication);
//             const url = 'https://coinmarketcap.com/';
//             openBrowserUrl(url: url, inApp: true);
//           },
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 45,
//                 width: 45,
//                 child: Card(
//                     elevation: 5,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     child: const Center(
//                       child: Icon(
//                         Icons.line_style,
//                         color: Color(0xff1680ee),
//                         size: 22,
//                       ),
//                     )),
//               ),
//               const SizedBox(height: 5),
//               const Text(
//                 'Market',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () async {},
//           child: Column(
//             children: [
//               // Image.asset(
//               //       'assets/icons/list.png',
//               //       height: 30,
//               //
//               //     )
//               SizedBox(
//                 height: 45,
//                 width: 45,
//                 child: Card(
//                     elevation: 5,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     child: const Center(
//                       child: Icon(
//                         Icons.account_balance,
//                         color: Color(0xff1680ee),
//                         size: 22,
//                       ),
//                     )),
//               ),
//               const SizedBox(height: 5),
//               const Text(
//                 'Earn',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

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
