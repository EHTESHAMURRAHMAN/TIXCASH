import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/models/stackingListHistory.dart';
import 'package:tixcash/pages/Stack/Stack_Controller.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/constants/colors.dart';
import 'package:tixcash/shared/utils/common_widget.dart';

class StackViews extends GetView<StackController> {
  const StackViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getstakingDaylist();

    final controller1 = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stake'.tr,
          style: GoogleFonts.roboto(fontSize: 18),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                splashColor: Colors.white,
                onTap: () {
                  Get.toNamed(Routes.STACKINCOME);

                  ///Get.to(stakingIncome());
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/icons/sp_logo.png',
                          color: Colors.white,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        Text('My Earnings'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    Get.to(stakingIncomeHistory());
                  },
                  child: Icon(Icons.history,
                      color: Theme.of(context).primaryColor, size: 30)),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 22),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      controller.checkStakeAmount();
                    },
                    controller: controller.controllerStakeAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter the Amount'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
                        labelStyle: const TextStyle(fontSize: 12),
                        label: Text('Enter the Amount'.tr),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstants.secondaryAppColor),
                            borderRadius: BorderRadius.circular(20)),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstants.secondaryAppColor),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text('Available Balance :'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(width: 8),
                      Text(controller1.totalUSD.value.toStringAsFixed(2),
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                      const SizedBox(width: 4),
                      Text('TXH'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text('Duration'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 34, 27, 27))),
                  const SizedBox(height: 7),
                  InkWell(
                      onTap: () {
                        Get.to(ActiveStakeList())?.then((value) {
                          if (value != null) {
                            controller.selectStakeDays.value = value['plan'];
                          }
                          if (value != null) {
                            controller.selectid.value = value['id'];
                            controller.getstakingDaylist();
                            controller.getstakedate();
                            controller.stakedashboard();
                            controller.time();
                          }
                        });
                      },
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstants.secondaryAppColor),
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.grey.shade300
                          ),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(children: [
                                Obx(() => controller.selectid.value == 0
                                    ? Text(
                                        'Select Staking Plan'.tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          controller.selectStakeDays.value.tr,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                        ))),
                                const Spacer(),
                                const Icon(Icons.arrow_drop_down, size: 30)
                              ])))),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Lock-in Amount limit'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('Staking Limit Left'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => controller.selectid.value == 5
                          ? Text('Min : No Limit'.tr,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))
                          : Text('Min : 500 TXH'.tr,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))),
                      Obx(
                        () => controller.selectid.value == 5
                            ? Row(
                                children: [
                                  Text(
                                    'Unlimited'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'TXH',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              )
                            : controller.selectid.value == 0
                                ? const Row(
                                    children: [
                                      Text(
                                        '0.00',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'TXH',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Obx(() => Text(
                                            '${controller.stakeDashboardResponse.value?.remain}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          )),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'TXH',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() => controller.selectid.value == 0
                      ? Text('Max : No Limit'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ))
                      : Text('Max : 50k TXH'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ))),
                  const SizedBox(height: 20),

                  Obx(() => controller.selectid.value == 0
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Text('Date of Stake :'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(width: 15),
                                Text('YYYY : MM : DD'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Start Date :'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(width: 15),
                                Text('YYYY : MM : DD'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('End Date :'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(width: 15),
                                Text('YYYY : MM : DD'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Text('Date of Stake :'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(width: 15),
                                Text(
                                    controller.stakedateResponse.value
                                            ?.currentdate ??
                                        '',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Start Date :'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(width: 15),
                                Text(
                                    controller.stakedateResponse.value
                                            ?.stardate ??
                                        '',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('End Date :'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(width: 15),
                                Text(
                                    controller
                                            .stakedateResponse.value?.enddate ??
                                        '',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ],
                        )),
                  // Obx(() => controller.selectStakeDays.value == "1460 Days"
                  //     ? Column(
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Text('Date of Stake :'.tr,
                  //                   style: GoogleFonts.roboto(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold,
                  //                         )),
                  //               const SizedBox(width: 15),
                  //               Text(
                  //                   controller
                  //                           .stakedateResponse.value?.stardate ??
                  //                       '',
                  //                   style: GoogleFonts.roboto(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold,
                  //                         ))
                  //             ],
                  //           ),
                  //           const SizedBox(height: 10),
                  //           Row(
                  //             children: [
                  //               Text('Start Date :'.tr,
                  //                   style: GoogleFonts.roboto(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold,
                  //                         )),
                  //               const SizedBox(width: 15),
                  //               Text(first,
                  //                   style: GoogleFonts.roboto(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold,
                  //                         ))
                  //             ],
                  //           ),
                  //           const SizedBox(height: 10),
                  //           Row(
                  //             children: [
                  //               Text('End Date :'.tr,
                  //                   style: GoogleFonts.roboto(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold,
                  //                         )),
                  //               const SizedBox(width: 15),
                  //               Text(first1,
                  //                   style: GoogleFonts.roboto(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold,
                  //                         ))
                  //             ],
                  //           ),
                  //         ],
                  //       )
                  //     : controller.selectStakeDays.value == "730 Days"
                  //         ? Column(
                  //             children: [
                  //               Row(
                  //                 children: [
                  //                   Text('Date of Stake :'.tr,
                  //                       style: GoogleFonts.roboto(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                             )),
                  //                   const SizedBox(width: 15),
                  //                   Text(now,
                  //                       style: GoogleFonts.roboto(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                             ))
                  //                 ],
                  //               ),
                  //               const SizedBox(height: 10),
                  //               Row(
                  //                 children: [
                  //                   Text('Start Date :'.tr,
                  //                       style: GoogleFonts.roboto(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                             )),
                  //                   const SizedBox(width: 15),
                  //                   Text(first,
                  //                       style: GoogleFonts.roboto(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                             ))
                  //                 ],
                  //               ),
                  //               const SizedBox(height: 10),
                  //               Row(
                  //                 children: [
                  //                   Text('End Date :'.tr,
                  //                       style: GoogleFonts.roboto(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                             )),
                  //                   const SizedBox(width: 15),
                  //                   Text(first2,
                  //                       style: GoogleFonts.roboto(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                             ))
                  //                 ],
                  //               ),
                  //             ],
                  //           )
                  //         : controller.selectStakeDays.value == "365 Days"
                  //             ? Column(
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       Text('Date of Stake :'.tr,
                  //                           style: GoogleFonts.roboto(
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.bold,
                  //                                 )),
                  //                       const SizedBox(width: 15),
                  //                       Text(now,
                  //                           style: GoogleFonts.roboto(
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.bold,
                  //                                 ))
                  //                     ],
                  //                   ),
                  //                   const SizedBox(height: 10),
                  //                   Row(
                  //                     children: [
                  //                       Text('Start Date :'.tr,
                  //                           style: GoogleFonts.roboto(
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.bold,
                  //                                 )),
                  //                       const SizedBox(width: 15),
                  //                       Text(first,
                  //                           style: GoogleFonts.roboto(
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.bold,
                  //                                 ))
                  //                     ],
                  //                   ),
                  //                   const SizedBox(height: 10),
                  //                   Row(
                  //                     children: [
                  //                       Text('End Date :'.tr,
                  //                           style: GoogleFonts.roboto(
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.bold,
                  //                                 )),
                  //                       const SizedBox(width: 15),
                  //                       Text(first3,
                  //                           style: GoogleFonts.roboto(
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.bold,
                  //                                 ))
                  //                     ],
                  //                   ),
                  //                 ],
                  //               )
                  //             : controller.selectStakeDays.value == "90 Days"
                  //                 ? Column(
                  //                     children: [
                  //                       Row(
                  //                         children: [
                  //                           Text('Date of Stake :'.tr,
                  //                               style: GoogleFonts.roboto(
                  //                                   fontSize: 14,
                  //                                   fontWeight: FontWeight.bold,
                  //                                     )),
                  //                           const SizedBox(width: 15),
                  //                           Text(now,
                  //                               style: GoogleFonts.roboto(
                  //                                   fontSize: 14,
                  //                                   fontWeight: FontWeight.bold,
                  //                                     ))
                  //                         ],
                  //                       ),
                  //                       const SizedBox(height: 10),
                  //                       Row(
                  //                         children: [
                  //                           Text('Start Date :'.tr,
                  //                               style: GoogleFonts.roboto(
                  //                                   fontSize: 14,
                  //                                   fontWeight: FontWeight.bold,
                  //                                     )),
                  //                           const SizedBox(width: 15),
                  //                           Text(first,
                  //                               style: GoogleFonts.roboto(
                  //                                   fontSize: 14,
                  //                                   fontWeight: FontWeight.bold,
                  //                                     ))
                  //                         ],
                  //                       ),
                  //                       const SizedBox(height: 10),
                  //                       Row(
                  //                         children: [
                  //                           Text('End Date :'.tr,
                  //                               style: GoogleFonts.roboto(
                  //                                   fontSize: 14,
                  //                                   fontWeight: FontWeight.bold,
                  //                                     )),
                  //                           const SizedBox(width: 15),
                  //                           Text(first4,
                  //                               style: GoogleFonts.roboto(
                  //                                   fontSize: 14,
                  //                                   fontWeight: FontWeight.bold,
                  //                                     ))
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   )
                  //                 : controller.selectStakeDays.value ==
                  //                         "Whitelisted  (Staking Period:-  365 Days)"
                  //                     ? Column(
                  //                         children: [
                  //                           Row(
                  //                             children: [
                  //                               Text('Date of Stake :'.tr,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         )),
                  //                               const SizedBox(width: 15),
                  //                               Text(now,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         ))
                  //                             ],
                  //                           ),
                  //                           const SizedBox(height: 10),
                  //                           Row(
                  //                             children: [
                  //                               Text('Start Date :'.tr,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         )),
                  //                               const SizedBox(width: 15),
                  //                               Text(first,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         ))
                  //                             ],
                  //                           ),
                  //                           const SizedBox(height: 10),
                  //                           Row(
                  //                             children: [
                  //                               Text('End Date :'.tr,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         )),
                  //                               const SizedBox(width: 15),
                  //                               Text(first3,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         ))
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       )
                  //                     : Column(
                  //                         children: [
                  //                           Row(
                  //                             children: [
                  //                               Text('Date of Stake :'.tr,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         )),
                  //                               const SizedBox(width: 15),
                  //                               Text('00-00-0000',
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         ))
                  //                             ],
                  //                           ),
                  //                           const SizedBox(height: 10),
                  //                           Row(
                  //                             children: [
                  //                               Text('Start Date :'.tr,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         )),
                  //                               const SizedBox(width: 15),
                  //                               Text('00-00-0000',
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         ))
                  //                             ],
                  //                           ),
                  //                           const SizedBox(height: 10),
                  //                           Row(
                  //                             children: [
                  //                               Text('End Date :'.tr,
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         )),
                  //                               const SizedBox(width: 15),
                  //                               Text('00-00-0000',
                  //                                   style: GoogleFonts.roboto(
                  //                                       fontSize: 14,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                         ))
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Estimated APY :'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(width: 15),
                      Obx(() => controller.selectid.value == 0
                          ? const Text(
                              '0 %',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 14),
                            )
                          : Text(
                              '${controller.stakeDashboardResponse.value?.apy ?? '0'} %',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 14),
                            ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  // InputIconBox(
                  //   hint: 'Enter Referral Code'.tr,
                  //   // title: 'input receiving address'.tr,
                  //   title: ''.tr,

                  //   image: GestureDetector(
                  //     child: Text(
                  //       'PASTE'.tr,
                  //       style: GoogleFonts.roboto(
                  //           fontSize: 13,
                  //           fontWeight: FontWeight.w400,
                  //           color: const Color(0xFF40C4FF)),
                  //     ),
                  //     onTap: () async {
                  //       ClipboardData? data =
                  //           await Clipboard.getData('text/plain');
                  //       controller.controllerRefral.text = data?.text ?? '';
                  //       controller.getcheckreferall();
                  //     },
                  //   ),

                  //   //
                  //   controller: controller.controllerRefral,
                  //   onChange: (value) {
                  //     controller.getcheckreferall();
                  //   },
                  //   isScanner: true,
                  //   onScan: () {
                  //     controller.isScanEnable.value = true;
                  //     callOnScan();
                  //   },
                  // ),
                  Row(
                    children: [
                      Text('My Sponsor Referral Code :'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          )),
                      Obx(() => controller
                                  .sponCodeResponse.value?.sponsorcode ==
                              ''
                          ? Text('TXH',
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : Text(
                              '${controller.sponCodeResponse.value?.sponsorcode}'
                                  .tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))),
                      // const SizedBox(width: 15),
                      // InkWell(
                      //     onTap: () {
                      //       Clipboard.setData(ClipboardData(
                      //           text:
                      //               '${controller.sponCodeResponse.value?.sponsorcode}'));
                      //     },
                      //     child: Icon(
                      //       Icons.copy,
                      //       size: 20,
                      //       color: Theme.of(context).primaryColor,
                      //     ))
                    ],
                  )
                  // TextFormField(
                  //   onChanged: (value) {
                  //     controller.getcheckreferall();
                  //   },
                  //   controller: controller.controllerRefral,
                  //   style: GoogleFonts.roboto(
                  //       fontSize: 16, color: ColorConstants.black),
                  //   maxLength: 8,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter Referral Code'.tr,
                  //       hintStyle:
                  //           const TextStyle(   fontSize: 12),
                  //       labelStyle:
                  //           const TextStyle(   fontSize: 12),
                  //       label: Text('Enter Referral Code'.tr),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //               color: ColorConstants.secondaryAppColor),
                  //           borderRadius: BorderRadius.circular(20)),
                  //       border: InputBorder.none,
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //               color: ColorConstants.secondaryAppColor),
                  //           borderRadius: BorderRadius.circular(20))),
                  // ),
                ],
              ),
            ),
          ),
          // controller.whiteListResponse.value?.whiteliststatus == 0
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() => controller.selectid.value == 5
                  ? SaveButton(
                      title: 'Next Step'.tr,
                      onPress: () {
                        controller.whiteListResponse.value?.whiteliststatus == 0
                            ? EasyLoading.showToast(
                                'You Are Not Whitelisted Member'.tr)
                            : Get.to(StakeDetails());
                      },
                      isActive: controller.isActived.value &&
                          controller.selectStakeDays.value.isNotEmpty)
                  : SaveButton(
                      title: 'Next Step'.tr,
                      onPress: () {
                        // controller.wh iteListResponse.value?.whiteliststatus == 1
                        //     ? EasyLoading.showToast(
                        //         'You Are WhiteListed. You Can Stake In white List')
                        //     :
                        Get.to(StakeDetails());
                      },
                      isActive: controller.isActived.value &&
                          controller.selectStakeDays.value.isNotEmpty))),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tixcash/pages/Stack/Stack_Controller.dart';

