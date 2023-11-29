import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/constants/colors.dart';
import 'package:tixcash/shared/widgets/submit_button.dart';
import 'swap_controller.dart';


class SwapView extends GetView<SwapController> {
  @override
  Widget build(BuildContext context) {
    Get.isRegistered<SwapController>()
        ? Get.find<SwapController>()
        : Get.put(SwapController());
    controller.fromController.text = '';
    controller.toController.text = '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.black,
            )),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),

        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: Text(
          'Swap'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Trade tokens in an instance'.tr,
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            _fromView(),
            const SizedBox(height: 20),
            Icon(Icons.arrow_drop_down_circle,
                color: Theme.of(context).primaryColor, size: 33),
            const SizedBox(height: 16),
            _toView(),
            const SizedBox(height: 20),
            Obx(() => controller.isBalanceLoading.value
                ? SubmitButton(
                    onPressed: () {},
                    title: 'Pending',
                    color: Colors.orange,
                  )
                : SubmitButton(
                    onPressed: () {
                      controller.fundTransferAccount();
                    },
                    title: 'Instant Swap',
                    isActive: true,
                    color: ColorConstants.secondaryDarkAppColor,
                  ))
          ],
        ),
      ),
    );
  }

  _fromView() => Column(
        children: [
          GestureDetector(
            child: Row(
              children: [
                // Obx(() => LogoBuilder(
                //     logoUrl: controller.fromCurrency.value?.icon ?? 'BTC',
                //     width: 35)),
                const SizedBox(
                  width: 10,
                ),
                Obx(() => Text(
                      controller.selectcurrency.value,
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black,
                      size: 25,
                    )),
                const Expanded(child: SizedBox()),
                Text(
                  'Balance'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Obx(() => Text(
                      ': ${controller.fromBalanceTotal.value}',
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    )),
                Obx(() => controller.isBalanceLoading.value
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      )
                    : const SizedBox())
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.SWAP_LIST, arguments: [
                {'isToList': false}
              ])?.then((value) {
                if (value != null) {
                  controller.selectcurrency.value = value['currency'];
                }
              });
              // Get.toNamed(Routes.SWAP_LIST, arguments: [
              //   {'isToList': false}
              // ])?.then((value) {
              //   controller.fromCurrency.value = value[0]['currency'];
              //   controller.userFundBalance(
              //       currency: controller.fromCurrency.value?.currency ?? 'TIX');
              //   controller.getCurrencyPairPrice();
              // });
            },
          ),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: controller.fromController,
                    textAlign: TextAlign.start,
                    onChanged: (val) {
                      controller.toController.text =
                          '${double.parse(val) / (controller.currencyRate.value?.price ?? 1.0)}';
                    },
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        suffixIcon: InkWell(
                          child: SizedBox(
                            height: 25,
                            width: 20,
                            //margin: const EdgeInsets.symmetric(vertical: 16),
                            //padding: const EdgeInsets.only(top: 5),

                            child: Center(
                              child: Text(
                                'MAX'.tr,
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          onTap: () {
                            controller.fromController.text =
                                '${controller.fromBalanceTotal.value}';
                            controller.toController.text =
                                '${controller.fromBalanceTotal.value / (controller.currencyRate.value?.price ?? 1.0)}';
                          },
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter amount'.tr,
                        hintStyle: const TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          // Row(
          //   children: [
          //     const Spacer(),

          //   ],
          // )
        ],
      );

  _toView() => Column(
        children: [
          GestureDetector(
            child: Row(
              children: [
                // Obx(() => LogoBuilder(
                //     logoUrl: controller.toCurrency.value?.icon ?? 'BTC',
                //     width: 35)),
                const SizedBox(
                  width: 10,
                ),
                Obx(() => Text(
                      controller.fromCurrency.value?.currency ?? 'TIX',
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black,
                      size: 25,
                    )),
                const Expanded(child: SizedBox()),
                Text(
                  'Balance'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Obx(() => Text(
                      ': ${controller.toBalanceTotal.value}',
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    )),

                // Obx(() => controller.isBalanceLoading.value?const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(),):const SizedBox())
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.SWAP_LIST, arguments: [
                {'isToList': true}
              ])?.then((value) {
                controller.toCurrency.value = value[0]['currency'];
                controller.userFundBalance(
                    isTo: true,
                    currency: controller.toCurrency.value?.currency ?? 'TIX');
                controller.getCurrencyPairPrice();
              });
            },
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                  child: TextField(
                    enabled: false,
                    controller: controller.toController,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    'Price'.tr,
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
                  Obx(() => Text(
                        '${controller.currencyRate.value?.price ?? 1.0}',
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )),
                  Obx(() => Text(
                        ' ${controller.fromCurrency.value?.currency}/${controller.toCurrency.value?.currency}'
                            .tr,
                        style: GoogleFonts.roboto(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(Icons.refresh, color: Colors.black)
                ],
              ))
        ],
      );
}
