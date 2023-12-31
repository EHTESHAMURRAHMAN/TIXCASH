import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/shared/constants/colors.dart';
import 'package:tixcash/shared/constants/common.dart';
import 'create_account_controller.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),

        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: Text(
          'Select Password'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/icons/logo.png',
            height: MediaQuery.of(context).size.height / 10,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ListView(
              children: [
                Text(
                  'New Wallet Password'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(() => Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: controller.controllerNewPass,
                          onChanged: (val) {
                            controller.checkPassword(val);
                          },
                          obscureText: controller.isNewObscure.value,
                          decoration: InputDecoration(
                              hintText: 'New password'.tr,
                              hintStyle: const TextStyle(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.secondaryAppColor),
                                  borderRadius: BorderRadius.circular(20)),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.secondaryAppColor),
                                  borderRadius: BorderRadius.circular(20))),
                        )),
                        IconButton(
                            onPressed: () {
                              controller.isNewObscure.value =
                                  !controller.isNewObscure.value;
                            },
                            icon: Icon(
                              controller.isNewObscure.value
                                  ? Ionicons.eye_off
                                  : Ionicons.eye,
                              color: ColorConstants.secondaryDarkAppColor,
                            ))
                      ],
                    )),
                const SizedBox(
                  height: 8,
                ),
                Obx(() =>
                    controller.hintText(controller.isPasswordValid.value)),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Confirm Password'.tr,
                  style: const TextStyle(fontSize: CommonConstants.smallText),
                ),
                Obx(() => Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: controller.controllerConPass,
                          onChanged: (val) {
                            controller.checkPassword(val);
                          },
                          obscureText: controller.isConObscure.value,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password'.tr,
                              hintStyle: const TextStyle(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.secondaryAppColor),
                                  borderRadius: BorderRadius.circular(20)),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.secondaryAppColor),
                                  borderRadius: BorderRadius.circular(20))),
                        )),
                        IconButton(
                            onPressed: () {
                              controller.isConObscure.value =
                                  !controller.isConObscure.value;
                            },
                            icon: Icon(
                              controller.isConObscure.value
                                  ? Ionicons.eye_off
                                  : Ionicons.eye,
                              color: ColorConstants.secondaryDarkAppColor,
                            ))
                      ],
                    )),
                const SizedBox(
                  height: 8,
                ),
                Obx(() => controller
                    .hintTextConfirm(controller.isConPasswordValid.value)),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: controller.list.entries.map((item) {
                    return Obx(() => Row(
                          children: [
                            !item.value.valid.value
                                ? const Icon(
                                    MaterialCommunityIcons.alert_circle,
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
                                  color: item.value.valid.value
                                      ? Colors.green
                                      : Colors.red),
                            )
                          ],
                        ));
                  }).toList(),
                )
              ],
            ),
          )),
          Obx(() => GestureDetector(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: controller.isValid.value
                          ? ColorConstants.secondaryDarkAppColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      controller.isChangePassword.value
                          ? 'Change'.tr
                          : 'Next Step'.tr,
                      style:
                          const TextStyle(fontSize: CommonConstants.smallText),
                    ),
                  ),
                ),
                //  child:   Container(
                //           height: 50,
                //           padding: const EdgeInsets.all(8),
                //           color: controller.isValid.value ? ColorConstants.secondaryDarkAppColor : Colors.grey,
                //           child: Row(
                //             children: [
                //               const Expanded(child: SizedBox()),
                //               Text(
                //                 controller.isChangePassword.value ? 'Change'.tr : 'Next Step'.tr,
                //                 style: const TextStyle(fontSize: CommonConstants.smallText),
                //               ),
                //               const SizedBox(
                //                 width: 8,
                //               ),
                //               const Icon(Icons.arrow_forward)
                //             ],
                //           ),
                //         ),
                onTap: () {
                  if (controller.isValid.value) {
                    controller.onCreateUser(context);
                  } else {
                    EasyLoading.showToast('Enter correct password'.tr);
                  }
                },
              ))
        ],
      ),
    );
  }
}
