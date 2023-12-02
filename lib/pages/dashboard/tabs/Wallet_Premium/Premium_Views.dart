import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tabs/Wallet_Premium/Premium_Controller.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/scan_qr.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_view.dart';
import 'package:tixcash/shared/utils/common_widget.dart';

// ignore: must_be_immutable
class PremiumViews extends GetView<PremiumController> {
  const PremiumViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isActived.value = controller.rcontroller.text.isEmpty;
    controller.getsubs();
    controller.refreshData();
    controller.getpremiumList();
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xff1680ee),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 18)),
            ),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: ClipRect(
                        child: Image.asset("assets/icons/premium1.jpeg",
                            height: MediaQuery.of(context).size.height / 5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Tixcash vip access'.tr,
                      style: TextStyle(
                          color: Colors.yellow.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  const SizedBox(height: 25),
                  Text('Get more features'.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 17)),
                ],
              ),
            ),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Icon(Icons.account_balance_wallet, color: Theme.of(context).primaryColor),
                //     const SizedBox(width: 10),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text('Multi-Wallet Access'.tr,
                //             style: TextStyle(
                //                 color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
                //         const SizedBox(height: 7),
                //         Text('Users can create multiple account \nand rename their account'.tr,
                //             style: const TextStyle(   fontSize: 14, fontWeight: FontWeight.w500)),
                //       ],
                //     ),
                //   ],
                // ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lock, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Stake & Earn'.tr,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 7),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                              'Users have opportunity to earn more from their assets'
                                  .tr,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.card_giftcard,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Refferral Reward'.tr,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 7),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                              'Refer your friend & get reward on their\nstaking'
                                  .tr,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ],
                ),
                Obx(
                  () => controller.subscriptionResponse.value?.pid == 0
                      ? Column(
                          children: [
                            const SizedBox(height: 30),
                            InkWell(
                                onTap: () {
                                  Get.to(PremiumAccess())?.then((value) {
                                    if (value != null) {
                                      controller.selectPlan.value =
                                          value['packagename'];
                                    }
                                    if (value != null) {
                                      controller.selectid.value = value['pid'];
                                      controller.getpremiumList();
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 55,
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(children: [
                                            Obx(() => controller
                                                    .selectPlan.value.isEmpty
                                                ? Text(
                                                    'Select Premium Plan'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    child: Text(
                                                      controller
                                                          .selectPlan.value,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                    ))),
                                            const Spacer(),
                                            const Icon(Icons.arrow_drop_down,
                                                size: 30)
                                          ])),
                                    ))),
                            const SizedBox(height: 10),
                            Obx(() => controller.selectPlan.value.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      Get.to(currencyPremium())?.then((value) {
                                        if (value != null) {
                                          controller.selectCurrencys.value =
                                              value['name'];
                                        }
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 55,
                                        child: Card(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                            ),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(children: [
                                                  Obx(() => controller
                                                          .selectCurrencys
                                                          .value
                                                          .isEmpty
                                                      ? Text(
                                                          'Select Currency'.tr,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          child: Text(
                                                            controller
                                                                .selectCurrencys
                                                                .value,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            maxLines: 1,
                                                          ))),
                                                  const Spacer(),
                                                  const Icon(
                                                      Icons.arrow_drop_down,
                                                      size: 30)
                                                ])))))
                                : const SizedBox()),
                            const SizedBox(height: 10),
                            Obx(() => controller.selectPlan.value.isNotEmpty &&
                                    controller.selectCurrencys.value.isNotEmpty
                                ? InputIconBox1(
                                    hint: 'Enter Referral Code (Optional)'.tr,
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
                                        ClipboardData? data =
                                            await Clipboard.getData(
                                                'text/plain');
                                        controller.rcontroller.text =
                                            data?.text ?? '';
                                        controller.getcheckreferallInput();
                                      },
                                    ),

                                    //
                                    controller: controller.rcontroller,
                                    onChange: (value) {
                                      controller.getcheckreferallInput();
                                    },
                                    isScanner: true,
                                    onScan: () {
                                      controller.isScanEnable.value = true;
                                      callOnScan();
                                      controller.getcheckreferallInput();
                                    },
                                  )
                                : const SizedBox()),
                            Obx(() => controller.selectPlan.value.isNotEmpty &&
                                    controller
                                        .selectCurrencys.value.isNotEmpty &&
                                    controller.isActived.value
                                ? CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: controller.isCheckedTerms.value,
                                    onChanged: (val) {
                                      controller.isCheckedTerms.value == false
                                          ? referalPopup(context)
                                          : null;
                                      controller.isCheckedTerms.value =
                                          val ?? true;
                                    },
                                    title: Text(
                                      controller.termsAndConditions,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    checkColor: Colors.white,
                                    activeColor: Colors.red,
                                    selectedTileColor: Colors.red,
                                    side: const BorderSide(color: Colors.red),
                                    checkboxShape: const CircleBorder())
                                : const SizedBox()),
                            const SizedBox(height: 10),
                            Obx(
                              () => controller.selectPlan.value.isNotEmpty &&
                                          controller.selectCurrencys.value
                                              .isNotEmpty &&
                                          controller.isActived.value == false ||
                                      controller.isCheckedTerms.value == true
                                  ? InkWell(
                                      onTap: () {
                                        controller.getaccess();
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          child: Center(
                                            child: Text(
                                              'Get Access'.tr,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(75)),
                                child: ClipRect(
                                  child: Image.asset(
                                      "assets/icons/premium1.jpeg",
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('You Are Premium Member'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                ),
              ],
            )));
  }

  callOnScan() async {
    Get.to(const ScanQR())?.then((value) {
      controller.rcontroller.text = value;
    });
  }
  // Obx(
  //   () => controller.subscriptionResponse.value?.pid == 0
  //       ? InkWell(
  //           onTap: () {
  //             Get.to(PremiumAccess())?.then((value) {
  //               if (value != null) {
  //                 controller.selectPlan.value =
  //                     value['packagename'];
  //               }
  //               if (value != null) {
  //                 controller.selectid.value = value['pid'];
  //               }
  //             });
  //           },
  //           child: Container(
  //               margin: const EdgeInsets.symmetric(horizontal: 4),
  //               height: 60,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(17),
  //                   color: Colors.grey.shade300),
  //               child: Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 0),
  //                   child: Row(
  //                     children: [
  //                       const SizedBox(width: 15),
  //                       Obx(() => controller
  //                               .selectPlan.value.isEmpty
  //                           ? const SizedBox()
  //                           : const Icon(Icons.arrow_drop_down,
  //                                  size: 30)),

  //                       Obx(() => controller
  //                               .selectPlan.value.isEmpty
  //                           ? Text(
  //                               'Select Premium Plan'.tr,
  //                               style: const TextStyle(
  //
  //                                   fontSize: 14,
  //                                   fontWeight: FontWeight.bold),
  //                             )
  //                           : SizedBox(
  //                               width: MediaQuery.of(context)
  //                                       .size
  //                                       .width /
  //                                   4,
  //                               child: Text(
  //                                 controller.selectPlan.value,
  //                                 style: const TextStyle(
  //
  //                                     fontSize: 15,
  //                                     fontWeight:
  //                                         FontWeight.bold),
  //                                 maxLines: 1,
  //                               ))),

  //                       //Obx(() => ),
  //                       const Spacer(),
  //                       Obx(
  //                         () =>
  //                             controller.selectPlan.value.isEmpty
  //                                 ? const Icon(
  //                                     Icons.arrow_drop_down,
  //
  //                                     size: 30)
  //                                 : InkWell(
  //                                     onTap: () {
  //                                       showDialog(
  //                                         context: context,
  //                                         barrierDismissible:
  //                                             false, // user must tap button!
  //                                         builder: (BuildContext
  //                                             context) {
  //                                           return AlertDialog(
  //                                             backgroundColor:
  //                                                 Colors.white,
  //                                             title: Row(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment
  //                                                       .spaceBetween,
  //                                               children: [
  //                                                 const Icon(
  //                                                     Icons
  //                                                         .cancel,
  //                                                     color: Colors
  //                                                         .transparent),
  //                                                 Text('Select Currency'.tr.tr,
  //                                                     style: const TextStyle(
  //                                                         color: Colors
  //                                                             .black,
  //                                                         fontSize:
  //                                                             15,
  //                                                         fontWeight:
  //                                                             FontWeight.bold)),
  //                                                 InkWell(
  //                                                   onTap: () =>
  //                                                       Get.back(),
  //                                                   child: const Icon(
  //                                                       Icons
  //                                                           .cancel,
  //                                                       color: Colors
  //                                                           .black,
  //                                                       size: 25),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             content:
  //                                                 SingleChildScrollView(
  //                                               child: ListBody(
  //                                                 children: [
  //                                                   Column(
  //                                                     children: [
  //                                                       InkWell(
  //                                                         onTap:
  //                                                             () {
  //                                                           Get.to(currencyPremium())
  //                                                               ?.then((value) {
  //                                                             if (value !=
  //                                                                 null) {
  //                                                               controller.selectCurrencys.value = value['name'];
  //                                                             }
  //                                                           });
  //                                                         },
  //                                                         child:
  //                                                             Container(
  //                                                           padding: const EdgeInsets
  //                                                               .symmetric(
  //                                                               horizontal: 12),
  //                                                           height:
  //                                                               60,
  //                                                           decoration: BoxDecoration(
  //                                                               borderRadius: BorderRadius.circular(17),
  //                                                               color: Colors.grey.shade300),
  //                                                           width: MediaQuery.of(context)
  //                                                               .size
  //                                                               .width,
  //                                                           child:
  //                                                               Row(
  //                                                             children: [
  //                                                               Obx(() => controller.selectCurrencys.value.isEmpty ? Text('Select Currency'.tr, style: const TextStyle(   fontSize: 14, fontWeight: FontWeight.bold)) : Text(controller.selectCurrencys.value, style: const TextStyle(   fontSize: 15, fontWeight: FontWeight.bold), maxLines: 1)),
  //                                                               const Spacer(),
  //                                                               const Icon(
  //                                                                 Icons.arrow_drop_down,
  //                                                                 size: 25,
  //
  //                                                               )
  //                                                             ],
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                       const SizedBox(
  //                                                           height:
  //                                                               20),
  //                                                       ElevatedButton(
  //                                                         onPressed:
  //                                                             () {
  //                                                           controller
  //                                                               .getaccess();
  //                                                         },
  //                                                         child: const Text(
  //                                                             'Get Access'),
  //                                                       ),
  //                                                     ],
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             shape: RoundedRectangleBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius
  //                                                         .circular(
  //                                                             14)),
  //                                           );
  //                                         },
  //                                       );
  //                                     },
  //                                     child: Container(
  //                                       height: 70,
  //                                       width:
  //                                           MediaQuery.of(context)
  //                                                   .size
  //                                                   .width /
  //                                               2,
  //                                       decoration: BoxDecoration(
  //                                         color: Theme.of(context)
  //                                             .primaryColor,
  //                                         borderRadius:
  //                                             BorderRadius
  //                                                 .circular(20),
  //                                       ),
  //                                       child: const Center(
  //                                           child: Text(
  //                                               'Select Currency')),
  //                                     ),
  //                                   ),
  //                       ),
  //                     ],
  //                   ))),
  //         )
  //       : Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           // mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Image.network(
  //                 'https://static.vecteezy.com/system/resources/thumbnails/013/195/636/small/premium-quality-badge-with-blue-and-gold-color-png.png',
  //                 // color: const Color.fromARGB(240, 255, 209, 59),
  //                 height: MediaQuery.of(context).size.height / 5),
  //             const SizedBox(height: 10),
  //             const Text('You Are Premium Member',
  //                 style: TextStyle(
  //
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 15)),
  //           ],
  //         ),
  // ),

