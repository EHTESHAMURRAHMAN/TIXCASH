import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/pages/dashboard/dashboard_file/dashboard_view.dart';
import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_child_view_cur.dart';
import 'package:tixcash/pages/dashboard/tabs/home/bottom_sheet.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff1680ee),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: const Color(0xff1680ee),
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      showFlexibleBottomSheet(
                        bottomSheetBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        minHeight: 0,
                        initHeight: 0.5,
                        maxHeight: 1,
                        context: context,
                        builder: _buildBottomSheet,
                        anchors: [0, 0.5, 1],
                        isSafeArea: true,
                      );
                    },
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                    )),
                Obx(() => Text(controller.accountName.value,
                    style: GoogleFonts.roboto(
                        fontSize: 14, fontWeight: FontWeight.w300))),
                const Spacer(),
                const Icon(Icons.notifications, size: 25)
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xff1680ee),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/icons/logo.png'))),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.center,
                child: Text(
                  'Total Balance'.tr,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => controller.appController.currency.value == 'EUR'
                      ? Text(
                          '€ ${controller.isShowBalance.value ? '••••••' : controller.totalEUR.value.toStringAsFixed(4)}',
                          maxLines: 1,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        )
                      : controller.appController.currency.value == 'CNY'
                          ? Text(
                              '¥ ${controller.isShowBalance.value ? '••••••' : controller.totalCNY.value.toStringAsFixed(4)}',
                              maxLines: 1,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            )
                          : controller.appController.currency.value == 'RUB'
                              ? Text(
                                  '₽ ${controller.isShowBalance.value ? '••••••' : controller.totalRUB.value.toStringAsFixed(4)}',
                                  maxLines: 1,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                )
                              : controller.appController.currency.value == 'JPY'
                                  ? Text(
                                      '¥ ${controller.isShowBalance.value ? '••••••' : controller.totalJPY.value.toStringAsFixed(4)}',
                                      maxLines: 1,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.white),
                                    )
                                  : controller.appController.currency.value ==
                                          'HKD'
                                      ? Text(
                                          'HK\$ ${controller.isShowBalance.value ? '••••••' : controller.totalHKD.value.toStringAsFixed(4)}',
                                          maxLines: 1,
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Colors.white),
                                        )
                                      : controller.appController.currency
                                                  .value ==
                                              'GBP'
                                          ? Text(
                                              '£ ${controller.isShowBalance.value ? '••••••' : controller.totalGBP.value.toStringAsFixed(4)}',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              '\$${controller.isShowBalance.value ? '••••••' : controller.totalUSD.value.toStringAsFixed(4)}',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  color: Colors.white),
                                            )),
                  // Text(
                  //   '\$'.tr,
                  //   style: GoogleFonts.roboto(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 33,
                  //       color: Colors.white),
                  // ),
                  // const SizedBox(width: 3),
                  // Obx(() => Text(
                  //       controller.isShowBalance.value
                  //           ? '••••••'
                  //           : controller.totalUSD.value.toStringAsFixed(4),
                  //       style: GoogleFonts.roboto(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 30,
                  //           color: Colors.white),
                  //     )),
                  const SizedBox(width: 10),
                  InkWell(
                    child: Obx(() => Icon(
                          controller.isShowBalance.value
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye_fill,
                          color: controller.isShowBalance.value
                              ? Colors.white
                              : Colors.white,
                          size: 22,
                        )),
                    onTap: () {
                      controller.isShowBalance.value =
                          !controller.isShowBalance.value;
                    },
                  )
                ],
              ),

              // Obx(() => controller.isBalanceLoading.value
              //     ? const SizedBox(
              //         width: 20,
              //         height: 20,
              //         child: CircularProgressIndicator(
              //           color: Colors.white,
              //           strokeWidth: 1,
              //         ),
              //       )
              //     : const SizedBox()),
              // controller.appController.backupWallet(context),
              const SizedBox(
                height: 30,
              ),
              TopMenu(),
              // const SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.only(right: 15),
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: TextButton.icon(
              //         onPressed: () {
              //           Get.toNamed(Routes.SELECT_COIN);
              //         },
              //         icon: const Icon(Icons.add_box, color: Colors.white),
              //         label: Text('Add Tokens'.tr,
              //             style: GoogleFonts.roboto(
              //                 fontSize: 14, color: Colors.white))),
              //   ),
              // )
              // controller.appController.walletBalance(context, 'LINE', 'Home_view'),
              //const HomeHeader(),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   color: ColorConstants.secondaryDarkAppColor,
              //   child: Row(
              //     children: [
              //       Text(
              //         'Coin'.tr,
              //         style: GoogleFonts.roboto(
              //             fontSize: 13, fontWeight: FontWeight.w500),
              //       ),
              //       const Expanded(child: SizedBox()),
              //       Text(
              //         'Balance'.tr,
              //         style: GoogleFonts.roboto(
              //             fontSize: 13, fontWeight: FontWeight.w500),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height / 2,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    EasyLoading.showToast('Launching Soon'.tr,
                        toastPosition: EasyLoadingToastPosition.top);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 50,
                        child: Card(
                            elevation: 5,
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: const Center(
                              child: Icon(
                                Icons.currency_bitcoin,
                                color: Colors.white,
                                size: 22,
                              ),
                            )),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Assets'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    EasyLoading.showToast('Launching Soon'.tr,
                        toastPosition: EasyLoadingToastPosition.top);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 50,
                        child: Card(
                            elevation: 5,
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 22,
                              ),
                            )),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'NFTs'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    EasyLoading.showToast('Launching Soon'.tr,
                        toastPosition: EasyLoadingToastPosition.top);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 50,
                        child: Card(
                            elevation: 5,
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: Center(
                                child: Image.network(
                              'https://static.thenounproject.com/png/3890734-200.png',
                              height: 30,
                              color: Colors.white,
                            ))),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'DeFi'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: RefreshIndicator(
                  backgroundColor: Colors.white,
                  onRefresh: controller.getBalanceCurrencyList,
                  child: Obx(() => controller.isCurrencyListResponse.value
                      ? ListView(
                          children:
                              controller.currencyListResponse.map((element) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 1.0,
                                children: [
                                  Container(
                                    width: SizeConfig().screenWidth * .30,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        LogoBuilder(logoUrl: element.icon),
                                        Text(
                                          element.currency,
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: SizeConfig().screenWidth * .35,
                                      height: double.infinity,
                                      color: const Color(0xff1680ee),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.arrow_upward),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            'Send'.tr,
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      var mController =
                                          Get.find<SendTyvController>();
                                      mController.currencyResponse.value =
                                          element;
                                      Get.toNamed(Routes.SEND_TYV, arguments: [
                                        {'currency': element}
                                      ])?.then((value) {
                                        controller.getBalanceCurrencyList(
                                            currency: element.currency);
                                      });
                                      /*if(element.currency.toLowerCase() !='line'){
                                            EasyLoading.showToast('Coming soon');
                                          }else {
                                            Get.toNamed(Routes.SEND_TYV, arguments: [{'currency': element}]);
                                          }*/
                                      mController.controllerReceiver.clear();
                                      mController.controllerAmount.clear();
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: SizeConfig().screenWidth * .35,
                                      height: double.infinity,
                                      color: const Color(0xff1680ee),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.arrow_downward),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            'Receive'.tr,
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                    // onTap: () =>
                                    //     Get.toNamed(Routes.SCAN_QR, arguments: [
                                    //       {'currency': element}
                                    //     ]),
                                    // onTap: () => Get.to(() => const ScanQRChild()),
                                    onTap: () {
                                      Get.to(() => ScanQRChildCur(
                                              currencyResponse: element))
                                          ?.then((value) {
                                        controller.getBalanceCurrencyList();
                                      });
                                      /*if(element.currency.toLowerCase() !='line'){
                                          EasyLoading.showToast('Coming soon');
                                        }else {
                                          Get.to(() => ScanQRChildCur(currencyResponse: element));
                                        }*/
                                    },
                                  ),
                                ],
                              ),

                              // The child of the Slidable is what the user sees when the
                              // component is not dragged.
                              child: Container(
                                  //padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.white24))),
                                  child: ListTile(
                                    leading: LogoBuilder(logoUrl: element.icon),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          element.currency,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        Obx(
                                          () => controller.appController
                                                      .currency.value ==
                                                  'EUR'
                                              ? Text(
                                                  '€${(element.price * double.parse('${controller.worldCurrency.value?.EUR ?? 0.0}')).toStringAsFixed(4)}',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              : controller.appController
                                                          .currency.value ==
                                                      'CNY'
                                                  ? Text(
                                                      '¥${(element.price * double.parse('${controller.worldCurrency.value?.CNY ?? 0.0}')).toStringAsFixed(4)}',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  : controller.appController
                                                              .currency.value ==
                                                          'RUB'
                                                      ? Text(
                                                          '₽${(element.price * double.parse('${controller.worldCurrency.value?.RUB ?? 0.0}')).toStringAsFixed(4)}',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        )
                                                      : controller
                                                                  .appController
                                                                  .currency
                                                                  .value ==
                                                              'JPY'
                                                          ? Text(
                                                              '¥${(element.price * double.parse('${controller.worldCurrency.value?.JPY ?? 0.0}')).toStringAsFixed(4)}',
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )
                                                          : controller
                                                                      .appController
                                                                      .currency
                                                                      .value ==
                                                                  'HKD'
                                                              ? Text(
                                                                  'HK\$${(element.price * double.parse('${controller.worldCurrency.value?.HKD ?? 0.0}')).toStringAsFixed(4)}',
                                                                  style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                )
                                                              : controller
                                                                          .appController
                                                                          .currency
                                                                          .value ==
                                                                      'GBP'
                                                                  ? Text(
                                                                      '£${(element.price * double.parse('${controller.worldCurrency.value?.GBP ?? 0.0}')).toStringAsFixed(4)}',
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    )
                                                                  : Text(
                                                                      '\$${element.price.toStringAsFixed(4)}',
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Obx(() => Text(
                                              controller.isShowBalance.value
                                                  ? '••••••'
                                                  : element.balance
                                                      .toStringAsFixed(4),
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            )),
                                        //  '\$${element.usdvalue.toStringAsFixed(3)}',

                                        Obx(
                                          () => controller.appController
                                                      .currency.value ==
                                                  'EUR'
                                              ? Text(
                                                  '€${controller.isShowBalance.value ? '••••••' : (element.usdvalue * double.parse('${controller.worldCurrency.value?.EUR ?? 0.0}')).toStringAsFixed(4)}',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF40C4FF),
                                                  ))
                                              : controller.appController
                                                          .currency.value ==
                                                      'CNY'
                                                  ? Text(
                                                      '¥${controller.isShowBalance.value ? '••••••' : (element.usdvalue * double.parse('${controller.worldCurrency.value?.CNY ?? 0.0}')).toStringAsFixed(4)}',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xFF40C4FF),
                                                      ))
                                                  : controller.appController
                                                              .currency.value ==
                                                          'RUB'
                                                      ? Text(
                                                          '₽${controller.isShowBalance.value ? '••••••' : (element.usdvalue * double.parse('${controller.worldCurrency.value?.RUB ?? 0.0}')).toStringAsFixed(4)}',
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xFF40C4FF),
                                                          ))
                                                      : controller
                                                                  .appController
                                                                  .currency
                                                                  .value ==
                                                              'JPY'
                                                          ? Text(
                                                              '¥${controller.isShowBalance.value ? '••••••' : (element.usdvalue * double.parse('${controller.worldCurrency.value?.JPY ?? 0.0}')).toStringAsFixed(4)}',
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: const Color(
                                                                    0xFF40C4FF),
                                                              ))
                                                          : controller
                                                                      .appController
                                                                      .currency
                                                                      .value ==
                                                                  'HKD'
                                                              ? Text(
                                                                  'HK\$${controller.isShowBalance.value ? '••••••' : (element.usdvalue * double.parse('${controller.worldCurrency.value?.HKD ?? 0.0}')).toStringAsFixed(4)}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: const Color(
                                                                        0xFF40C4FF),
                                                                  ))
                                                              : controller
                                                                          .appController
                                                                          .currency
                                                                          .value ==
                                                                      'GBP'
                                                                  ? Text('£${controller.isShowBalance.value ? '••••••' : (element.usdvalue * double.parse('${controller.worldCurrency.value?.GBP ?? 0.0}')).toStringAsFixed(4)}',
                                                                      style: GoogleFonts.roboto(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: const Color(
                                                                            0xFF40C4FF),
                                                                      ))
                                                                  : Text('\$${controller.isShowBalance.value ? '••••••' : element.usdvalue.toStringAsFixed(4)}',
                                                                      style: GoogleFonts.roboto(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: const Color(
                                                                            0xFF40C4FF),
                                                                      )),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Get.toNamed(Routes.TRANSACTION_HISTORY,
                                          arguments: [
                                            {'currency': element}
                                          ])?.then((value) {
                                        controller.getBalanceCurrencyList();
                                      });
                                    },
                                  )),
                            );
                          }).toList(),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // newWallet(context) {
  //   controller.subscriptionResponse.value?.pid == 0
  //       ? EasyLoading.showToast('Get Premium Access First')
  //       : showFlexibleBottomSheet(
  //           bottomSheetBorderRadius:
  //               const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //           minHeight: 0,
  //           initHeight: 0.5,
  //           maxHeight: 1,
  //           context: context,
  //           builder: _buildBottomSheet,
  //           anchors: [0, 0.5, 1],
  //           isSafeArea: true,
  //         );
  // }

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return BottomSheetView(
      scrollController: scrollController,
      onSelect: () {
        controller.initValues();
        controller.accountName.value = userInfo?.name ?? '';

        Get.back();
      },
    );
  }

  void doNothing() {}
}

