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
                return ListTile(
                  leading: LogoBuilder(logoUrl: swapCurrency.icon),
                  title: Text(swapCurrency.currency,
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  onTap: () {
                    Get.back(result: [
                      {'currency': swapCurrency}
                    ]);
                  },
                );
              },
              itemCount: controller.swapCurrencyList.length,
            )),
      ),
    );
  }
}
