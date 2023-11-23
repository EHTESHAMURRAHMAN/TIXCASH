import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/My_Referrals/controllers/myReferral_controller.dart';

class MyReferral extends GetView<MyReferralController> {
  const MyReferral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              )),
          title: Text('My Referral'.tr,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0,
          bottom: TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              indicator: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              unselectedLabelColor: Theme.of(context).primaryColor,
              labelColor: Colors.white,
              dividerColor: Colors.black,
              tabs: _tabs),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          children: _views,
        ),
      ),
    );
  }

  static const List<Tab> _tabs = [
    Tab(
        child: Text('1st Gen Referral',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
    //Tab(text: 'Address proof'),
    Tab(
        child: Text('2nd Gen Referral',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
  ];

  static List<Widget> _views = [
    firstGen(),
    secondGen(),
  ];
}

class firstGen extends StatelessWidget {
  const firstGen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
          child: Text('Launching Soon',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold))),
    );
  }
}

class secondGen extends StatelessWidget {
  const secondGen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
          child: Text('Launching Soon',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold))),
    );
  }
}
