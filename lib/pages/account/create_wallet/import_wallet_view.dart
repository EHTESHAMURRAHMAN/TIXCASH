import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/scan_qr.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_view.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'create_wallet_controller.dart';
import 'package:collection/collection.dart';

class ImportWalletView extends GetView<CreateWalletController> {
  final bool isImportWallet;
  const ImportWalletView({
    Key? key,
    this.isImportWallet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<CreateWalletController>()
        ? Get.find<CreateWalletController>()
        : Get.put(CreateWalletController());
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios,
                color: Colors.black, size: 18)),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Import an Account'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                //color: ColorConstants.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(RecoveryDropDown())?.then((value) {
                            if (value != null) {
                              controller.selectType.value = value['type'];
                            }
                          });
                        },
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(children: [
                                  Obx(() => controller.selectType.value.isEmpty
                                      ? Text(
                                          'Select Recover Account Type'.tr,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: Text(
                                            controller.selectType.value,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                          ))),
                                  const Spacer(),
                                  const Icon(Icons.arrow_drop_down,
                                      color: Colors.black, size: 30)
                                ])))),
                    const SizedBox(height: 10),
                    Obx(() => controller.selectType.value == "Secrate Phrase"
                        ? TextFormField(
                            controller: controller.controllerWords,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: ColorConstants.black),
                            onChanged: (val) {
                              controller.searchWords(val);
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter 24 Word Secrate Phrase'.tr,
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                                label: Text('Enter Phrase'.tr),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.secondaryAppColor),
                                    borderRadius: BorderRadius.circular(20)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.secondaryAppColor),
                                    borderRadius: BorderRadius.circular(20))),
                          )
                        : controller.selectType.value == "Private Key"
                            ? InputIconBox(
                                hint: 'Enter Private Key'.tr,
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
                                        await Clipboard.getData('text/plain');
                                    controller.controllerPrivateKey.text =
                                        data?.text ?? '';
                                    controller.isActived.value = controller
                                        .controllerPrivateKey.text.isNotEmpty;
                                  },
                                ),

                                //
                                controller: controller.controllerPrivateKey,
                                onChange: (value) {
                                  controller.isActived.value = controller
                                      .controllerPrivateKey.text.isNotEmpty;
                                },
                                isScanner: true,
                                onScan: () {
                                  controller.isScanEnable.value = true;
                                  callOnScan();
                                },
                              )
                            // TextFormField(
                            //     onChanged: (value) {
                            //       controller.isActived.value = controller.controllerWords.text.isNotEmpty;
                            //     },
                            //     controller: controller.controllerWords,
                            //     style: GoogleFonts.roboto(fontSize: 16, color: ColorConstants.black),
                            //     decoration: InputDecoration(
                            //         hintText: 'Enter Private Key'.tr,
                            //         hintStyle: const TextStyle(color: Colors.black, fontSize: 12),
                            //         labelStyle: const TextStyle(color: Colors.black, fontSize: 12),
                            //         label: Text('Enter Private Key'.tr),
                            //         enabledBorder: OutlineInputBorder(
                            //             borderSide: BorderSide(color: ColorConstants.secondaryAppColor),
                            //             borderRadius: BorderRadius.circular(20)),
                            //         border: InputBorder.none,
                            //         focusedBorder: OutlineInputBorder(
                            //             borderSide: BorderSide(color: ColorConstants.secondaryAppColor),
                            //             borderRadius: BorderRadius.circular(20))),
                            //   )
                            : const SizedBox()),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 40,
                      child: Obx(() => ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.searchList.map((element) {
                              return SelectContainer(
                                  title: element,
                                  onSelect: () {
                                    controller
                                        .paymntStatusResponse.value?.paymentid;
                                    if (controller.selectedEdit.value < 1000) {
                                      controller.phraseList[controller
                                          .selectedEdit.value] = element;
                                      controller.selectedEdit.value = 10001;
                                    } else {
                                      controller.phraseList.add(element);
                                    }
                                    controller.isActive.value =
                                        controller.phraseList.length >= 24;

                                    controller.controllerWords.text = '';
                                    controller.searchList.clear();
                                  });
                            }).toList(),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => controller.phraseList.isNotEmpty
                    ? Text(
                        'Passphrase Entered (click to Edit)'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: ColorConstants.black),
                      )
                    : const SizedBox()),
              ),
              Obx(() => Column(
                    children:
                        controller.phraseList.mapIndexed((index, element) {
                      return ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: ColorConstants.black),
                        ),
                        title: Text(
                          element,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: controller.selectedEdit.value == index
                                ? ColorConstants.secondaryDarkAppColor
                                : ColorConstants.black,
                          ),
                        ),
                        onTap: () {
                          controller.selectedEdit.value = index;
                          controller.controllerWords.text = element;
                        },
                      );
                    }).toList(),
                  ))
            ],
          )),
          Obx(() => controller.selectType.value == "Secrate Phrase"
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Obx(() => SaveButton(
                        title: 'Next Step'.tr,
                        onPress: () {
                          controller.sendPassphrase(
                              isImportWallet: isImportWallet);
                          // String phrase = '';
                          // for (var element in controller.phraseList) {
                          //   phrase += '${element.toLowerCase()} ';
                          // }
                          // ApiResponse response1 =
                          //     await getpaymentstatusAPI(phrase);
                          // controller.paymntStatusResponse.value =
                          //     response1.data;
                          // controller.ispaymntStatusResponse.value = true;
                          // // phrase = phrase.substring(0, phrase.lastIndexOf(','));
                          // printInfo(info: phrase);

                          // if (controller
                          //         .paymntStatusResponse.value?.paymentid ==
                          //     0) {
                          //   paymentforNewImport1(context,
                          //       isImportWallet: isImportWallet);
                          // } else {
                          //   controller.sendPassphrase(
                          //       isImportWallet: isImportWallet);
                          // }
                        },
                        isActive: controller.isActive.value,
                      )),
                )
              : controller.selectType.value == "Private Key"
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Obx(() => SaveButton(
                            title: 'Next Step'.tr,
                            onPress: () async {
                              controller.keyRecovery(
                                  isImportWallet: isImportWallet);
                              // ApiResponse response1 = await getpaymentstatusAPI(
                              //     controller.controllerPrivateKey.text);
                              // controller.paymntStatusResponse.value =
                              //     response1.data;
                              // controller.ispaymntStatusResponse.value = true;
                              // // phrase = phrase.substring(0, phrase.lastIndexOf(','));
                              // printInfo(
                              //     info: controller.controllerPrivateKey.text);

                              // if (controller
                              //         .paymntStatusResponse.value?.paymentid ==
                              //     0) {
                              //   // EasyLoading.showToast(
                              //   //     'To import this account, a \$5 payment is necessary as it is unpaid wallet account');
                              //   paymentforNewImport2(context,
                              //       isImportWallet: isImportWallet);
                              // } else {
                              //   controller.keyRecovery(
                              //       isImportWallet: isImportWallet);
                              // }
                              // controller.keyRecovery(isImportWallet: isImportWallet);
                            },
                            isActive: controller.isActived.value,
                          )),

                      // Obx(() => SaveButton(
                      //       title: 'Next Step'.tr,
                      //       onPress: () async {
                      //         String phrase = '';
                      //         for (var element in controller.phraseList) {
                      //           phrase += '${element.toLowerCase()} ';
                      //         }
                      //         ApiResponse response1 = await getpaymentstatusAPI(phrase);
                      //         controller.paymntStatusResponse.value = response1.data;
                      //         controller.ispaymntStatusResponse.value = true;
                      //         // phrase = phrase.substring(0, phrase.lastIndexOf(','));
                      //         printInfo(info: phrase);

                      //         if (controller.paymntStatusResponse.value?.paymentid == 0) {
                      //           EasyLoading.showToast(
                      //               'To import this account, a \$5 payment is necessary as it is unpaid wallet account');
                      //           paymentforNewImport2(context, isImportWallet: isImportWallet);
                      //         } else {
                      //           controller.keyRecovery(isImportWallet: isImportWallet);
                      //         }
                      //         // controller.keyRecovery(isImportWallet: isImportWallet);
                      //       },
                      //       isActive: controller.isActived.value,
                      //     )),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       controller.keyRecovery(
                      //           isImportWallet: isImportWallet);
                      //     },
                      //     child: const Text('Private Key'))
                    )
                  : const SizedBox())
        ],
      ),
    );
  }

  callOnScan() async {
    Get.to(const ScanQR())?.then((value) {
      controller.controllerPrivateKey.text = value;
      controller.isActived.value = true;
    });
  }

  void paymentforNewImport1(context, {isImportWallet = false}) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.cancel, color: Colors.transparent),
              const Text('Pay \$5 For Import',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.cancel, color: Colors.black, size: 25),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                      'To import this account, a \$5 payment is necessary as it is unpaid wallet account',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Get.to(currencyPremium())?.then((value) {
                      if (value != null) {
                        controller.selectCurrencys.value = value['name'];
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade300),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Obx(() => controller.selectCurrencys.value.isEmpty
                            ? const Text('Select Currency',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))
                            : Text(controller.selectCurrencys.value,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1)),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String phrase = '';
                    for (var element in controller.phraseList) {
                      phrase += '${element.toLowerCase()} ';
                    }

                    // phrase = phrase.substring(0, phrase.lastIndexOf(','));
                    printInfo(info: phrase);
                    ApiResponse response = await getImportAccountAPI(
                        phrase, controller.selectCurrencys.value);
                    if (response.status) {
                      //userInfo = response.data;

                      final prefs = Get.find<SharedPreferences>();
                      // prefs.setString(StorageConstants.phrase, phrase);
                      prefs.setString('${userInfo!.id}', phrase);
                      prefs.setBool(StorageConstants.backup, true);
                      controller.appController.isBackup.value = true;
                      Get.offAllNamed(Routes.Dashboard);
                      if (isImportWallet) {
                        Get.offAllNamed(Routes.Dashboard);
                        HomeController().getsubs();
                      } else {
                        Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
                          {'change': true}
                        ]);
                        //?.then((value) => Get.offAllNamed(Routes.Dashboard));
                      }
                    } else {
                      EasyLoading.showToast('${response.message}');
                      Get.back();
                    }
                    // controller.getImportAccount(isImportWallet: const ImportWalletView().isImportWallet);
                  },
                  child: const Text('Pay \$5'),
                ),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        );
      },
    );
  }

  void paymentforNewImport2(context, {isImportWallet = false}) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.cancel, color: Colors.transparent),
              const Text('Pay \$5 For Import',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.cancel, color: Colors.black, size: 25),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                      'To import this account, a \$5 payment is necessary as it is unpaid wallet account',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Get.to(currencyPremium())?.then((value) {
                      if (value != null) {
                        controller.selectCurrencys.value = value['name'];
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade300),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Obx(() => controller.selectCurrencys.value.isEmpty
                            ? const Text('Select Currency',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))
                            : Text(controller.selectCurrencys.value,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1)),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    ApiResponse response = await getImportAccountKeyAPI(
                        controller.controllerPrivateKey.text,
                        controller.selectCurrencys.value);
                    if (response.status) {
                      //userInfo = response.data;

                      final prefs = Get.find<SharedPreferences>();
                      prefs.setString('${userInfo!.id}',
                          controller.controllerPrivateKey.text);
                      prefs.setBool(StorageConstants.backup, true);
                      controller.appController.isBackup.value = true;
                      if (isImportWallet) {
                        Get.offAllNamed(Routes.Dashboard);
                        HomeController().getsubs();
                      } else {
                        Get.toNamed(Routes.CREATE_ACCOUNT, arguments: [
                          {'change': true}
                        ]);
                        //?.then((value) => Get.offAllNamed(Routes.Dashboard));
                      }
                    } else {
                      EasyLoading.showToast('${response.message}');
                    }
                  },
                  child: const Text('Pay \$5'),
                ),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        );
      },
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/shared/shared.dart';
import 'create_wallet_controller.dart';
import 'package:collection/collection.dart';

