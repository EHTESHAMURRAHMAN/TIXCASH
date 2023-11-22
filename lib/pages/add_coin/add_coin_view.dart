import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/add_coin/add_network_view.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/scan_qr.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_view.dart';

import 'add_coin_controller.dart';

class AddCoinView extends GetView<AddCoinController> {
  const AddCoinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('Add Custom Token'),
        actions: [
          TextButton(
              onPressed: () {
                controller.addCurrency();
              },
              child: const Text(
                'DONE',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ],
        centerTitle: true,
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Expanded(
                      child: Text('Network',
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))),
                  Obx(() => Text(controller.network.value,
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500))),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  )
                ],
              ),
              onTap: () {
                Get.to(const AddNetworkView())?.then((value) {
                  controller.network.value = value['network'];
                });
              },
            ),
            const SizedBox(
              height: 24,
            ),
            InputIconBox(
              hint: 'Contract address'.tr,
              // title: 'input receiving address'.tr,
              title: ''.tr,
              image: GestureDetector(
                child: Text(
                  'PASTE'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF40C4FF)),
                ),
                onTap: () async {
                  ClipboardData? data = await Clipboard.getData('text/plain');
                  controller.contractController.text = data?.text ?? '';

                  if (controller.contractController.text.isNotEmpty) {
                    controller.getTokenDetailByContract(
                        controller.contractController.text);
                  }
                },
              ),
              //
              controller: controller.contractController,
              onChange: (val) {
                controller.checkIsValid();
              },

              isScanner: true,
              onScan: () {
                controller.isScanEnable.value = true;
                Get.to(const ScanQR())?.then((value) {
                  controller.contractController.text = value;
                  controller.getTokenDetailByContract(
                      controller.contractController.text);
                });
              },

              onEditingComplete: () {
                controller.getTokenDetailByContract(
                    controller.contractController.text);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            InputIconBox(
              hint: 'Name'.tr,
              title: ''.tr,
              image: const SizedBox(), //const Icon(Icons.person),
              controller: controller.nameController,
              onChange: (val) {
                controller.checkIsValid();
              },
              isScanner: false,
            ),
            const SizedBox(
              height: 24,
            ),
            InputIconBox(
              hint: 'Symbol'.tr,
              title: ''.tr,
              image: const SizedBox(), //const Icon(Icons.person),
              controller: controller.symbolController,
              onChange: (val) {
                controller.checkIsValid();
              },
              isScanner: false,
            ),
            const SizedBox(
              height: 24,
            ),
            InputIconBox(
              hint: 'Decimal'.tr,
              title: ''.tr,
              isNumber: true,
              image: const SizedBox(), //const Icon(Icons.person),
              controller: controller.decimalController,
              onChange: (val) {
                controller.checkIsValid();
              },
              isScanner: false,
            ),
          ],
        ),
      ),
    );
  }
}
