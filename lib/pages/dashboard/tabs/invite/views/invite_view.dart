import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:tixcash/models/referalclaimResp.dart';
import 'package:tixcash/models/refralincome.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/controllers/invite_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/views/ClaimReferral.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_controller.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/constants/colors.dart';

class InviteView extends GetView<InviteController> {
  const InviteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.inviteInits();
    controller.pendingdirectincome();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text('Refer Your Friends and Earn'.tr),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))),
              child: Column(
                children: [
                  Screenshot(
                      controller: controller.screenshotController,
                      child: Obx(() => QrImageView(
                            backgroundColor: Colors.white,
                            data:
                                '${controller.usercodeResponse.value?.refrellcode}',
                            version: QrVersions.auto,
                            size: 100.0,
                            // embeddedImage: const AssetImage(
                            //     'assets/icons/gift_icon.png')
                          ))),

                  // const SizedBox(
                  //   height: 24,
                  // ),
                  // Text(
                  //   'Your friend will get 1 USDT when completes his KYC and you will get 1 USDT when your friend completes first trade BUY or SELL',
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.titleMedium,
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  DottedBorder(
                    color: Theme.of(context).textTheme.titleMedium?.color ??
                        Colors.white,
                    strokeWidth: 1,
                    // borderType: BorderType.Rect,
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        //borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          Obx(() => Text(
                                '${controller.usercodeResponse.value?.refrellcode}',
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                          const Spacer(),
                          Container(
                            color: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color ??
                                Colors.white,
                            height: 30,
                            width: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                    text:
                                        '${controller.usercodeResponse.value?.refrellcode}'),
                              );
                              Get.snackbar('Copied',
                                  '${controller.usercodeResponse.value?.refrellcode}',
                                  backgroundColor: Colors.red);
                              // Get.snackbar('Copied', '',
                              //     snackPosition: SnackPosition.BOTTOM);
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Copy'.tr,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  'Code'.tr,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                      onTap: () {
                        shareQrCode();
                      },
                      child: const Center(child: Icon(Icons.share, size: 25))),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(const AboutReferral());
                        },
                        child: Container(
                            height: 35,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.yellow.shade400,
                                  Colors.pink,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'About Referral'.tr,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.MYREFERRAL);
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.yellow.shade400,
                                  Colors.pink,
                                ],
                              ),
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                'https://icons.veryicon.com/png/o/miscellaneous/my-icons/my-referral.png',
                                color: Colors.white,
                              ),
                            ))),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(ReferralIncomeHistory());
                        },
                        child: Container(
                            height: 35,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.yellow.shade400,
                                  Colors.pink,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'History'.tr,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Total Earning :'.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(width: 10),
                          Obx(() => Text(
                              '${controller.directincome.value?.totalamount.toStringAsFixed(2)}',
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text('Balance Amount :'.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(width: 10),
                          Obx(() => Text(
                              '${controller.directincome.value?.claimamount.toStringAsFixed(2)}',
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Obx(() => controller.directincome.value?.claimamount == 0
                      ? Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text('Claim'.tr,
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        )
                      : InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            Get.to(InviteClaimDetails());
                          },
                          child: Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text('Claim'.tr,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ),
                          ),
                        )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Obx(() => controller.referalIncomeModelResponse.isEmpty
                  ? Center(
                      child: Text('No Stake'.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)))
                  : Obx(
                      () => ListView.builder(
                        itemCount: controller.referalIncomeModelResponse.length,
                        itemBuilder: (context, index) {
                          ReferalIncomeModel model = controller
                              .referalIncomeModelResponse
                              .elementAt(index);

                          return ListTile(
                            title: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              margin: const EdgeInsets.symmetric(vertical: 3),
                              height: MediaQuery.of(context).size.height / 6.4,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue.shade50.withOpacity(.5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text('Amount :'.tr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      const SizedBox(width: 17),
                                      Text('${model.amount}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))
                                    ],
                                  ),
                                  const SizedBox(height: 7),
                                  const Divider(color: Colors.blue),
                                  const SizedBox(height: 7),
                                  Row(
                                    children: [
                                      Text('Transaction Date :'.tr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      const SizedBox(width: 15),
                                      Text(model.transactiondate,
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))
                                    ],
                                  ),
                                  const SizedBox(height: 7),
                                  Row(
                                    children: [
                                      Text('Remark'.tr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      const SizedBox(width: 15),
                                      Text(model.remark,
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))
                                    ],
                                  ),
                                  const SizedBox(height: 7),
                                  Row(
                                    children: [
                                      Text('Staking :'.tr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      const SizedBox(width: 15),
                                      Text(model.staking,
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // subtitle: Text(
                            //   'Staking Income'.tr,
                            //   style: GoogleFonts.roboto(fontSize: 18, color: Colors.black),
                            // ),
                          );
                        },
                      ),
                    )),
            )
          ],
        ));
    // const MessageCell(
    //     title: 'Who can refer friends',
    //     message:
    //         'Anyone can refer who are registered on Tixcash application'),
    //
    //
    // const MessageCell(title: 'Who can refer friends', message: 'Anyone can refer who has registered on BitLCT application or website'),
    // const MessageCell(title: 'Who can refer friends', message: 'Anyone can refer who has registered on BitLCT application or website'),
    // const MessageCell(title: 'Who can refer friends', message: 'Anyone can refer who has registered on BitLCT application or website'),
    // const MessageCell(title: 'Who can refer friends', message: 'Anyone can refer who has registered on BitLCT application or website'),
  }

  shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    controller.screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          await imagePath.writeAsBytes(image);

          Share.shareFiles([imagePath.path],
              text: controller.shareMessage.replaceAll(
                  '@@', controller.usercodeResponse.value?.refrellcode ?? ''));
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}

class stakingIncome extends GetView {
  stakingIncome({Key? key}) : super(key: key);

  @override
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.getsubs();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: ListView(children: [
          Container(
            height: size.height / 4,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1680ee),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            // launchUrlString('https://coinmarketcap.com/', mode: LaunchMode.externalApplication);
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/logo.png',
                    width: size.height / 5,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  //   Text('TIX WALLET', style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w700))
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
                "With Tixcash Wallet, you can participate in Staking and the Referral Program, allowing you to increase your earnings while holding your assets"
                    .tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
          ),
          const SizedBox(height: 30),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all()),
              ),
              InkWell(
                onTap: () {
                  controller.subscriptionResponse.value?.pid == 0
                      ? Get.toNamed(Routes.PREMIUM_VIEW)
                      : Get.toNamed(Routes.STACK);
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/stake1.png",
                          height: 40,
                        ),
                        const SizedBox(width: 15),
                        Text('Stake & Earn'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all()),
              ),
              InkWell(
                onTap: () {
                  controller.subscriptionResponse.value?.pid == 0
                      ? Get.toNamed(Routes.PREMIUM_VIEW)
                      : Get.toNamed(Routes.REFRAL);
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/referral1.png",
                          height: 40,
                        ),
                        const SizedBox(width: 15),
                        Text('Refer & Earn'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all()),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.PREMIUM_VIEW);
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRect(
                              child: Image.asset(
                                "assets/icons/premium1.jpeg",
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text('Get VIP Access'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ]));
  }
}

