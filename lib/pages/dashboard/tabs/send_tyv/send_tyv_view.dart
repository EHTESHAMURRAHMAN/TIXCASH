import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_controller.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/scan_qr.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/DB/db_view.dart';
import 'package:tixcash/shared/shared.dart';
import 'send_tyv_controller.dart';
// import 'package:scan/scan.dart';

class SendTyvView extends GetView<SendTyvController> {
  SendTyvView({Key? key}) : super(key: key);

  StreamController<int> _onPageChange = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.checkIsValid();
    controller.refreshData();
    if (_onPageChange.isClosed) {
      _onPageChange = StreamController<int>.broadcast();
    }

    controller.getUserFundBalance();
    controller.isScanEnable.value = false;
    // controller.result = null;

    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios, size: 20)),
          elevation: 0,
          // backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Text(
                'Send'.tr,
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Obx(() => Text(
                    ' ${controller.currencyResponse.value?.currency}',
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  )),
            ],
          )),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: walletBalance(
                    context,
                    controller.currencyResponse.value?.currency ?? 'LINE',
                    controller.currencyResponse.value?.icon ?? 'line@2x.png',
                    'transaction_history'),
              ),
              Obx(() => controller.sendOption.value
                  ? Column(
                      children: [
                        SizedBox(
                          height: SizeConfig().screenHeight * 0.03,
                        ),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            color: ColorConstants.secondaryDarkAppColor,
                            // width: SizeConfig().screenWidth*0.2,
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig().screenWidth * 0.15,
                                vertical: 8),
                            child: Text(
                              'Send To Tixcash Wallet'.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
                          onTap: () {
                            controller.isSendToWallet.value = true;
                            controller.sendOption.value = false;
                            controller.getCommissionAmount(0);
                          },
                        ),
                        SizedBox(
                          height: SizeConfig().screenHeight * 0.02,
                        ),
                        GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              color: const Color(0xFF1680ee),
                              // margin: EdgeInsets.symmetric(horizontal: SizeConfig().screenWidth*0.15),
                              child: Text('SEND TO EXTERNAL WALLET'.tr,
                                  style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                            ),
                            onTap: () {
                              controller.isSendToWallet.value = false;
                              controller.sendOption.value = false;
                              controller.getCommissionAmount(0);
                            }),
                      ],
                    )
                  : Expanded(
                      child: Column(
                      children: [
                        Expanded(
                            child: ListView(
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  // color: ColorConstants.blackBg,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  child: Column(
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     // const Icon(
                                      //     //   Icons.warning,
                                      //     //   color: Color(0xFFE8501F),
                                      //     //   size: 40,
                                      //     // ),
                                      //     // const SizedBox(
                                      //     //   width: 24,
                                      //     // ),
                                      //     // Expanded(
                                      //     //     child: Text(
                                      //     //   'commission_fee'.tr,
                                      //     //   style: GoogleFonts.roboto(
                                      //     //       fontSize: 13,
                                      //     //       fontWeight: FontWeight.w400,
                                      //     //       color:
                                      //     //           const Color(0xFFE8501F)),
                                      //     // ))
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   height: 24,
                                      // ),
                                      // const Divider(
                                      //   color: Color(0xFF2A2A2A),
                                      // ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      InputIconBox(
                                        hint: 'Receiver address'.tr,
                                        // title: 'input receiving address'.tr,
                                        title: ''.tr,

                                        image: Row(
                                          children: [
                                            GestureDetector(
                                              child: Icon(Icons.person,
                                                  size: 28,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              onTap: () async {
                                                Get.to(AddressBook(checkId: 1))
                                                    ?.then((value) {
                                                  if (value != null) {
                                                    controller
                                                            .controllerReceiver
                                                            .text =
                                                        value['address'];
                                                  }
                                                });
                                              },
                                            ),
                                            const SizedBox(width: 25),
                                            GestureDetector(
                                              child: Text(
                                                'PASTE'.tr,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xFF40C4FF)),
                                              ),
                                              onTap: () async {
                                                ClipboardData? data =
                                                    await Clipboard.getData(
                                                        'text/plain');
                                                controller.controllerReceiver
                                                    .text = data?.text ?? '';
                                              },
                                            ),
                                          ],
                                        ),

                                        //
                                        controller:
                                            controller.controllerReceiver,
                                        onChange: (val) {
                                          controller.checkIsValid();
                                          controller.maxValueCalculate();
                                        },
                                        isScanner: true,
                                        onScan: () {
                                          controller.isScanEnable.value = true;

                                          callOnScan();
                                        },
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      // InputIconBox(hint: '${controller.currencyResponse.value!.currency} amount to send', title: 'input  amount to send',
                                      InputIconBox(
                                        hint: 'amount to send'.trParams({
                                          'name': controller
                                              .currencyResponse.value!.currency
                                        }),
                                        // title: 'input  amount to send'.tr,
                                        title: ''.tr,
                                        image: SvgPicture.asset(
                                          'assets/SVG_Icons/Ic_dollar.svg',
                                          color: const Color(0xFF8B8B8B),
                                        ),
                                        controller: controller.controllerAmount,
                                        onChange: (val) {
                                          controller.checkIsValid();
                                          controller.getCommissionAmount(val);
                                          controller.controllerAmount.text ==
                                              controller.sum.value;
                                          controller.commissionAmount.value +
                                              controller.sum.value;
                                        },
                                        isNumber: true,
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text('Network fee'.tr,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                          const Spacer(),
                                          Obx(() => Text(
                                              '${controller.commissionAmount.value} ${controller.mCurrency.value}',
                                              // '${controller.commissionAmount.value} LINE',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                          'Will be confirmed in 16 confirmations'
                                              .tr,
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),

                                // GestureDetector(
                                //   child: Obx(
                                //       () => controller.qrImagefile.value == null
                                //           ? const Icon(
                                //               Icons.abc,
                                //
                                //               size: 60,
                                //             )
                                //           : Padding(
                                //               padding:
                                //                   const EdgeInsets.symmetric(
                                //                       horizontal: 36),
                                //               child: Image.file(File(controller
                                //                   .qrImagefile.value!.path)),
                                //             )),
                                //   onTap: () async {
                                //     List<dynamic>? val = await controller
                                //         .uploadImage(context, type: 1);
                                //     if (val != null) {
                                //       // controller.selfieImageFile.value = val[0];
                                //       controller.qrImagefile.value =
                                //           XFile(val[0]);
                                //       controller.selfieImage.value = val[1];
                                //     }
                                //   },
                                // ),
                              ],
                            )
                          ],
                        )),
                        controller.isInputValid.value
                            ? InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color:
                                          ColorConstants.secondaryDarkAppColor),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      'Next Step'.tr,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(SendDetails());
                                },
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: const Color(0xFF3E4444),
                                ),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Text(
                                    'Next Step'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )))
            ],
          ),
          // Obx(() => controller.isScanEnable.value ? _scanQRCode(context) : const SizedBox())
        ],
      ),
    );
  }

  callOnScan() async {
    Get.to(const ScanQR())?.then((value) {
      controller.controllerReceiver.text = value;
    });
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
              const SizedBox(
                width: 8,
              ),
              Obx(
                () => controller.isLoadingBalance.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => controller.appController.currency.value ==
                                  'EUR'
                              ? Text(
                                  (controller.fundBalance *
                                          double.parse(
                                              '${controller.homecontroller.worldCurrency.value?.EUR ?? 0.0}'))
                                      .toStringAsFixed(4),
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
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
                                        fontWeight: FontWeight.w600,
                                      ))
                                  : controller.appController.currency.value ==
                                          'RUB'
                                      ? Text(
                                          (controller.fundBalance *
                                                  double.parse(
                                                      '${controller.homecontroller.worldCurrency.value?.RUB ?? 0.0}'))
                                              .toStringAsFixed(4),
                                          style: GoogleFonts.roboto(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ))
                                      : controller.appController.currency.value ==
                                              'JPY'
                                          ? Text(
                                              (controller.fundBalance *
                                                      double.parse('${controller.homecontroller.worldCurrency.value?.JPY ?? 0.0}'))
                                                  .toStringAsFixed(4),
                                              style: GoogleFonts.roboto(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                              ))
                                          : controller.appController.currency.value == 'HKD'
                                              ? Text((controller.fundBalance * double.parse('${controller.homecontroller.worldCurrency.value?.HKD ?? 0.0}')).toStringAsFixed(4),
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                  ))
                                              : controller.appController.currency.value == 'GBP'
                                                  ? Text((controller.fundBalance * double.parse('${controller.homecontroller.worldCurrency.value?.GBP ?? 0.0}')).toStringAsFixed(4),
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))
                                                  : Text('${controller.fundBalance}',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))),
                          // Obx(() => Text('${controller.fundBalance}',
                          //     style: GoogleFonts.roboto(
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold,
                          //           ))),
                          const SizedBox(
                            width: 4,
                          ),
                          Obx(() => controller.appController.currency.value ==
                                  'EUR'
                              ? Text('€ ${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.EUR ?? 0.0}')).toStringAsFixed(4)}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF40C4FF)))
                              : controller.appController.currency.value == 'CNY'
                                  ? Text(
                                      '¥ ${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.CNY ?? 0.0}')).toStringAsFixed(4)}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF40C4FF)))
                                  : controller.appController.currency.value ==
                                          'RUB'
                                      ? Text(
                                          '₽ ${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.RUB ?? 0.0}')).toStringAsFixed(4)}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF40C4FF)))
                                      : controller.appController.currency.value ==
                                              'JPY'
                                          ? Text(
                                              '¥ ${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.JPY ?? 0.0}')).toStringAsFixed(4)}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xFF40C4FF)))
                                          : controller.appController.currency.value == 'HKD'
                                              ? Text('HK\$ ${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.HKD ?? 0.0}')).toStringAsFixed(4)}', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF40C4FF)))
                                              : controller.appController.currency.value == 'GBP'
                                                  ? Text('£ ${(controller.fundBalanceUSDT * double.parse('${controller.homecontroller.worldCurrency.value?.GBP ?? 0.0}')).toStringAsFixed(4)}', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF40C4FF)))
                                                  : Text('\$${controller.fundBalanceUSDT}', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF40C4FF)))),
                          // Obx(() => Text('\$${controller.fundBalanceUSDT}',
                          //     style: GoogleFonts.roboto(
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.bold,
                          //         color: const Color(0xFF40C4FF)))),
                        ],
                      ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class InputIconBox extends StatelessWidget {
  final String hint;
  final String title;
  final Widget image;
  final TextEditingController controller;
  final Function(String) onChange;
  final Function()? onScan;
  final Function()? onEditingComplete;
  final bool isNumber;
  final bool isScanner;

  const InputIconBox(
      {Key? key,
      required this.hint,
      required this.title,
      required this.image,
      required this.controller,
      required this.onChange,
      this.isNumber = false,
      this.isScanner = false,
      this.onScan,
      this.onEditingComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextFormField(
        //     onChanged: (value) {
        //       controller.isActived.value = controller.controllerWords.text.isNotEmpty;
        //     },
        //     controller: controller.controllerWords,
        //     style: GoogleFonts.roboto(fontSize: 16, color: ColorConstants.black),
        //     decoration: InputDecoration(
        //         hintText: 'Enter Private Key'.tr,
        //         hintStyle: const TextStyle(  , fontSize: 12),
        //         labelStyle: const TextStyle(  , fontSize: 12),
        //         label: Text('Enter Private Key'.tr),
        //         enabledBorder: OutlineInputBorder(
        //             borderSide: BorderSide(color: ColorConstants.secondaryAppColor),
        //             borderRadius: BorderRadius.circular(20)),
        //         border: InputBorder.none,
        //         focusedBorder: OutlineInputBorder(
        //             borderSide: BorderSide(color: ColorConstants.secondaryAppColor),
        //             borderRadius: BorderRadius.circular(20))),
        //   )
        SizedBox(
          height: 60,
          child: TextFormField(
            controller: controller,
            onChanged: onChange,
            onEditingComplete: onEditingComplete,
            keyboardType: isNumber
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.secondaryAppColor),
                    borderRadius: BorderRadius.circular(20)),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.secondaryAppColor),
                    borderRadius: BorderRadius.circular(20)),
                hintText: hint,
                labelText: hint,
                hintStyle: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
                labelStyle: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
                suffixIcon: isScanner
                    ? IconButton(
                        onPressed: () {
                          printInfo(info: 'Information center....');
                          onScan!();
                        },
                        icon: Icon(Icons.qr_code,
                            color: Theme.of(context).primaryColor))
                    : image),
          ),
        ),

        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text(title.tr,
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFE8501F))),
            const Spacer(),
            isScanner ? image : const SizedBox()
          ],
        )
      ],
    );
  }
}