// class StackViews extends GetView<StackController> {
//   const StackViews({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Stack'.tr,
//           style: GoogleFonts.roboto(fontSize: 18),
//         ),
//         centerTitle: true,
//         leading: InkWell(
//             onTap: () => Get.back(),
//             child: const Icon(
//               Icons.arrow_back_ios,
//
//             )),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarIconBrightness: Brightness.dark,
//           statusBarBrightness: Brightness.dark,
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 14),
//         child: ListView(children: [
//           const SizedBox(height: 3),
//           Column(
//             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.asset('assets/icons/logo.png',
//                   height: MediaQuery.of(context).size.height / 6),
//               const SizedBox(height: 15),
//               const SizedBox(height: 15),
//               Container(
//                   height: 110,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(18),
//                       boxShadow: const [
//                         BoxShadow(
//                               12,
//                             offset: Offset(2, 2),
//                             spreadRadius: 2,
//                             blurRadius: 4)
//                       ]),
//                   child: Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(18),
//                               bottomLeft: Radius.circular(18)),
//                         ),
//                         height: 110,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('01',
//                                 style: TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white)),
//                             Text('Year',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white)),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 8),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               children: [
//                                 Text('Min : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('500 TXH',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text('Max : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('50K TXH',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text('APY : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('Floating',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   )),
//               const SizedBox(height: 25),
//               Container(
//                   height: 110,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(18),
//                       boxShadow: const [
//                         BoxShadow(
//                               12,
//                             offset: Offset(2, 2),
//                             spreadRadius: 2,
//                             blurRadius: 4)
//                       ]),
//                   child: Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(18),
//                               bottomLeft: Radius.circular(18)),
//                         ),
//                         height: 110,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('04',
//                                 style: TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white)),
//                             Text('Years',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white)),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 8),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               children: [
//                                 Text('Min : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('500 TXH',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text('Max : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('50K TXH',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text('APY : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('Floating',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   )),
//               const SizedBox(height: 25),
//               Container(
//                   height: 110,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(18),
//                       boxShadow: const [
//                         BoxShadow(
//                               12,
//                             offset: Offset(2, 2),
//                             spreadRadius: 2,
//                             blurRadius: 4)
//                       ]),
//                   child: Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(18),
//                               bottomLeft: Radius.circular(18)),
//                         ),
//                         height: 110,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.person, size: 50),
//                             Text('Whitelisted',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white)),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 8),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               children: [
//                                 Text('Min : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('No Limit',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text('Max : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('No Limit',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text('APY : ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor)),
//                                 const Text('Floating',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                           )),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   )),
//             ],
//           )
//         ]),
//       ),
//     );
//   }
// }

