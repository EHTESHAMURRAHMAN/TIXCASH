import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/select_coin/select_coin_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';

class SelectCoinView extends GetView<SelectCoinController> {
  const SelectCoinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(
          'Select Coin'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Get.toNamed(Routes.ADD_COIN);
        //       },
        //       icon: const Icon(
        //         Icons.add,
        //         size: 24,
        //         color: Colors.black,
        //       ))
        // ],
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
      // appBar: AppBar(
      //   title: Text(
      //     'Select Coin'.tr,
      //     style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Get.toNamed(Routes.ADD_COIN);
      //         },
      //         icon: const Icon(
      //           Icons.add,
      //           size: 24,
      //         ))
      //   ],
      // ),
      body: Column(
        children: [
          Expanded(
              child: Obx(() => ListView(
                    children: controller.currencyListResponse.map((element) {
                      if (kDebugMode) {
                        print(element.icon);
                      }
                      return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white))),
                          child: CheckboxListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    width: 2.0, color: Colors.blue),
                              ),
                              checkColor: const Color(0xff1680ee),
                              activeColor: Colors.grey,
                              enabled: element.topcurrency == 0,
                              title: Row(
                                children: [
                                  LogoBuilder(
                                    logoUrl: element.icon,
                                  ),
                                  // LogoBuilder(logoUrl: element.icon, isFullURL: true,),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Title(
                                      color: Colors.black,
                                      child: Text(element.currency,
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ))),
                                  const SizedBox(width: 8),
                                  Title(
                                      color: Colors.black,
                                      child: Text(element.symbol,
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                ],
                              ),
                              value: element.active.value,
                              onChanged: (val) {
                                element.active.value = val ?? false;
                                controller.userUpdateCurrency(
                                    element.symbol, val);
                                // controller.hasIcon(element);
                              }));
                    }).toList(),
                  ))),
          /*GestureDetector(
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(8),
              color: ColorConstants.secondaryDarkAppColor,
              child: Row(
                children:  [
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    child: Text('Save'.tr, style: GoogleFonts.roboto(
                        textStyle:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),),
                    onTap: () => Get.back(),
                  ),
                  const SizedBox(width: 8,),
                ],
              ),
            ),
            onTap:(){
            },
          )*/
        ],
      ),
    );
  }
}
