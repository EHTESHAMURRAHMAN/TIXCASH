import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/scan_qr.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_view.dart';
import 'package:tixcash/shared/shared.dart';
import 'create_wallet_controller.dart';

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
            child: const Icon(Icons.arrow_back_ios, size: 18)),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Import an Account'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
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
                            if (value != null) {
                              controller.selectid.value = value['id'];
                            }
                          });
                        },
                        child: SizedBox(
                            height: 55,
                            child: Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(children: [
                                    Obx(() => controller.selectid.value == 0
                                        ? Text(
                                            'Select Recover Account Type'.tr,
                                            style: const TextStyle(
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
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                            ))),
                                    const Spacer(),
                                    const Icon(Icons.arrow_drop_down, size: 30)
                                  ]),
                                )))),
                    const SizedBox(height: 10),
                    Obx(() => controller.selectid.value == 1
                        ? Column(
                            children: [
                              const SizedBox(height: 12),
                              InputIconBox(
                                hint: 'Enter 24 Word Secret Phrase'.tr,
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
                                    controller.controllerphrase.text =
                                        data?.text ?? '';
                                    controller.isphraseActive.value = controller
                                        .controllerphrase.text.isNotEmpty;
                                  },
                                ),

                                //
                                controller: controller.controllerphrase,
                                onChange: (value) {
                                  controller.isphraseActive.value = controller
                                      .controllerphrase.text.isNotEmpty;
                                },
                                isScanner: true,
                                onScan: () {
                                  controller.isScanEnable.value = true;
                                  callOnScan1();
                                },
                              ),
                              isImportWallet == false
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 60,
                                          child: TextFormField(
                                            controller: controller
                                                .createController
                                                .controllerNewPass,
                                            onChanged: (val) {
                                              controller.createController
                                                  .checkPassword(val);
                                            },
                                            obscureText: controller
                                                .createController
                                                .isNewObscure
                                                .value,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      controller
                                                              .createController
                                                              .isNewObscure
                                                              .value =
                                                          !controller
                                                              .createController
                                                              .isNewObscure
                                                              .value;
                                                    },
                                                    icon: Icon(
                                                      controller
                                                              .createController
                                                              .isNewObscure
                                                              .value
                                                          ? Ionicons.eye_off
                                                          : Ionicons.eye,
                                                      color: ColorConstants
                                                          .secondaryDarkAppColor,
                                                    )),
                                                hintText: 'New password'.tr,
                                                hintStyle: const TextStyle(),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorConstants
                                                            .secondaryAppColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                border: InputBorder.none,
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorConstants
                                                            .secondaryAppColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Obx(() => controller.createController
                                            .hintText(controller
                                                .createController
                                                .isPasswordValid
                                                .value)),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 60,
                                          child: TextFormField(
                                            controller: controller
                                                .createController
                                                .controllerConPass,
                                            onChanged: (val) {
                                              controller.createController
                                                  .checkPassword(val);
                                            },
                                            obscureText: controller
                                                .createController
                                                .isConObscure
                                                .value,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      controller
                                                              .createController
                                                              .isConObscure
                                                              .value =
                                                          !controller
                                                              .createController
                                                              .isConObscure
                                                              .value;
                                                    },
                                                    icon: Icon(
                                                      controller
                                                              .createController
                                                              .isConObscure
                                                              .value
                                                          ? Ionicons.eye_off
                                                          : Ionicons.eye,
                                                      color: ColorConstants
                                                          .secondaryDarkAppColor,
                                                    )),
                                                hintText: 'Confirm Password'.tr,
                                                hintStyle: const TextStyle(),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorConstants
                                                            .secondaryAppColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                border: InputBorder.none,
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorConstants
                                                            .secondaryAppColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Obx(() => controller.createController
                                            .hintTextConfirm(controller
                                                .createController
                                                .isConPasswordValid
                                                .value)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Column(
                                          children: controller
                                              .createController.list.entries
                                              .map((item) {
                                            return Obx(() => Row(
                                                  children: [
                                                    !item.value.valid.value
                                                        ? const Icon(
                                                            MaterialCommunityIcons
                                                                .alert_circle,
                                                            size: 16,
                                                            color: Colors.red,
                                                          )
                                                        : const Icon(
                                                            Icons.check_circle,
                                                            size: 16,
                                                            color: Colors.green,
                                                          ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      item.value.label,
                                                      style: TextStyle(
                                                          color: item.value
                                                                  .valid.value
                                                              ? Colors.green
                                                              : Colors.red),
                                                    )
                                                  ],
                                                ));
                                          }).toList(),
                                        )
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          )
                        : controller.selectid.value == 2
                            ? Column(
                                children: [
                                  const SizedBox(height: 12),
                                  InputIconBox(
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
                                            await Clipboard.getData(
                                                'text/plain');
                                        controller.controllerPrivateKey.text =
                                            data?.text ?? '';
                                        controller.isActived.value = controller
                                            .controllerPrivateKey
                                            .text
                                            .isNotEmpty;
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
                                  ),
                                  isImportWallet == false
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              height: 60,
                                              child: TextFormField(
                                                controller: controller
                                                    .createController
                                                    .controllerNewPass,
                                                onChanged: (val) {
                                                  controller.createController
                                                      .checkPassword(val);
                                                },
                                                obscureText: controller
                                                    .createController
                                                    .isNewObscure
                                                    .value,
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                          controller
                                                                  .createController
                                                                  .isNewObscure
                                                                  .value =
                                                              !controller
                                                                  .createController
                                                                  .isNewObscure
                                                                  .value;
                                                        },
                                                        icon: Icon(
                                                          controller
                                                                  .createController
                                                                  .isNewObscure
                                                                  .value
                                                              ? Ionicons.eye_off
                                                              : Ionicons.eye,
                                                          color: ColorConstants
                                                              .secondaryDarkAppColor,
                                                        )),
                                                    hintText: 'New password'.tr,
                                                    hintStyle:
                                                        const TextStyle(),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ColorConstants
                                                                .secondaryAppColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    border: InputBorder.none,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ColorConstants
                                                                .secondaryAppColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Obx(() => controller
                                                .createController
                                                .hintText(controller
                                                    .createController
                                                    .isPasswordValid
                                                    .value)),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              height: 60,
                                              child: TextFormField(
                                                controller: controller
                                                    .createController
                                                    .controllerConPass,
                                                onChanged: (val) {
                                                  controller.createController
                                                      .checkPassword(val);
                                                },
                                                obscureText: controller
                                                    .createController
                                                    .isConObscure
                                                    .value,
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                          controller
                                                                  .createController
                                                                  .isConObscure
                                                                  .value =
                                                              !controller
                                                                  .createController
                                                                  .isConObscure
                                                                  .value;
                                                        },
                                                        icon: Icon(
                                                          controller
                                                                  .createController
                                                                  .isConObscure
                                                                  .value
                                                              ? Ionicons.eye_off
                                                              : Ionicons.eye,
                                                          color: ColorConstants
                                                              .secondaryDarkAppColor,
                                                        )),
                                                    hintText:
                                                        'Confirm Password'.tr,
                                                    hintStyle:
                                                        const TextStyle(),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ColorConstants
                                                                .secondaryAppColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    border: InputBorder.none,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ColorConstants
                                                                .secondaryAppColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Obx(() => controller
                                                .createController
                                                .hintTextConfirm(controller
                                                    .createController
                                                    .isConPasswordValid
                                                    .value)),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Column(
                                              children: controller
                                                  .createController.list.entries
                                                  .map((item) {
                                                return Obx(() => Row(
                                                      children: [
                                                        !item.value.valid.value
                                                            ? const Icon(
                                                                MaterialCommunityIcons
                                                                    .alert_circle,
                                                                size: 16,
                                                                color:
                                                                    Colors.red,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .check_circle,
                                                                size: 16,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          item.value.label,
                                                          style: TextStyle(
                                                              color: item
                                                                      .value
                                                                      .valid
                                                                      .value
                                                                  ? Colors.green
                                                                  : Colors.red),
                                                        )
                                                      ],
                                                    ));
                                              }).toList(),
                                            )
                                          ],
                                        )
                                      : SizedBox()
                                ],
                              )
                            : const SizedBox()),
                    const SizedBox(
                      height: 16,
                    ),
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
            ],
          )),
          Obx(() => controller.selectid.value == 1
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Obx(() => isImportWallet == false
                      ? SaveButton(
                          title: 'Next Step'.tr,
                          onPress: () {
                            controller.sendPassphrase(
                                isImportWallet: isImportWallet);
                          },
                          isActive: controller.isphraseActive.value &&
                              controller.createController.isValid.value,
                        )
                      : SaveButton(
                          title: 'Next Step'.tr,
                          onPress: () {
                            controller.sendPassphrase(
                                isImportWallet: isImportWallet);
                          },
                          isActive: controller.isphraseActive.value,
                        )),
                )
              : controller.selectid.value == 2
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Obx(() => isImportWallet == false
                          ? SaveButton(
                              title: 'Next Step'.tr,
                              onPress: () async {
                                controller.keyRecovery(
                                    isImportWallet: isImportWallet);
                              },
                              isActive: controller.isActived.value &&
                                  controller.createController.isValid.value,
                            )
                          : SaveButton(
                              title: 'Next Step'.tr,
                              onPress: () async {
                                controller.keyRecovery(
                                    isImportWallet: isImportWallet);
                              },
                              isActive: controller.isActived.value)),
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

  callOnScan1() async {
    Get.to(const ScanQR())?.then((value) {
      controller.controllerphrase.text = value;
      controller.isphraseActive.value = true;
    });
  }
}

class RecoveryDropDown extends StatelessWidget {
  RecoveryDropDown({Key? key}) : super(key: key);

  final recovertype = [
    ["Secret Phrase".tr, 1],
    ["Private Key".tr, 2],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Select Recovery type'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              ...recovertype.map((i) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: ListTile(
                    title: Text(
                      '${i.first}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.back(result: {'type': i.first, 'id': i.last});
                    },
                  )))),
            ],
          )),
    );
  }
}
