import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_child_view_cur.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/shared/widgets/common_widgets.dart';

// ignore: must_be_immutable
class Receive_List extends GetView {
  Receive_List({Key? key}) : super(key: key);

  @override
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Receive List'.tr,
          style: GoogleFonts.roboto(fontSize: 18),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () => Get.back(), child: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15),
        child: RefreshIndicator(
          onRefresh: controller.getBalanceCurrencyList,
          child: Obx(() => controller.isCurrencyListResponse.value
              ? ListView(
                  children: controller.currencyListResponse.map((element) {
                    return Container(
                        //padding: const EdgeInsets.symmetric(vertical: 8),

                        child: ListTile(
                      leading: LogoBuilder(logoUrl: element.icon),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            element.currency,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '\$${element.price}',
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            element.balance.toStringAsFixed(4),
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                            ),
                          ),

                          // controller.appController.currency.value ==
                          //         'EUR'
                          //     ? Text(
                          //         '€${(element.usdvalue * 0.94).toStringAsFixed(4)}',
                          //         style: GoogleFonts.roboto(
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w400,
                          //           color: const Color(0xFF40C4FF),
                          //         ))
                          //     : controller.appController.currency.value ==
                          //             'CNY'
                          //         ? Text(
                          //             '¥${(element.usdvalue * double.parse('${controller.worldCurrency.value?.CNY ?? 0.0}')).toStringAsFixed(4)}',
                          //             style: GoogleFonts.roboto(
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.w400,
                          //               color: const Color(0xFF40C4FF),
                          //             ))
                          //         : controller.appController.currency.value ==
                          //                 'RUB'
                          //             ? Text(
                          //                 '₽${(element.usdvalue * double.parse('${controller.worldCurrency.value?.RUB ?? 0.0}')).toStringAsFixed(4)}',
                          //                 style: GoogleFonts.roboto(
                          //                   fontSize: 14,
                          //                   fontWeight: FontWeight.w400,
                          //                   color: const Color(0xFF40C4FF),
                          //                 ))
                          //             : controller.appController.currency
                          //                         .value ==
                          //                     'JPY'
                          //                 ? Text(
                          //                     '¥${(element.usdvalue * double.parse('${controller.worldCurrency.value?.JPY ?? 0.0}')).toStringAsFixed(4)}',
                          //                     style: GoogleFonts.roboto(
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.w400,
                          //                       color:
                          //                           const Color(0xFF40C4FF),
                          //                     ))
                          //                 : controller.appController.currency
                          //                             .value ==
                          //                         'HKD'
                          //                     ? Text(
                          //                         'HK\$${(element.usdvalue * double.parse('${controller.worldCurrency.value?.HKD ?? 0.0}')).toStringAsFixed(4)}',
                          //                         style: GoogleFonts.roboto(
                          //                           fontSize: 14,
                          //                           fontWeight:
                          //                               FontWeight.w400,
                          //                           color: const Color(
                          //                               0xFF40C4FF),
                          //                         ))
                          //                     : controller.appController
                          //                                 .currency.value ==
                          //                             'GBP'
                          //                         ? Text(
                          //                             '£${(element.usdvalue * double.parse('${controller.worldCurrency.value?.GBP ?? 0.0}')).toStringAsFixed(4)}',
                          //                             style:
                          //                                 GoogleFonts.roboto(
                          //                               fontSize: 14,
                          //                               fontWeight:
                          //                                   FontWeight.w400,
                          //                               color: const Color(
                          //                                   0xFF40C4FF),
                          //                             ))
                          //                         :

                          Text('\$${element.usdvalue.toStringAsFixed(4)}',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF40C4FF),
                              )),

                          // Text('\$${element.usdvalue.toStringAsFixed(3)}',
                          //     style: GoogleFonts.roboto(
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w400,
                          //       color: const Color(0xFF40C4FF),
                          //     ))
                        ],
                      ),
                      onTap: () {
                        Get.to(ScanQRChildCur(currencyResponse: element))
                            ?.then((value) {
                          controller.getBalanceCurrencyList();
                        });

                        // Get.toNamed(Routes.TRANSACTION_HISTORY, arguments: [
                        //   {'currency': element}
                        // ])?.then((value) {
                        //   controller.getBalanceCurrencyList();
                        // });
                      },
                    ));
                  }).toList(),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
        ),
      ),
    );
  }
}
