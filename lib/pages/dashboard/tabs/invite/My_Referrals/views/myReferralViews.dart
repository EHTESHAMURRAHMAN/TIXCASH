import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/models/LevelitemModel.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/My_Referrals/controllers/myReferral_controller.dart';

class MyReferral extends GetView<MyReferralController> {
  const MyReferral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              )),
          title: Text('My Referral'.tr,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          centerTitle: true,
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

  static final List<Tab> _tabs = [
    Tab(
        child: Text('1st Gen Referral'.tr,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
    //Tab(text: 'Address proof'),
    Tab(
        child: Text('2nd Gen Referral'.tr,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
  ];

  static List<Widget> _views = [
    firstGen(),
    secondGen(),
  ];
}

class firstGen extends StatelessWidget {
  firstGen({super.key});

  final MyReferralController controller = Get.put(MyReferralController());

  @override
  Widget build(BuildContext context) {
    controller.levelTeam.value = 1;
    controller.getlevelItemList(controller.levelTeam.value);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => ListView.builder(
            //shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              LevelitemModel model =
                  controller.levelitemModelResponse.elementAt(index);
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                // height: 60,
                // width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //     color: Theme.of(context).primaryColor,
                //     borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: ListTile(
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      model.invitationcode.tr,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
            itemCount: controller.levelitemModelResponse.length,
          ),
        ));
  }
}

class secondGen extends StatelessWidget {
  secondGen({super.key});

  final MyReferralController controller = Get.put(MyReferralController());

  @override
  Widget build(BuildContext context) {
    controller.levelTeam.value = 2;
    controller.getlevelItemList(controller.levelTeam.value);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => ListView.builder(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              LevelitemModel model =
                  controller.levelitemModelResponse.elementAt(index);
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                child: Center(
                  child: ListTile(
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      model.invitationcode.tr,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
            itemCount: controller.levelitemModelResponse.length,
          ),
        ));
  }
}
