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
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),

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
                  child: Text('View on Tixcash'.tr)),
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
                    ),
                    label: Text(
                      'Sending account'.tr,
                      style: GoogleFonts.roboto(),
                    )),

                Row(
                  children: [
                    Text(
                      controller.trxDetails?.fromAdress ?? '',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: controller.trxDetails?.fromAdress ?? ''));
                          EasyLoading.showToast('Copied'.tr);
                        },
                        icon: const Icon(
                          Icons.copy,
                        ))
                  ],
                ),

                TextButton.icon(
                    onPressed: null,
                    icon: const Icon(
                      Icons.arrow_circle_up,
                    ),
                    label: Text(
                      'Receiving account'.tr,
                      style: GoogleFonts.roboto(),
                    )),

                Row(
                  children: [
                    Text(
                      controller.trxDetails?.toAddress ?? '',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: controller.trxDetails?.toAddress ?? ''));
                          EasyLoading.showToast('Copied'.tr);
                        },
                        icon: const Icon(
                          Icons.copy,
                        ))
                  ],
                )
              ],
            )),

            const SizedBox(
              height: 16,
            ),

            Text(
              'Transaction Type'.tr,
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 15),
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
              controller.trxDetails?.paymentType.tr ?? '',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 15),
            ),

            const SizedBox(
              height: 16,
            ),

            Text(
              'Transaction Hash'.tr,
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 15),
            ),

            const SizedBox(
              height: 8,
            ),

            Row(
              children: [
                Expanded(
                  child: Text(
                    controller.trxDetails?.txthash.tr ?? ''.tr,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: controller.trxDetails?.txthash ?? ''));
                      EasyLoading.showToast('Copied'.tr);
                    },
                    icon: const Icon(
                      Icons.copy,
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
              'Date'.tr,
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 15),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              controller.trxDetails?.transactionDate ?? '',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Text(
                  'Estimated Gas Fee'.tr,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const Spacer(),
                Text(
                  '${controller.trxDetails?.credit ?? 0.0} /'.tr,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  ' ${controller.trxDetails?.commissionAmt ?? 0.0}'.tr,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            )
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
