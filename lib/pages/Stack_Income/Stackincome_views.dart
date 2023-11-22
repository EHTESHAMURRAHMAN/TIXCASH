import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/Stack/Stack_Controller.dart';
import 'package:tixcash/pages/Stack_Income/Stackincome_controller.dart';
import 'package:tixcash/pages/Stack/timer.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_controller.dart';
import 'package:tixcash/shared/constants/colors.dart';
import 'package:tixcash/shared/utils/common_widget.dart';

class txhincome extends GetView<StackIncomeController> {
  const txhincome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.stackcontroller.getstakingDaylist();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios,
                        size: 22, color: Colors.black)),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/icons/logo.png',
                  height: MediaQuery.of(context).size.height / 25,
                ),
                Text(
                  'TXH'.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      Get.to(ActiveStakeList())?.then((value) {
                        if (value != null) {
                          controller.stackcontroller.selectStakeDays.value =
                              value['plan'];
                        }
                        if (value != null) {
                          controller.stackcontroller.selectid.value =
                              value['id'];
                          controller.stackcontroller.getstakedate();
                          controller.stakedashboard();
                          StackController().getstakingDaylist();
                        }
                      });
                    },
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          // border: Border.all(
                          //     color: ColorConstants.secondaryAppColor),
                          borderRadius: BorderRadius.circular(11),
                          // color: Colors.grey.shade300
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(children: [
                              Obx(() => controller.stackcontroller
                                      .selectStakeDays.value.isEmpty
                                  ? Text(
                                      'Select Staking Plan'.tr,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Text(
                                        controller.stackcontroller
                                            .selectStakeDays.value,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        maxLines: 1,
                                      ))),
                              const Spacer(),
                              const Icon(Icons.arrow_drop_down,
                                  color: Colors.black, size: 30)
                            ])))),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height / 1,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(
            () => controller.stackcontroller.selectid.value == 0
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Staked\nValue'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          '00.00',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total\nRewards'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          '00.0',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pending\nRewards'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          '00.0',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Daily\nReward'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          '0.00',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Staking\nPeriod'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          '00',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'Days',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'APY'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 23),
                                        ),
                                        const Text(
                                          '00 %',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Staking Start Date'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'DD : MM : YYYY',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width / 2.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Staking End Date'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          'DD : MM : YYYY'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ])),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 15),
                                        Text(
                                          'Income Report'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          'User Initiated Staking'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'DD : MM : YYYY',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 75,
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: Colors.grey.shade300),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Staked Amount'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          const Text(
                                            '0.0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 16),
                                          ),
                                          const Text(
                                            'TXH',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Staking Income'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          '0.0',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 25),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 75,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              color: Colors.grey.shade300),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Staking Limit Left'.tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                              const Text(
                                                '0.0',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                              const Text(
                                                'TXH',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 55,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              color: Colors.grey.shade300),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Paid Days'.tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                              const Text(
                                                '0',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Unclaimed Income'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '0.0',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 25),
                                        ),
                                        Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        SizedBox(height: 10),
                                        Icon(CupertinoIcons.alarm,
                                            color: Colors.black, size: 30)
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  color: Colors.black,
                                                  child: const Text(
                                                    '00',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                const Text(
                                                  'HRS',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 2),
                                            const Text(
                                              ':',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(width: 2),
                                            Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  color: Colors.black,
                                                  child: const Text(
                                                    '00',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                const Text(
                                                  'MINS',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 2),
                                            const Text(
                                              ':',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(width: 2),
                                            Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  color: Colors.black,
                                                  child: const Text(
                                                    '00',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                const Text(
                                                  'SECS',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),

                                        // Text(
                                        //   controller.time.value,
                                        //   style: GoogleFonts.oswald(
                                        //       fontWeight: FontWeight.bold,
                                        //       color: Colors.black,
                                        //       fontSize: 25),
                                        // ),
                                        const SizedBox(height: 10),
                                        Container(
                                          height: 40,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: Text('Claim Now'.tr,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Staked\nValue'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.totalstaked}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total\nRewards'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.totalreward}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pending\nRewards'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.pendingreward}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Daily\nReward'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.dailyreward}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 12),
                                        ),
                                        const Text(
                                          'TXH/Day',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Staking\nPeriod'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.stakingdays}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Days'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 85,
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'APY'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 23),
                                        ),
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.apy}%',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width / 2.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Staking Start Date'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.stakingstart}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width / 2.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Staking End Date'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.stakingend}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ])),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Income Report'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 50),
                                    Text(
                                      'User Initiated Staking'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${controller.stakeDashboardResponse.value?.userstakindate}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 17),
                                    ),
                                    const SizedBox(height: 17),
                                    Text(
                                      'Total Staking Income'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${controller.stakeDashboardResponse.value?.totalsincome}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 30),
                                    ),
                                    const SizedBox(height: 3),
                                    const Text(
                                      'TXH',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 85,
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: Colors.grey.shade300),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Staked Amount'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            '${controller.stakeDashboardResponse.value?.stakedamt}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 17),
                                          ),
                                          const Text(
                                            'TXH',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 85,
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: Colors.grey.shade300),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Staking Limit Left'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          controller.stackcontroller.selectid
                                                      .value ==
                                                  5
                                              ? const Text(
                                                  'No Limit',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                )
                                              : Text(
                                                  '${controller.stakeDashboardResponse.value?.remain}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                          const Text(
                                            'TXH',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 55,
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: Colors.grey.shade300),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Paid Days'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            '${controller.stakeDashboardResponse.value?.paid}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           'Income Report',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color:
                                //                   Colors.black,
                                //               fontSize: 15),
                                //         ),
                                //         const SizedBox(height: 20),
                                //         Text(
                                //           'User Initiated Staking',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color:
                                //                   Colors.black,
                                //               fontSize: 12),
                                //         ),
                                //         Text(
                                //           '${controller.stakeDashboardResponse.value?.userstakindate}',
                                //           style: const TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color: Colors.black,
                                //               fontSize: 15),
                                //         ),
                                //         Text(
                                //           'Total Staking Income',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color:
                                //                   Colors.black,
                                //               fontSize: 12),
                                //         ),
                                //         Text(
                                //           '${controller.stakeDashboardResponse.value?.totalsincome}',
                                //           style: const TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color: Colors.black,
                                //               fontSize: 25),
                                //         ),
                                //         Text(
                                //           'TXH',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color:
                                //                   Colors.black,
                                //               fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //     const Spacer(),
                                //     Container(
                                //       padding: const EdgeInsets.all(10),
                                //       height: 70,
                                //       width:
                                //           MediaQuery.of(context).size.width / 2.4,
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(11),
                                //           color: Colors.grey.shade300),
                                //       child: Column(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceEvenly,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             'Staked Amount',
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 color: Theme.of(context)
                                //                     .primaryColor,
                                //                 fontSize: 12),
                                //           ),
                                //           Text(
                                //             '${controller.stakeDashboardResponse.value?.stakedamt}',
                                //             style: const TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 color: Colors.black,
                                //                 fontSize: 12),
                                //           ),
                                //           Text(
                                //             'TXH',
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 color: Theme.of(context)
                                //                     .primaryColor,
                                //                 fontSize: 12),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           'Total Staking Income',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color:
                                //                   Colors.black,
                                //               fontSize: 12),
                                //         ),
                                //         Text(
                                //           '${controller.stakeDashboardResponse.value?.totalsincome}',
                                //           style: const TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color: Colors.black,
                                //               fontSize: 25),
                                //         ),
                                //         Text(
                                //           'TXH',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               color:
                                //                   Colors.black,
                                //               fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //     const Spacer(),
                                //     Column(
                                //       children: [
                                //         Container(
                                //           padding: const EdgeInsets.all(10),
                                //           height: 70,
                                //           width:
                                //               MediaQuery.of(context).size.width /
                                //                   2.4,
                                //           decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(16),
                                //               color: Colors.grey.shade300),
                                //           child: Column(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.spaceEvenly,
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               Text(
                                //                 'Staking Limit Left',
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Theme.of(context)
                                //                         .primaryColor,
                                //                     fontSize: 12),
                                //               ),
                                //               Text(
                                //                 '${controller.stakeDashboardResponse.value?.remain}',
                                //                 style: const TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Colors.black,
                                //                     fontSize: 12),
                                //               ),
                                //               Text(
                                //                 'TXH',
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Theme.of(context)
                                //                         .primaryColor,
                                //                     fontSize: 12),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //         const SizedBox(height: 10),
                                //         Container(
                                //           padding: const EdgeInsets.all(10),
                                //           height: 55,
                                //           width:
                                //               MediaQuery.of(context).size.width /
                                //                   2.4,
                                //           decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(16),
                                //               color: Colors.grey.shade300),
                                //           child: Column(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.spaceEvenly,
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               Text(
                                //                 'Paid Days',
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Theme.of(context)
                                //                         .primaryColor,
                                //                     fontSize: 12),
                                //               ),
                                //               Text(
                                //                 '${controller.stakeDashboardResponse.value?.paid}',
                                //                 style: const TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Colors.black,
                                //                     fontSize: 12),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                              ],
                            )),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Unclaimed Income'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.stakeDashboardResponse.value?.unclaim}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 25),
                                        ),
                                        const Text(
                                          'TXH',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        const SizedBox(height: 10),
                                        const Icon(CupertinoIcons.alarm,
                                            color: Colors.black, size: 30)
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const CountdownTimerDemo(),
                                        const SizedBox(height: 5),
                                        Obx(() => controller
                                                    .stakeDashboardResponse
                                                    .value
                                                    ?.unclaim ==
                                                0
                                            ? Container(
                                                height: 37,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.red
                                                        .withOpacity(.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: Text('Claim Now'.tr,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white)),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Get.to(StakeClaimDetails());
                                                  //controller.claimStake();
                                                },
                                                child: Container(
                                                  height: 37,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Center(
                                                    child: Text('Claim Now'.tr,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white)),
                                                  ),
                                                )))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
          )),
    );
  }
}