class InputIconBox1 extends StatelessWidget {
  final String hint;
  final String title;
  final Widget image;
  final TextEditingController controller;
  final Function(String) onChange;
  final Function()? onScan;
  final Function()? onEditingComplete;
  final bool isNumber;
  final bool isScanner;

  const InputIconBox1(
      {Key? key,
      required this.hint,
      required this.title,
      required this.image,
      required this.controller,
      required this.onChange,
      this.isNumber = false,
      this.isScanner = false,
      this.onScan,
      this.onEditingComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextFormField(
        //     onChanged: (value) {
        //       controller.isActived.value = controller.controllerWords.text.isNotEmpty;
        //     },
        //     controller: controller.controllerWords,
        //     style: GoogleFonts.roboto(fontSize: 16, color: ColorConstants.black),
        //     decoration: InputDecoration(
        //         hintText: 'Enter Private Key'.tr,
        //         hintStyle: const TextStyle(  , fontSize: 12),
        //         labelStyle: const TextStyle(  , fontSize: 12),
        //         label: Text('Enter Private Key'.tr),
        //         enabledBorder: OutlineInputBorder(
        //             borderSide: BorderSide(color: ColorConstants.secondaryAppColor),
        //             borderRadius: BorderRadius.circular(20)),
        //         border: InputBorder.none,
        //         focusedBorder: OutlineInputBorder(
        //             borderSide: BorderSide(color: ColorConstants.secondaryAppColor),
        //             borderRadius: BorderRadius.circular(20))),
        //   )
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 55,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            child: TextFormField(
              controller: controller,
              onChanged: onChange,
              onEditingComplete: onEditingComplete,
              keyboardType: isNumber
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.text,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20)),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: hint,
                  labelText: hint,
                  hintStyle: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  labelStyle: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  suffixIcon: isScanner
                      ? IconButton(
                          onPressed: () {
                            printInfo(info: 'Information center....');
                            onScan!();
                          },
                          icon: const Icon(Icons.qr_code))
                      : image),
            ),
          ),
        ),

        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text(title.tr,
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFE8501F))),
            const Spacer(),
            isScanner ? image : const SizedBox()
          ],
        )
      ],
    );
  }
}