class MessageCell extends StatelessWidget {
  final String title;
  final String message;
  const MessageCell({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(50))),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(message)
                // Row(children: [
                //   Expanded(child: Text(message)),
                //   const SizedBox(),
                // ],)
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class ReferralIncomeHistory extends GetView {
  ReferralIncomeHistory({Key? key}) : super(key: key);

  @override
  InviteController controller = Get.put(InviteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Referral Claim History'.tr,
            style: GoogleFonts.roboto(fontSize: 18),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Obx(
          () => controller.referralClaimlistModelResponse.isEmpty
              ? Center(
                  child: Text('No Referral History'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)))
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ReferralClaimlistModel model = controller
                        .referralClaimlistModelResponse
                        .elementAt(index);
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 15),
                        height: MediaQuery.of(context).size.height / 4.6,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(23),
                            color: Colors.blue.shade50.withOpacity(.5)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text('Amount :'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(width: 17),
                                  Text(model.amount.toStringAsFixed(4),
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Transaction Date :'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(width: 17),
                                  Text(model.transactiondate,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Remark'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(width: 17),
                                  Text(': ${model.remark.tr}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Gas fee :'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(width: 17),
                                  Text('${model.gasfee}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
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
                              //         color: Colors.black)),],),
                              Row(
                                children: [
                                  Text('Status :'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(width: 17),
                                  Text(model.status.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('TXT hash :'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(width: 17),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(model.txthash,
                                        maxLines: 2,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                      onTap: () {
                                        Clipboard.setData(
                                            ClipboardData(text: model.txthash));
                                      },
                                      child: Icon(
                                        Icons.copy,
                                        color: Theme.of(context).primaryColor,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ]));
                  },
                  itemCount: controller.referralClaimlistModelResponse.length,
                ),
        ));
  }
}

class InviteClaimDetails extends StatelessWidget {
  InviteClaimDetails({Key? key}) : super(key: key);

  InviteController controller = Get.put(InviteController());
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
          'Referral Claim'.tr,
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
                            '${controller.directincome.value?.claimamount.toStringAsFixed(2)}',
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
                      Text('Referral Income',
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
                          '${controller.directincome.value!.claimamount - sendController.commissionAmount.value}',
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
          height: 50,
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
          controller.claimdirectreward();
        },
      ),
    );
  }
}
