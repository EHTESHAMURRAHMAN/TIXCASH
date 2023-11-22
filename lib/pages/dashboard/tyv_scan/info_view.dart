import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tyv_scan/tyv_scan_controller.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoView extends GetView<TyvScanController> {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          color: ColorConstants.secondaryDarkAppColor,
          child: Text(
            'Info'.tr,
            style:
                GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Table(
                textBaseline: TextBaseline.alphabetic,
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                        color: ColorConstants.blackBg,
                      ),
                      children: [
                        TableCell(
                            child: Text(
                          'Overview'.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                        TableCell(
                            child: Text(
                          controller.infoResponse.value.overview,
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                      ]),
                  TableRow(children: [
                    TableCell(
                        child: Text(
                      'Token Name'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                    TableCell(
                        child: Text(
                      controller.infoResponse.value.tokenName,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                  ]),
                  TableRow(
                      decoration: BoxDecoration(color: ColorConstants.blackBg),
                      children: [
                        TableCell(
                            child: Text(
                          'Max Total Supply'.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                        TableCell(
                            child: Text(
                          controller.infoResponse.value.maxTotalSupply,
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                      ]),
                  TableRow(children: [
                    TableCell(
                        child: Text(
                      'Holders'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                    TableCell(
                        child: Text(
                      controller.infoResponse.value.holders,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                  ]),
                  TableRow(
                      decoration: BoxDecoration(color: ColorConstants.blackBg),
                      children: [
                        TableCell(
                            child: Text(
                          'Transfers'.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                        TableCell(
                            child: Text(
                          '${controller.infoResponse.value.internaltransfer}/${controller.infoResponse.value.externaltransfer}',
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                      ]),
                  TableRow(children: [
                    TableCell(
                        child: Text(
                      'Contract'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                    TableCell(
                        child: Text(
                      controller.infoResponse.value.contractAddress,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                  ]),
                  TableRow(
                      decoration: BoxDecoration(color: ColorConstants.blackBg),
                      children: [
                        TableCell(
                            child: Text(
                          'Decimal'.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                        TableCell(
                            child: Text(
                          controller.infoResponse.value.decimalValue,
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                      ]),
                  TableRow(children: [
                    TableCell(
                        child: Text(
                      'Website'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                    TableCell(
                        child: GestureDetector(
                      child: Text(
                        'https://tyv.community',
                        style: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        launch('https://tyv.community');
                      },
                    )),
                  ]),
                ],
              ),
            ))
      ],
    );
  }
}
