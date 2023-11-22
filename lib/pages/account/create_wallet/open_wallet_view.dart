import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:tixcash/shared/widgets/sa_rounded_button.dart';
import 'create_wallet_controller.dart';

class OpenWalletView extends GetView<CreateWalletController> {
  const OpenWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: ColorConstants.secondaryDarkAppColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig().screenHeight * 0.05,
                ),
                Image.asset('assets/images/tyvlogo.png'),
                SizedBox(
                  height: SizeConfig().screenHeight * 0.05,
                ),
                SARoundedButton(
                  height: 50,
                  width: SizeConfig().screenWidth * 0.6,
                  onPressed: () {
                    controller.showTermsAndConditions(context);
                  },
                  child: Text(
                    'Create Wallet'.tr,
                    style: const TextStyle(fontSize: CommonConstants.smallText),
                  ),
                ),
                SARoundedButton(
                  height: 50,
                  width: SizeConfig().screenWidth * 0.6,
                  onPressed: () {},
                  child: Text(
                    'Import Wallet'.tr,
                    style: const TextStyle(fontSize: CommonConstants.smallText),
                  ),
                ),
                SARoundedButton(
                  height: 50,
                  width: SizeConfig().screenWidth * 0.6,
                  onPressed: () {},
                  child: Text(
                    'Watch Wallet'.tr,
                    style: const TextStyle(fontSize: CommonConstants.smallText),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