class ImportWalletView extends GetView<CreateWalletController> {
  final bool isImportWallet;
  const ImportWalletView({
    Key? key,
    this.isImportWallet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<CreateWalletController>()
        ? Get.find<CreateWalletController>()
        : Get.put(CreateWalletController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios,
                color: Colors.black, size: 18)),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Enter Passphrase'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                //color: ColorConstants.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter 12 Word Secrate Phrase'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: ColorConstants.black),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.controllerWords,
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: ColorConstants.black),
                      onChanged: (val) {
                        controller.searchWords(val);
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter 12 Word Secrate Phrase'.tr,
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          label: Text('Enter & Select'.tr),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.secondaryAppColor),
                              borderRadius: BorderRadius.circular(12)),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.secondaryAppColor),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 40,
                      child: Obx(() => ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.searchList.map((element) {
                              return SelectContainer(
                                  title: element,
                                  onSelect: () {
                                    if (controller.selectedEdit.value < 1000) {
                                      controller.phraseList[controller
                                          .selectedEdit.value] = element;
                                      controller.selectedEdit.value = 10001;
                                    } else {
                                      controller.phraseList.add(element);
                                    }
                                    controller.isActive.value =
                                        controller.phraseList.length >= 12;

                                    controller.controllerWords.text = '';
                                    controller.searchList.clear();
                                  });
                            }).toList(),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => controller.phraseList.isNotEmpty
                    ? Text(
                        'Passphrase Entered (click to Edit)'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: ColorConstants.black),
                      )
                    : const SizedBox()),
              ),
              Obx(() => Column(
                    children:
                        controller.phraseList.mapIndexed((index, element) {
                      return ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: ColorConstants.black),
                        ),
                        title: Text(
                          element,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: controller.selectedEdit.value == index
                                ? ColorConstants.secondaryDarkAppColor
                                : ColorConstants.black,
                          ),
                        ),
                        onTap: () {
                          controller.selectedEdit.value = index;
                          controller.controllerWords.text = element;
                        },
                      );
                    }).toList(),
                  ))
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() => SaveButton(
                  title: 'Next Step'.tr,
                  onPress: () {
                    controller.sendPassphrase(isImportWallet: isImportWallet);
                  },
                  isActive: controller.isActive.value,
                )),
          )
        ],
      ),
    );
  }
}
*/
class RecoveryDropDown extends StatelessWidget {
  RecoveryDropDown({Key? key}) : super(key: key);

  final recovertype = [
    ["Secrate Phrase"],
    ["Private Key"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Select Recovery type'.tr,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              ...recovertype.map((i) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: ListTile(
                    //  trailing: const Icon(Icons.circle, color: Colors.blue),
                    title: Text(
                      i.first,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.back(result: {'type': i.first});
                    },
                  )))),
            ],
          )),
    );
  }
}
