import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/app_controller.dart';

class DashboardController extends GetxController {
  final appController = Get.find<AppController>();
  int counter = 0;
  final bottomAppIndex = 0.obs;
  final pageController = PageController();
  @override
  void onInit() {
    super.onInit();
    bottomAppIndex.listen((page) {
      pageController.jumpToPage(page);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}


// class DashboardController extends GetxController {

//   // Get.isRegistered<HomeController>() ? Get.find<HomeController>() : Get.put(HomeController())

//   final homeController = Get.isRegistered<HomeController>()?Get.find<HomeController>():Get.put(HomeController());
//   // final sendTyvController = Get.find<SendTyvController>();
//   final swapController = Get.isRegistered<SwapController>()?Get.find<SwapController>():Get.put(SwapController());
//   final count = 0.obs;
//   RxnInt bottomIndex = RxnInt(0);

//   final PageController pageController = PageController();

//   @override
//   void onInit() {
//     super.onInit();
//     homeController.getBalanceCurrencyList();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     // updateBottomIndex(0);
//   }

//   @override
//   void onClose() {}
//   void increment() => count.value++;

//   void updateBottomIndex(int index){
//     bottomIndex.value = index;
//     homeController.getBalanceCurrencyList();

//     if(index == 0){
//       homeController.initValues();
//     }

//     if(index==3){
//       swapController.getCurrencyPairPrice();
//     }
//     if (kDebugMode) {
//       print('current => $index');
//     }
//     if(index==2){
//       var mController = Get.find<SendTyvController>();
//       mController.currencyResponse.value = null;
//     }
//   }

//   void updateIndex(int index){
//     pageController.jumpToPage(index);
//     updateBottomIndex(index);
//   }
// }