class stakingIncomeHistory extends GetView {
  stakingIncomeHistory({Key? key}) : super(key: key);

  @override
  StackController controller = Get.put(StackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Staking History'.tr,
            style: GoogleFonts.roboto(fontSize: 18),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Obx(
          () => controller.stakingListHistoryModelResponse.isEmpty
              ? Center(
                  child: Text('No Stake History'.tr,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )))
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    StakingListHistoryModel model = controller
                        .stakingListHistoryModelResponse
                        .elementAt(index);
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          height: MediaQuery.of(context).size.height / 3.9,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text('Amount :'.tr,
                                        style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(width: 17),
                                    Text('${model.amount}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Transaction Date :'.tr,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(width: 17),
                                    Text(model.transactiondate,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Remark'.tr,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(width: 17),
                                    Text(model.remark.tr,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                //         Row(children: [Text('Txthash :'.tr,

                                //  maxLines: 1,   style: GoogleFonts.roboto(
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.bold,
                                //        color: Theme.of(context).primaryColor)),
                                // const SizedBox(width: 17),
                                // Text(model.txthash,
                                //     style: GoogleFonts.roboto(
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.bold,
                                //           )),],),
                                Row(
                                  children: [
                                    Text('Status :'.tr,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(width: 17),
                                    Text(model.status.tr,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Gas fee :'.tr,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(width: 17),
                                    Text('${model.gasfee}'.tr,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Staking :'.tr,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(width: 17),
                                    Text(model.staking,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('TXT hash :'.tr,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(width: 17),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(model.txthash,
                                          maxLines: 2,
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                              text: model.txthash));
                                        },
                                        child: Icon(
                                          Icons.copy,
                                          color: Theme.of(context).primaryColor,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ])),
                    );
                  },
                  itemCount: controller.stakingListHistoryModelResponse.length,
                ),
        ));
  }
}

class StakeDetails extends StatelessWidget {
  StakeDetails({Key? key}) : super(key: key);

  StackController controller = Get.put(StackController());
  SendTyvController sendController = Get.put(SendTyvController());

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
          'Stake'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),

        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('- ${controller.controllerAmount.text}',
            //         // '${controller.commissionAmount.value} LINE',
            //         style: GoogleFonts.roboto(
            //             fontSize: 25,
            //             fontWeight: FontWeight.bold,
            //               )),
            //     Obx(() => Text(
            //           ' ${controller.currencyResponse.value?.currency}',
            //           style: GoogleFonts.roboto(
            //               fontSize: 22,
            //               fontWeight: FontWeight.w600,
            //                 ),
            //         )),
            //   ],
            // ),
            const SizedBox(height: 30),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Amount :'.tr,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                    ' ${controller.controllerStakeAmount.text}',
                                    // '${controller.commissionAmount.value} LINE',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ]),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Remark'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('Staking'.tr,
                                  maxLines: 1,
                                  // '${controller.commissionAmount.value} LINE',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Network fee'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  '${sendController.commissionAmount.value} TXH',
                                  // '${controller.commissionAmount.value} LINE',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Max Total'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const Spacer(),
                              Obx(() => Text(
                                  '${double.parse(controller.controllerStakeAmount.text.toString()) + sendController.commissionAmount.value}',
                                  // '${controller.commissionAmount.value} LINE',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )))
                            ],
                          ),
                        ],
                      ),
                    ))),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: ColorConstants.secondaryDarkAppColor),
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              'Stake'.tr,
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        onTap: () {
          controller.stake();
        },
      ),
    );
  }
}
