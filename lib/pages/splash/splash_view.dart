import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tixcash/shared/shared.dart';

import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // if(!isDark&&Platform.isAndroid){
    //   SystemChrome.setEnabledSystemUIOverlays([]);
    // }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff1680ee),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
      // backgroundColor: ColorConstants.primaryAppColor,
      backgroundColor: const Color(0xff1680ee),
      body: Center(
          child: Obx(
        () => AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          onEnd: () {
            controller.launchApp(context);
          },
          opacity: controller.delay.value,
          // child: Image.asset('assets/images/tyvlogo.png',),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Image.asset(
                  'assets/icons/logo.png',
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
