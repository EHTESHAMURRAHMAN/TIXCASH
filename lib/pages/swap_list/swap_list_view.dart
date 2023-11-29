import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/models/swap_currencies.dart';
import 'package:tixcash/shared/widgets/common_widgets.dart';

import 'swap_list_controller.dart';
import 'swap_list_controller.dart';

class SwapListView extends GetView<SwapListController> {
  @override
  Widget build(BuildContext context) {
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
          'Swap List'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Obx(() => ListView.builder(
              itemBuilder: (context, index) {
                SwapCurrency swapCurrency =
                    controller.swapCurrencyList.elementAt(index);
                swapCurrency.sort((a, b) => a.length.compareTo(b.length));
                return ListTile(
                  leading: LogoBuilder(logoUrl: swapCurrency.icon),
                  title: Text(swapCurrency.currency,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
                  onTap: () {
                    Get.back(result: {
                      'currency': swapCurrency.currency,
                    });
                  },
                  // onTap: () {
                  //   Get.back(result: [
                  //     {'currency': swapCurrency}
                  //   ]);
                  // },
                );
              },
              itemCount: controller.swapCurrencyList.length,
            )),
      ),
    );
  }
}
