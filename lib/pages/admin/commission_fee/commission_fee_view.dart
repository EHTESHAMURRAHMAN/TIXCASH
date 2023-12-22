import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/pages/dashboard/home_navigation/home_navigation_view.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:tixcash/shared/utils/sa_textstyles.dart';

import 'commission_fee_controller.dart';

class CommissionFeeView extends GetView<CommissionFeeController> {
  const CommissionFeeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeNavigationView(
        child: Container(
      color: ColorConstants.blackBg,
      // padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ListView(
              children: [
                Text(
                  'Internal transfer fee'.tr,
                  style: commissionFeeNormal,
                ),
                InputCommission(
                  title: 'Amount less'.tr,
                  controllerAmount: controller.controllerAmountLesIntern,
                  controllerFee: controller.controllerFeeLesIntern,
                ),
                const Divider(),
                InputCommission(
                  title: 'Amount more'.tr,
                  controllerAmount: controller.controllerAmountMoreIntern,
                  controllerFee: controller.controllerFeeMoreIntern,
                ),

                const Divider(),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  'External transfer commission amount'.tr,
                  style: commissionFeeNormal,
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: controller.controllerExternalTrans,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text(
                        'LINE',
                        style: commissionFee16,
                      ),
                    )
                  ],
                ),

                InputCommission(
                  title: 'Amount less',
                  controllerAmount: controller.controllerAmountLesExtern,
                  controllerFee: controller.controllerFeeLesExtern,
                ),
                const Divider(),
                InputCommission(
                  title: 'Amount more',
                  controllerAmount: controller.controllerAmountMoreExtern,
                  controllerFee: controller.controllerFeeMoreExtern,
                ),
                // External transfer commission amount
                const Divider()
              ],
            ),
          )),
          SaveButton(
              title: 'Save',
              onPress: () {
                controller.submitData();
                Get.offAllNamed(Routes.Dashboard);
              })
        ],
      ),
    ));
  }
}

class InputCommission extends StatelessWidget {
  final String title;
  final TextEditingController controllerAmount; // = TextEditingController();
  final TextEditingController controllerFee; // = TextEditingController();
  const InputCommission(
      {Key? key,
      required this.title,
      required this.controllerAmount,
      required this.controllerFee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title.tr,
              style: commissionFeeNormal,
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: controllerAmount,
              textAlign: TextAlign.center,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: controllerFee,
              textAlign: TextAlign.center,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              //   TextInputFormatter.withFunction((oldValue, newValue) {
              //     try {
              //       final text = newValue.text;
              //       if (text.isNotEmpty) double.parse(text);
              //       return newValue;
              //     } catch (e) {
              //       print(e.toString());
              //     }
              //     return oldValue;
              //   }),
              // ],

              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'LINE',
              style: commissionFee16,
            ),
          ),
        ],
      ),
    );
  }
}