// class HomeHeader extends GetView<HomeController> {
//   const HomeHeader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return walletBalance(context);
//   }

//   Widget walletBalance(context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16),
//       child: Row(
//         children: [
//           Expanded(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Total Balance',
//                   style: GoogleFonts.roboto(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w300,
//                       color: const Color(0xFF40C4FF))),
//               Row(
//                 children: [
//                   Obx(() =>
//                       Text('\$${controller.totalUSD.value.toStringAsFixed(4)}',
//                           style: GoogleFonts.roboto(
//                             fontSize: 30,
//                             fontWeight: FontWeight.w700,
//                           ))),
//                   Obx(() => controller.isBalanceLoading.value
//                       ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 1,
//                           ),
//                         )
//                       : const SizedBox()),
//                 ],
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//             ],
//           )),
//           Column(
//             children: [
//               IconButton(
//                   onPressed: () {
//                     showFlexibleBottomSheet(
//                         minHeight: 0,
//                         initHeight: 0.5,
//                         maxHeight: 1,
//                         context: context,
//                         builder: _buildBottomSheet,
//                         anchors: [0, 0.5, 1],
//                         // isSafeArea: true,
//                         isExpand: false);
//                   },
//                   icon: const Icon(
//                     Icons.account_circle_outlined,
//                     size: 40,
//                   )),
//               Obx(() => Text(controller.accountName.value,
//                   style: GoogleFonts.roboto(
//                       fontSize: 14, fontWeight: FontWeight.w300))),
//             ],
//           ),
//           const SizedBox(
//             width: 8,
//           )
//           // const Icon(Icons.more_vert,size: 36,)
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomSheet(
//     BuildContext context,
//     ScrollController scrollController,
//     double bottomSheetOffset,
//   ) {
//     return BottomSheetView(
//       scrollController: scrollController,
//       onSelect: () {
//         controller.initValues();
//         controller.accountName.value = userInfo?.name ?? '';
//         Get.back();
//       },
//     );
//   }
// }
