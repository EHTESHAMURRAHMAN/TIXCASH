import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutReferral extends GetView {
  const AboutReferral({Key? key}) : super(key: key);

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
          'About Referral'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            Text('What is 1st Gen Referral Income?'.tr,
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            const SizedBox(height: 10),
            Text(
                '1st gen referral income\" typically refers to the income or earnings that are directly generated from your direct referred user or downline members in a chain. These users are often referred to as your \"1st gen\" or \"first-level\" referrals. Your 1st gen income is the commission or bonus, you receive from the direct referrals you personally bring into the staking program.'
                    .tr,
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 30),
            Text('What is 2nd Gen Referral Income?'.tr,
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            const SizedBox(height: 10),
            Text(
                '2nd gen referral income typically refers to earnings or income generated from referrals made by individuals who were directly referred by you. In the context of referral or affiliate programs, when you refer someone (1st gen), and they, in turn, refer others (2nd gen), the income you receive from the activities of those 2nd Gen referrals can be considered your 2nd gen referral income.'
                    .tr,
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 30),
            Text('Referral Income'.tr,
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Staking Period'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                Text('1460 Days'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1st Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('20%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('2nd Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('20%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Staking Period'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                Text('730 Days'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1st Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('10%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('2nd Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('10%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Staking Period'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                Text('365 Days'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1st Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('5%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('2nd Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('5%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Staking Period'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                Text('90 Days'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1st Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('1.25%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('2nd Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('1.25%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Note :'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                Text(
                    'All above have Min 500 TXH to max.\n50000 TXH stake amount limitations.'
                        .tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 20),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Whitelisted stake : '.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                Text('(only available for a Whitelisted\n users)'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Staking Period'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                Text('Whitelisted (365)'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1st Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('20%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('2nd Gen Referral Income'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('20%',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Note :'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                Text('No stake amount limitations'.tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
