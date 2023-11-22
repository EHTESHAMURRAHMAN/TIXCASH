import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';
import 'transaction_detail_controller.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
  const TransactionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<TransactionDetailController>()
        ? Get.find<TransactionDetailController>()
        : Get.put(TransactionDetailController());

    return Scaffold(
      backgroundColor: Colors.white,
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
              size: 20,
            )),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        title: Text(
          'Transaction Details'.tr.toUpperCase(),
          style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      //appBar: AppBar(title: const Text('Transaction Details')),
      body: Container(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    const url = 'http://explorer.tixcash.org/';
                    openBrowserUrl(url: url, inApp: true);
                  },
                  child: const Text('View on Tixcash')),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: TextButton(
            //       onPressed: () {
            //         launch(controller.trxDetails?.remark ?? '');
            //       },
            //       child: Text(
            //           'View on ${controller.trxDetails?.blockchaintitle}')),
            // ),
            // }, child: const Text('View on Linescan')),),
            SACellContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!(controller.trxDetails != null &&
                    controller.trxDetails!.paymentType.contains('Sent')))
                  // Align(alignment: Alignment.center, child: Text('+${controller.trxDetails?.credit??0.0} LINE', style: GoogleFonts.roboto(
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '+${controller.trxDetails?.credit ?? 0.0} ${controller.trxDetails?.currency}',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 20),
                    ),
                  ),

                // if(controller.trxDetails!=null&&controller.trxDetails!.debit>0)
                if (controller.trxDetails != null &&
                    controller.trxDetails!.paymentType.contains('Sent'))
                  // Align(alignment: Alignment.center, child: Text('-${controller.trxDetails?.credit??0.0} LINE', style: GoogleFonts.roboto(
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '-${controller.trxDetails?.credit ?? 0.0} ${controller.trxDetails?.currency}',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20),
                    ),
                  ),

                const SizedBox(
                  height: 16,
                ),

                const Divider(color: Colors.white),

                TextButton.icon(
                    onPressed: null,
                    icon: const Icon(
                      Icons.arrow_circle_down,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Sending account',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                      ),
                    )),

                Row(
                  children: [
                    Text(
                      controller.trxDetails?.fromAdress ?? '',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: controller.trxDetails?.fromAdress ?? ''));
                          EasyLoading.showToast('Copied');
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.black,
                        ))
                  ],
                ),

                TextButton.icon(
                    onPressed: null,
                    icon: const Icon(
                      Icons.arrow_circle_up,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Receiving account',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                      ),
                    )),

                Row(
                  children: [
                    Text(
                      controller.trxDetails?.toAddress ?? '',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: controller.trxDetails?.toAddress ?? ''));
                          EasyLoading.showToast('Copied');
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.black,
                        ))
                  ],
                )
              ],
            )),

            const SizedBox(
              height: 16,
            ),

            Text(
              'Transaction Type',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
            ),

            const SizedBox(
              height: 8,
            ),

            // if(controller.trxDetails!=null&&controller.trxDetails!.credit>0)
            // Text('Received', style: GoogleFonts.roboto(
            //     fontWeight: FontWeight.normal, color: Colors.white, fontSize: 15
            // ),),
            //
            // if(controller.trxDetails!=null&&controller.trxDetails!.debit>0)

            Text(
              controller.trxDetails?.paymentType ?? '',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
            ),

            const SizedBox(
              height: 16,
            ),

            Text(
              'Transaction Hash',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
            ),

            const SizedBox(
              height: 8,
            ),

            Row(
              children: [
                Expanded(
                  child: Text(
                    controller.trxDetails?.txthash ?? '',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: controller.trxDetails?.txthash ?? ''));
                      EasyLoading.showToast('Copied');
                    },
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.black,
                    ))
              ],
            ),

            // Text(controller.trxDetails?.txthash??'', style: GoogleFonts.roboto(
            //     fontWeight: FontWeight.normal, color: Colors.white, fontSize: 15
            // ),),

            const SizedBox(
              height: 16,
            ),

            Text(
              'Date',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              controller.trxDetails?.transactionDate ?? '',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
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