class StakeClaimDetails extends StatelessWidget {
  StakeClaimDetails({Key? key}) : super(key: key);

  StackIncomeController controller = Get.put(StackIncomeController());
  SendTyvController sendController = Get.put(SendTyvController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: Text(
          'Stake Claim'.tr,
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
            //             color: Colors.black)),
            //     Obx(() => Text(
            //           ' ${controller.currencyResponse.value?.currency}',
            //           style: GoogleFonts.roboto(
            //               fontSize: 22,
            //               fontWeight: FontWeight.w600,
            //               color: Colors.black),
            //         )),
            //   ],
            // ),
            const SizedBox(height: 30),
            Container(
              //  margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount :'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Text(
                            '${controller.stakeDashboardResponse.value?.unclaim.toStringAsFixed(2)}',
                            // '${controller.commissionAmount.value} LINE',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                      ]),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Remark'.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      Text('Stake Income'.tr,
                          maxLines: 1,
                          // '${controller.commissionAmount.value} LINE',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Network fee'.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      Text('${sendController.commissionAmount.value} TXH',
                          // '${controller.commissionAmount.value} LINE',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Max Total'.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      const Spacer(),
                      Obx(() => Text(
                          '${controller.stakeDashboardResponse.value!.unclaim - sendController.commissionAmount.value}',
                          // '${controller.commissionAmount.value} LINE',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: ColorConstants.secondaryDarkAppColor),
          height: 55,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              'Claim'.tr,
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        onTap: () {
          controller.stackcontroller.claimStake();
        },
      ),
    );
  }
}
