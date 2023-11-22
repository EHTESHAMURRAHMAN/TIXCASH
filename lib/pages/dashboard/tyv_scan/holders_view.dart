import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tyv_scan/tyv_scan_controller.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:collection/collection.dart';

class HoldersView extends GetView<TyvScanController> {
  const HoldersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: ColorConstants.secondaryDarkAppColor,
          child: Row(
            children: [
              Expanded(
                  flex: 10,
                  child: Text(
                    'Rank'.tr,
                    style: GoogleFonts.roboto(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  )),
              Expanded(
                flex: 50,
                child: Text(
                  'Address'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                  flex: 20,
                  child: Text(
                    'Quantity'.tr,
                    style: GoogleFonts.roboto(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  )),
              Expanded(
                  flex: 20,
                  child: Text(
                    'Percentage'.tr,
                    style: GoogleFonts.roboto(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
        Expanded(
            child: Obx(() => controller.holderResponseList.isNotEmpty
                ? ListView(
                    children: controller.holderResponseList
                        .mapIndexed((index, element) {
                    return Container(
                      alignment: Alignment.center,
                      color: index % 2 == 0
                          ? Colors.transparent
                          : ColorConstants.blackBg,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              flex: 10,
                              child: Text(
                                element.rank,
                                style: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              )),

                          Expanded(
                              flex: 50,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  element.address,
                                  style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                          // Expanded(child: Text(element.address, style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w400),), flex: 50,),
                          Expanded(
                              flex: 20,
                              child: Text(
                                '${element.quantity}',
                                style: GoogleFonts.roboto(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              )),
                          Expanded(
                              flex: 20,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  '${element.percentage}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
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
    );
  }
}
