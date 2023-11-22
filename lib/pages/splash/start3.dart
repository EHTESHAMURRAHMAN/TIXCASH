import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/pages/account/create_wallet/import_wallet_view.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/settings_controller.dart';
import 'package:tixcash/pages/splash/Instruction.dart';

class Startview3 extends GetView {
  const Startview3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 55),
              Image.asset(
                'assets/icons/logo.png',
                height: MediaQuery.of(context).size.height / 5,
              ),
              const SizedBox(height: 55),
              Text(
                'Welcome to TIXCASH WALLET'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 25),
              Text(
                'The home of your Funds & your\nNFT collection on TIXCASH WALLET Network'
                    .tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => const CreateWalletView());
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xff1680ee)),
                child: Center(
                  child: Text(
                    'Create new wallet'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Get.to(() => const ImportWalletView());
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey.shade200),
                child: Center(
                  child: Text(
                    'I already have a wallet'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color(0xff1680ee)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => Get.to(const Term_Condition()),
                    child: Text(
                      'Terms of use'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blue),
                    )),
                Text(
                  '&',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
                TextButton(
                  onPressed: () => Get.to(const PrivacyandPolicy()),
                  child: Text(
                    'Privacy Policy'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
