import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tyv_scan/holders_view.dart';
import 'package:tixcash/pages/dashboard/tyv_scan/info_view.dart';
import 'package:tixcash/pages/dashboard/tyv_scan/transfers_view.dart';
import 'package:tixcash/shared/shared.dart';

import 'tyv_scan_controller.dart';
import 'package:collection/collection.dart';

class TyvScanView extends GetView<TyvScanController> {
  const TyvScanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MAX TOTAL SUPPLY'.tr,
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF40C4FF)),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Obx(
                    () => Text(
                      '${controller.appController.fundBalance} LINE',
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Expanded(
            child: Obx(() => IndexedStack(
                  index: controller.index.value,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: ColorConstants.secondaryDarkAppColor,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 20,
                                child: Text(
                                  'Txn Hash'.tr,
                                  style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                  flex: 25,
                                  child: Text(
                                    'Age'.tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Expanded(
                                  flex: 20,
                                  child: Text(
                                    'From'.tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Expanded(
                                  flex: 20,
                                  child: Text(
                                    'To'.tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Expanded(
                                  flex: 15,
                                  child: Text(
                                    'Quantity'.tr,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Obx(() => controller
                                    .transactionListResponse.isNotEmpty
                                ? ListView(
                                    children: controller.transactionListResponse
                                        .mapIndexed((index, element) {
                                    return Container(
                                      color: index % 2 == 0
                                          ? ColorConstants.blackBg
                                          : Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            flex: 20,
                                            child: Text(
                                              element.txthash,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 25,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: Text(
                                                  element.transactionDate,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal),
                                                ),
                                                color: Colors.transparent,
                                              )),
                                          Expanded(
                                              flex: 20,
                                              child: Text(
                                                element.fromAdress,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )),
                                          Expanded(
                                              flex: 25,
                                              child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    element.toAddress,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  color: Colors.transparent)),
                                          Expanded(
                                              flex: 15,
                                              child: Text(
                                                '${element.credit > 0 ? element.credit : element.debit}',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.center,
                                              )),
                                        ],
                                      ),
                                    );
                                  }).toList())
                                : controller.isTransLoaded.value
                                    ? Center(
                                        child: Text('No record founded'.tr),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      )))
                      ],
                    ),
                    const TransfersView(),
                    const HoldersView(),
                    const InfoView(),
                  ],
                )))
      ],
    );
  }
}