//  Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.network(
//                                 'https://static.vecteezy.com/system/resources/thumbnails/013/195/636/small/premium-quality-badge-with-blue-and-gold-color-png.png',
//                                 // color: const Color.fromARGB(240, 255, 209, 59),
//                                 height: MediaQuery.of(context).size.height / 5),
//                             const SizedBox(height: 10),
//                             const Text('You Are Premium Member',
//                                 style: TextStyle(
//
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15)),
//                           ],
//                         ),
  // Obx(() => controller.selectPlan.value.isNotEmpty &&
  //         controller.selectCurrencys.value.isNotEmpty
  //     ? Container(
  //         height: 55,
  //         padding: const EdgeInsets.symmetric(horizontal: 15),
  //         margin: const EdgeInsets.symmetric(horizontal: 4),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(17),
  //             color: Colors.grey.shade300),
  //         child: TextFormField(
  //           controller: controller.rcontroller,
  //           onChanged: (value) {
  //             controller.isActived.value =
  //                 controller.rcontroller.text.isEmpty;
  //           },
  //           style: const TextStyle(color: Colors.black),
  //           decoration: InputDecoration(
  //               hintText: 'Enter Referral Code (Optional)',
  //               hintStyle: const TextStyle(
  //                      fontSize: 14),
  //               labelText: 'Enter Referral Code',
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide:
  //                     const BorderSide(color: Colors.transparent),
  //                 borderRadius: BorderRadius.circular(17),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                   borderSide: const BorderSide(
  //                       color: Colors.transparent),
  //                   borderRadius: BorderRadius.circular(20)),
  //               labelStyle: const TextStyle(
  //                      fontSize: 14),
  //               border: InputBorder.none),
  //         ),
  //       )
  //     : SizedBox()),
  // const SizedBox(height: 5),
  void referalPopup(context) {
    // BackupWordsController controller1 = Get.put(BackupWordsController());

    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.asset(
            'assets/icons/logo.png',
            height: MediaQuery.of(context).size.height / 12,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Column(
                  children: [
                    Text('** ⚠️ Warning ⚠️ **'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                        'Referral code is important and permanent. If missed then the referral rewards will be missed.'
                            .tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.rcontroller.clear();
                      },
                      child: Text('Okay'.tr),
                      //    child: const Text('Pay \$5'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        );
      },
    );
  }
  // showMyDialog() async {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('AlertDialog Title'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('This is a demo alert dialog.'),
  //               Text('Would you like to approve of this message?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Approve'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
