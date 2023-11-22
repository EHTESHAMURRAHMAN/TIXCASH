import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_child_view.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'transaction_history_controller.dart';

class TransactionHistoryView extends GetView<TransactionHistoryController> {
  const TransactionHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.initValue();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Transaction History'.tr.toUpperCase(),
          style: GoogleFonts.roboto(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            child: Container(
              color: Colors.white,
              child: SizedBox(
                width: SizeConfig().screenWidth * 0.35,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_upward,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Send'.tr.toUpperCase(),
                      style: GoogleFonts.roboto(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              var mController = Get.find<SendTyvController>();
              mController.currencyResponse.value =
                  controller.currencyResponse.value;
              Get.toNamed(Routes.SEND_TYV, arguments: [
                {'currency': controller.currencyResponse.value}
              ])?.then((value) {
                if (value == null) return;
                // double amount = value['amount'];
                controller.getTransactionList();
                controller.checkFund();
              });
              mController.controllerReceiver.clear();
              mController.controllerAmount.clear();
            },
          ),

          GestureDetector(
            child: Container(
              color: Colors.white,
              child: SizedBox(
                width: SizeConfig().screenWidth * 0.35,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Receive'.tr.toUpperCase(),
                      style: GoogleFonts.roboto(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            onTap: () => Get.to(() => ScanQRChild(
                  hasActionBar: true,
                  currencyResponse: controller.currencyResponse.value,
                )),
          ),

          // Container(width: SizeConfig().screenWidth*0.35,),
          // TextButton.icon(onPressed: (){
          //   Get.toNamed(Routes.SEND_TYV, arguments: [{'currency': controller.currencyResponse.value}])?.then((value){
          //     controller.getTransactionList();
          //   });
          // }, icon: const Icon(Icons.arrow_upward, color: Colors.white,),
          //   label: const Text('SEND', style: TextStyle(color: Colors.white),),),
          // TextButton.icon(
          //     onPressed: () => Get.to(() => const ScanQRChild(hasActionBar: true,)),
          //     icon: const Icon(Icons.arrow_downward, color: Colors.white,),
          //     label: const Text('RECEIVE', style: TextStyle(color: Colors.white))),
        ],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          // controller.appController.walletBalance(context, controller.currencyResponse.value?.currency, 'transaction_history'),
          // Obx(() => controller.appController.currencyWalletBalance(context, controller.currencyResponse.value!),),

          walletBalance(
              context,
              controller.currencyResponse.value?.currency ?? 'LINE',
              controller.currencyResponse.value?.icon ?? 'line@2x.png',
              'transaction_history'),

          Container(
            decoration: BoxDecoration(
                // gradient: ColorConstants.gradient,
                color: ColorConstants.secondaryDarkAppColor,
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Transaction'.tr.toUpperCase(),
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
                // Expanded(child: SizedBox()),
                const Spacer(),
                // Text('Filter'.toUpperCase(), style: TextStyle(fontSize: CommonConstants.normalText),),
                // Icon(Icons.arrow_drop_down, size: 24,),

                PopupMenuButton(
                    child: Row(
                      children: [
                        Text(
                          'Filter'.tr.toUpperCase(),
                          style: GoogleFonts.roboto(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    // icon: const Icon(Icons.arrow_drop_down, size: 24,),
                    itemBuilder: (_) => <PopupMenuItem<String>>[
                          PopupMenuItem<String>(
                              value: 'add', child: Text('Send'.tr)),
                          PopupMenuItem<String>(
                              value: 'trans', child: Text('Receive'.tr)),

                          // PopupMenuItem<String>(child: Text('Added'.tr), value: 'add'),
                          // PopupMenuItem<String>(child: Text('Transfers'.tr), value: 'trans'),
                          // PopupMenuItem<String>(child: Text('Credit'.tr), value: 'cr'),
                          // PopupMenuItem<String>(child: Text('Debit'.tr), value: 'db'),
                        ],
                    onSelected: (val) {
                      print(val);
                      switch (val) {
                        case 'add':
                          controller.transactionListResponseSearch.value =
                              controller.transactionListResponse
                                  .where((p) => p.paymentType.contains('Sent'))
                                  .toList();
                          return;
                        case 'trans':
                          controller.transactionListResponseSearch.value =
                              controller.transactionListResponse
                                  .where((p) => !p.paymentType.contains('Sent'))
                                  .toList();
                          return;
                        case 'cr':
                          controller.transactionListResponseSearch.value =
                              controller.transactionListResponse
                                  .where((p) => p.credit > 0)
                                  .toList();
                          return;
                        case 'db':
                          controller.transactionListResponseSearch.value =
                              controller.transactionListResponse
                                  .where((p) => p.debit > 0)
                                  .toList();
                          return;
                        default:
                          controller.transactionListResponseSearch.value =
                              controller.transactionListResponse
                                  .where((p) => p.paymentType.contains('Add'))
                                  .toList();
                      }
                    })
              ],
            ),
          ),

          Obx(() => controller.transactionListResponseSearch.isNotEmpty
              ? Expanded(
                  child: ListView(
                  children:
                      controller.transactionListResponseSearch.map((element) {
                    return SACellContainer(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    element.toAddress,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    element.transactionDate,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  )
                                ],
                              )),
                              const SizedBox(
                                width: 16,
                              ),
                              //  if (element.paymentType
                              //     .contains('Account Creation'))
                              //   Text(
                              //     '-${element.credit}',
                              //     style: GoogleFonts.roboto(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.red),
                              //   ),
                              // if (element.paymentType
                              //     .contains('Account Creation'))
                              //   Text(
                              //     '-${element.credit}',
                              //     style: GoogleFonts.roboto(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.red),
                              //   ),
                              if (element.paymentType.contains('staking'))
                                Text(
                                  '-${element.credit}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              if (element.paymentType
                                  .contains('Referral INCOME'))
                                Text(
                                  '+${element.credit}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              if (element.paymentType
                                  .contains('Staking Reward'))
                                Text(
                                  '+${element.credit}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              if (element.paymentType.contains('Subscription'))
                                Text(
                                  '-${element.credit}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              if (element.paymentType
                                  .contains('Account Creation'))
                                Text(
                                  '-${element.credit}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              if (element.paymentType.contains('Sent'))
                                Text(
                                  '-${element.credit}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              if (element.paymentType.contains('Received'))
                                Text(
                                  '+${element.credit}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                )
                            ],
                          ),
                          onTap: () {
                            Get.toNamed(Routes.TRANSACTION_DETAIL, arguments: [
                              {'trans': element}
                            ]);
                          },
                        ));
                    /**
          return SACellContainer(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(children: [
            Row(children: [
              LogoBuilder(logoUrl: element.currency),
              const SizedBox(width: 8,),
              Expanded(child: Text(element.currency,)),
              Text(element.transactionDate,),
            ],),

            const Divider(color: Colors.white12,),

            const SizedBox(height: 8,),

                _tradeCell('Trade Type:', element.paymentType),
                _tradeCell('Credit:',  '${element.credit}'),
                _tradeCell('Debit:',  '${element.debit}'),
                _tradeCell('From:',      element.fromAdress),
                _tradeCell('To:',        element.toAddress),
                _tradeCell('Hash:',      element.txthash),

          ],));
              **/
                  }).toList(),
                ))
              : controller.isTransLoaded.value
                  ? Expanded(
                      child: Center(
                          child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: SizeConfig().screenHeight * 0.1,
                            ),
                            Text(
                              'NO TRANSACTION'.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig().screenHeight * 0.05),
                              // child: Image.asset('assets/icons/ic_etherium.png', width: SizeConfig().screenWidth*0.15,),
                              child: LogoBuilder(
                                  logoUrl:
                                      controller.currencyResponse.value?.icon ??
                                          'line@2x.png'),
                            ),
                            GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          ColorConstants.secondaryDarkAppColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  // color: ColorConstants.secondaryDarkAppColor,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: Text(
                                    'RECEIVE FUNDS'.tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(() => ScanQRChild(
                                        currencyResponse:
                                            controller.currencyResponse.value,
                                      ))?.then((value) {
                                    controller.getTransactionList();
                                    controller.getUserFundBalance();
                                  });
                                }),
                          ],
                        )
                      ],
                    )))
                  : const CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _tradeCell(label, value) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: Text(
            label,
            style:
                GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(
          flex: 70,
          child: Text(
            value,
            style:
                GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w400),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget walletBalance(context, currency, logo, screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LogoBuilder(logoUrl: logo),
              const SizedBox(
                width: 8,
              ),
              Row(
                children: [
                  Obx(() => controller.appController.currency.value == 'EUR'
                      ? Text(
                          (controller.fundBalance *
                                  double.parse(
                                      '${controller.homecontroller.worldCurrency.value?.EUR ?? 0.0}'))
                              .toStringAsFixed(4),
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ))
                      : controller.appController.currency.value == 'CNY'
                          ? Text(
                              (controller.fundBalance *
                                      double.parse(
                                          '${controller.homecontroller.worldCurrency.value?.CNY ?? 0.0}'))
                                  .toStringAsFixed(4),
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ))
                          : controller.appController.currency.value == 'RUB'
                              ? Text(
                                  (controller.fundBalance *
                                          double.parse(
                                              '${controller.homecontroller.worldCurrency.value?.RUB ?? 0.0}'))
                                      .toStringAsFixed(4),
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ))
                              : controller.appController.currency.value == 'JPY'
                                  ? Text(
                                      (controller.fundBalance *
                                              double.parse(
                                                  '${controller.homecontroller.worldCurrency.value?.JPY ?? 0.0}'))
                                          .toStringAsFixed(4),
                                      style: GoogleFonts.roboto(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ))
                                  : controller.appController.currency.value ==
                                          'HKD'
                                      ? Text(
                                          (controller.fundBalance *
                                                  double.parse(
                                                      '${controller.homecontroller.worldCurrency.value?.HKD ?? 0.0}'))
                                              .toStringAsFixed(4),
                                          style: GoogleFonts.roboto(
                                            fontSize: 24,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ))
                                      : controller.appController.currency
                                                  .value ==
                                              'GBP'
                                          ? Text(
                                              (controller.fundBalance *
                                                      double.parse(
                                                          '${controller.homecontroller.worldCurrency.value?.GBP ?? 0.0}'))
                                                  .toStringAsFixed(4),
                                              style: GoogleFonts.roboto(
                                                fontSize: 24,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ))
                                          : Text('${controller.fundBalance}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 24,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ))),
                  // Obx(() => Text('${controller.fundBalance}',
                  //     style: GoogleFonts.roboto(
                  //       fontSize: 24,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w600,
                  //     ))),
                  const SizedBox(width: 8),
                  Obx(() => controller.appController.currency.value == 'EUR'
                      ? Text('€${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.EUR ?? 0.0}')).toStringAsFixed(4)}',
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF40C4FF)))
                      : controller.appController.currency.value == 'CNY'
                          ? Text('¥${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.CNY ?? 0.0}')).toStringAsFixed(4)}',
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF40C4FF)))
                          : controller.appController.currency.value == 'RUB'
                              ? Text('₽${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.RUB ?? 0.0}')).toStringAsFixed(4)}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF40C4FF)))
                              : controller.appController.currency.value == 'JPY'
                                  ? Text(
                                      '¥${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.JPY ?? 0.0}')).toStringAsFixed(4)}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF40C4FF)))
                                  : controller.appController.currency.value ==
                                          'HKD'
                                      ? Text(
                                          'HK\$${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.HKD ?? 0.0}')).toStringAsFixed(4)}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF40C4FF)))
                                      : controller.appController.currency.value ==
                                              'GBP'
                                          ? Text(
                                              '£${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.GBP ?? 0.0}')).toStringAsFixed(4)}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xFF40C4FF)))
                                          : Text(
                                              '\$${controller.fundBalanceUSDT}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xFF40C4FF)))),
                  // Obx(() => Text('\$${controller.fundBalanceUSDT}',
                  //     style: GoogleFonts.roboto(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w300,
                  //         color: const Color(0xFF40C4FF)))),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Obx(() => controller.isBalanceLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    )
                  : const SizedBox()),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );

/*    print('$screen => Sending currency =>  $currency');
    return FutureBuilder(
        future: userFundbalanceAPI(userInfo!.id, currency),
        builder: (context, AsyncSnapshot<ApiResponse>snapshot){

          if(!snapshot.hasData) return const SizedBox();
          ApiResponse response = snapshot.data!;
          double fundBalance = 0.0;
          double fundBalanceUSDT = 0.0;

          if(response.status){
            fundBalance = double.parse(response.data['totalAmount']);
            fundBalanceUSDT = double.parse(response.data['usdAmount']);
          }
      return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('$currency'.tr.toUpperCase(), style: GoogleFonts.roboto(
            //   fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF40C4FF),),),
            // const SizedBox(height: 8,),
            Row(children: [
              LogoBuilder(logoUrl: currency),
              const SizedBox(width: 8,),
              Row(children: [
               Text('$fundBalance', style: GoogleFonts.roboto(
                  fontSize: 24, fontWeight: FontWeight.w600,)),
                const SizedBox(width: 4,),
                Text('\$$fundBalanceUSDT', style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.w300, color: const Color(0xFF40C4FF))),
              ],),
            ],),
            const SizedBox(height: 16,),
          ],),);
    });*/
  }
}