class SendDetails extends StatelessWidget {
  SendDetails({Key? key}) : super(key: key);

  SendTyvController controller = Get.put(SendTyvController());

  @override
  Widget build(BuildContext context) {
    final cntrl = Get.put(ScanQrController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),

        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: Text(
          'Transfers'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),

        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('- ${controller.controllerAmount.text}',
                    // '${controller.commissionAmount.value} LINE',
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                Obx(() => Text(
                      ' ${controller.currencyResponse.value?.currency}',
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Assets'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                    ' ${controller.currencyResponse.value?.currency}',
                                    // '${controller.commissionAmount.value} LINE',
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ]),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('From'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text('${userInfo?.address}',
                                    maxLines: 1,
                                    // '${controller.commissionAmount.value} LINE',
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('To'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(controller.controllerReceiver.text,
                                    maxLines: 1,
                                    // '${controller.commissionAmount.value} LINE',
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))),
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text('Network fee'.tr,
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )),
                          const Spacer(),
                          Obx(() => Text(
                              '${controller.commissionAmount.value} ${controller.mCurrency.value}',
                              // '${controller.commissionAmount.value} LINE',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Max Total'.tr,
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )),
                          const Spacer(),
                          Obx(() => Text(
                              '${double.parse(controller.controllerAmount.text.toString()) + controller.commissionAmount.value}',
                              // '${controller.commissionAmount.value} LINE',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        child: Obx(() => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: controller.isInputValid.value
                    ? ColorConstants.secondaryDarkAppColor
                    : const Color(0xFF3E4444),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  'Confirm'.tr,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )),
        onTap: () {
          if (controller.isInputValid.value) {
            if (controller.isSendToWallet.value &&
                !controller.controllerReceiver.text.trim().startsWith('LINE')) {
              EasyLoading.showToast('Incorrect internal address'.tr);
              return;
            }

            if (!controller.isSendToWallet.value &&
                controller.controllerReceiver.text.trim().startsWith('LINE')) {
              EasyLoading.showToast('Incorrect external address'.tr);
              return;
            }

            // // RegExp regex = RegExp(r'/^0x([A-Fa-f0-9]{64})$/');
            // RegExp regex = RegExp(r'/^(\b0x[a-f0-9]{40}\b)/gi');
            //
            // if (!regex.hasMatch(controller.controllerReceiver.text)){
            //   EasyLoading.showToast('Invalid ERC-20 address');
            //   return;
            // }

            // if(controller.controllerReceiver.text.startsWith('0x')&&controller.controllerReceiver.text.length>=64){
            //   if(controller.controllerReceiver.text.length<64){
            //     EasyLoading.showToast('Invalid ERC-20 address');
            //     return;
            //   }
            //   EasyLoading.showToast('Invalid ERC-20 address');
            //   return;
            // }

            printInfo(
                info:
                    'Token length:  ${controller.controllerReceiver.text.length}');

            // if(controller.controllerReceiver.text.startsWith('0x')&&controller.controllerReceiver.text.length>=40){
            if (controller.controllerReceiver.text.length >= 20) {
              controller.appController.validateLogin(context, () {
                controller.fundTransferAccount();
              });
            } else {
              EasyLoading.showToast('Invalid address'.tr);
              return;
            }
          }
        },
      ),
    );
  }
}
