import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/widgets/common_widgets.dart';

// ignore: must_be_immutable
class Send_List extends GetView {
  Send_List({Key? key}) : super(key: key);

  @override
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Send List'.tr,
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
                    return ListTile(
                      leading: LogoBuilder(logoUrl: element.icon),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            element.currency,
                            style: GoogleFonts.roboto(fontSize: 16),
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
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          // Obx(
                          //   () =>
                          //  controller.appController.currency.value ==
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
                          Text(
                            '\$${element.usdvalue.toStringAsFixed(4)}',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF40C4FF),
                            ),
                          ),
                          // Text('\$${element.usdvalue.toStringAsFixed(3)}',
                          //     style: GoogleFonts.roboto(
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w400,
                          //       color: const Color(0xFF40C4FF),
                          //     ))
                        ],
                      ),
                      onTap: () {
                        var mController = Get.find<SendTyvController>();
                        mController.currencyResponse.value = element;
                        Get.toNamed(Routes.SEND_TYV, arguments: [
                          {'currency': element}
                        ])?.then((value) {
                          controller.getBalanceCurrencyList(
                              currency: element.currency);
                        });
                        // Get.toNamed(Routes.TRANSACTION_HISTORY, arguments: [
                        //   {'currency': element}
                        // ])?.then((value) {
                        //   controller.getBalanceCurrencyList();
                        // });
                        mController.controllerReceiver.clear();
                        mController.controllerAmount.clear();
                      },
                    );
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
