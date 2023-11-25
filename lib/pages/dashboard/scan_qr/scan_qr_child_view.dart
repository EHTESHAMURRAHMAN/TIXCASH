import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/models/currency_response.dart';
import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_controller.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:tixcash/shared/widgets/textfield_icon.dart';

class ScanQRChild extends GetView<ScanQrController> {
  final bool hasActionBar;
  final CurrencyResponse? currencyResponse; // = Rxn<CurrencyResponse>();
  const ScanQRChild({
    Key? key,
    this.hasActionBar = true,
    this.currencyResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getAddressId(currencyResponse?.currency ?? 'TIX');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: hasActionBar
          ? AppBar(
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
                    size: 20,
                  )),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              // backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'RECEIVE'.tr,
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${currencyResponse?.currency}'.tr.toUpperCase(),
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 40)
                ],
              ),
            )
          : null,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'YOUR'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF40C4FF)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${currencyResponse?.currency}'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF40C4FF)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'ADDRESS'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF40C4FF)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // SizedBox(height: SizeConfig().screenHeight*0.03,),
            const SizedBox(
              height: 32,
            ),
            /**
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Container(
                      color: const Color(0xFF1680ee),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      // width: SizeConfig().screenWidth*0.2,
                      // margin: EdgeInsets.symmetric(horizontal: SizeConfig().screenWidth*0.15, vertical: 8),
                      child: Text(
                        'TRANSFER FROM EXCHANGE'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    onTap: () {
                      controller.isTransferFromExchange.value = true;
                      controller.getAddressId(0);
                    },
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Container(
                      color: const Color(0xFF1680ee),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      // width: SizeConfig().screenWidth*0.2,
                      // margin: EdgeInsets.symmetric(horizontal: SizeConfig().screenWidth*0.15, vertical: 8),
                      child: Text(
                        'TRANSFER FROM WALLET'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    onTap: () {
                      controller.isTransferFromExchange.value = false;
                      controller.getAddressId(1);
                    },
                  )
                ],
              ),
            ),

            // SARoundedButton(
            //     color: const Color(0xFF1680ee),
            //     margin: EdgeInsets.symmetric(horizontal: SizeConfig().screenWidth*0.15),
            //     child: Text('TRANSFER FROM WALLET'.tr , style: GoogleFonts.roboto(
            //         fontSize: 13, fontWeight: FontWeight.w500
            //     )), onPressed: (){
            //   controller.isTransferFromExchange.value = false;
            //       controller.getAddressId(1);
            // }),

            const SizedBox(
              height: 40,
            ),

            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/ic_globe.png',
                width: 56,
              ),
            ),
**/
            const SizedBox(height: 16),
            Obx(() => Text(
                  controller.address.value,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(height: 16),

            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff1680ee),
                          borderRadius: BorderRadius.circular(8)),

                      padding: const EdgeInsets.symmetric(
                          horizontal: 38, vertical: 10),
                      // width: SizeConfig().screenWidth*0.2,
                      // margin: EdgeInsets.symmetric(horizontal: SizeConfig().screenWidth*0.15, vertical: 8),
                      child: Text(
                        'COPY ADDRESS'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: controller.address.value));
                      EasyLoading.showToast('copied'.tr);
                    },
                  )
                ],
              ),
            ),

            // SARoundedButton(
            //     color: const Color(0xFF1680ee),
            //     margin: EdgeInsets.symmetric(horizontal: SizeConfig().screenWidth*0.15),
            //     child: Text('COPY ADDRESS'.tr , style: GoogleFonts.roboto(
            //         fontSize: 13, fontWeight: FontWeight.w500
            //     )), onPressed: (){
            //   Clipboard.setData(ClipboardData(
            //       text: controller.address.value
            //   ));
            //   EasyLoading.showToast('copied'.tr);
            // }),

            SizedBox(
              height: SizeConfig().screenHeight * 0.03,
            ),
            // YOUR TIX QR CODE ADDRESS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'YOUR'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF40C4FF)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  ' ${currencyResponse?.currency} '.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF40C4FF)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'QR CODE ADDRESS'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF40C4FF)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),
            Screenshot(
                controller: controller.screenshotController,
                child: Center(
                  child: Obx(() => QrImageView(
                        backgroundColor: Colors.white,
                        data: controller.address.value,
                        version: QrVersions.auto,
                        size: 200,
                      )),
                )),
            const SizedBox(height: 20),
            InkWell(
                onTap: () {
                  shareQrCode();
                },
                child: const Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 30,
                )),

            Obx(() => controller.isTransferFromExchange.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: _confirmTransaction(context),
                  )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _confirmTransaction(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'Have_you_paid'.tr,
            style: GoogleFonts.roboto(
                // color: ColorConstants.secondaryDarkAppColor,
                color: const Color(0xFF40C4FF),
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Confirm_transaction'.tr,
            style: GoogleFonts.roboto(fontSize: 14),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextFieldIcon(
              controller: controller.controllerHash,
              hintText: 'Enter_Hash_key'.tr,
              onChanged: (val) {},
              labelText: 'Enter_Hash_key'.tr,
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Container(
                    color: const Color(0xFF1680ee),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 38, vertical: 10),
                    // width: SizeConfig().screenWidth*0.2,
                    // margin: EdgeInsets.symmetric(horizontal: SizeConfig().screenWidth*0.15, vertical: 8),
                    child: Text(
                      'DEPOSIT'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () => controller.depositFund(),
                )
              ],
            ),
          ),

          // SARoundedButton(
          //     color: const Color(0xFF1680ee),
          //     child: Text('DEPOSIT'.tr, style: GoogleFonts.roboto(
          //         fontSize: 13, fontWeight: FontWeight.w500 ,color: const Color(0xFF40C4FF)
          //     ),), onPressed: (){
          //   controller.depositFund();
          // })
        ],
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
          Share.shareFiles([imagePath.path]);
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}
