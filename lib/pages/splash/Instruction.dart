// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tixcash/pages/account/create_wallet/create_wallet_controller.dart';

class CreateWalletView extends GetView<CreateWalletController> {
  const CreateWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<CreateWalletController>()
        ? Get.find<CreateWalletController>()
        : Get.put(CreateWalletController());

// ignore: must_be_immutable

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
            )),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset(
              'assets/icons/logo.png',
              height: MediaQuery.of(context).size.height / 7,
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                    'On the next step, you will get the Secret Recovery Phrase (24 words), before that please read the following security tips'
                        .tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold))),
            const SizedBox(
              height: 36,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: const Color(0xff1680ee),
                  )),
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: Obx(() => CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    value: controller.isCheckedTerms1.value,
                    onChanged: (val) {
                      controller.isCheckedTerms1.value = val ?? true;
                    },
                    title: Text(
                        'If I lose my Secret Recovery Phrase my assets will be gone'
                            .tr,
                        style:
                            TextStyle(color: Color(0xff1680ee), fontSize: 14)),
                    checkColor: Colors.white,
                    activeColor: const Color(0xff1680ee),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: const Color(0xff1680ee),
                  )),
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: Obx(() => CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    value: controller.isCheckedTerms2.value,
                    onChanged: (val) {
                      controller.isCheckedTerms2.value = val ?? true;
                    },
                    title: Text(
                        'If I share my Secret Recovery Phrase to others my assets will be stolen'
                            .tr,
                        style:
                            TextStyle(color: Color(0xff1680ee), fontSize: 14)),
                    checkColor: Colors.white,
                    activeColor: const Color(0xff1680ee),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: const Color(0xff1680ee),
                  )),
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: Obx(() => CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    value: controller.isCheckedTerms3.value,
                    onChanged: (val) {
                      controller.isCheckedTerms3.value = val ?? true;
                    },
                    title: Text(
                        'It is my responsibilities to keep the Secret Recovery Phrase safe'
                            .tr,
                        style:
                            TextStyle(color: Color(0xff1680ee), fontSize: 14)),
                    checkColor: Colors.white,
                    activeColor: const Color(0xff1680ee),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
          () => controller.isCheckedTerms1 == false ||
                  controller.isCheckedTerms2 == false ||
                  controller.isCheckedTerms3 == false
              ? Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xff1680ee).withOpacity(.5)),
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Text(
                          'Generate Mnemonic'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                )
              : InkWell(
                  onTap: () {
                    controller.showTermsAndConditions(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xff1680ee)),
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                            'Generate Mnemonic'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ),
        ),
      ),
    );
  }
}
