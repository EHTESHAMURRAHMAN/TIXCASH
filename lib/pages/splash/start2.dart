import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tixcash/pages/splash/start3.dart';

class Startview2 extends StatelessWidget {
  const Startview2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/startp2.png',
                  height: MediaQuery.of(context).size.height / 2,
                ),
                Text(
                  'Allow us to track your data and\nhelp provide a better\nTIXCASH WALLET experience'
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                ),
                const SizedBox(height: 15),
                Text(
                  'We would like to collect data from your session to\nhelp make TIXCASH WALLET easier and\nmore fun to use'
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 15),
                Text(
                  'These data includes usage behavior such as clicking\nand scrolling as well as performance diagnostics.\nthey\'re totally anonymous and\nwill never be shared with anyone else'
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30.0),
          child: InkWell(
            onTap: () => Get.to(const Startview3()),
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xff1680ee)),
              child: Center(
                child: Text(
                  'Next'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ));
  }
}
