import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tabs/liquidity/add_liquidity_view.dart';

import 'liquidity_controller.dart';

class LiquidityView extends GetView<LiquidityController> {
  const LiquidityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liquidity')),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: IndexedStack(
          index: controller.pageIndex.value,
          children: [
            _liquidityList(context),
          ],
        ),
      ),
    );
  }

  _liquidityList(context) => Container(
        // color: Colors.grey[800],

        child: Column(
          children: [
            Container(
              color: Colors.grey[800],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Liquidity',
                          style: GoogleFonts.roboto(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Text('Remove liquidity to receive token back',
                          style: GoogleFonts.roboto(
                              fontSize: 13, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Expanded(
                      child: Text('12345.000000',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.roboto(
                              fontSize: 18, fontWeight: FontWeight.w700)))
                ],
              ),
            ),
            Expanded(
                child: controller.liquidityList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No Liquidity Found',
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 24,
                          ),
                          Text('Don\'t see a pool you joined?',
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 24,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text('Find other LP Token',
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2)),
                              ))
                        ],
                      )
                    : ListView()),
            Container(
              color: Colors.grey[800],
              child: GestureDetector(
                  onTap: () => Get.to(const AddLiquidityView()),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    alignment: Alignment.center,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text('Add Liquidity',
                            style: GoogleFonts.roboto(
                                fontSize: 18, fontWeight: FontWeight.w500))
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                  )),
            )
          ],
        ),
      );
}
