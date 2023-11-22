import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:tixcash/pages/dashboard/home_navigation/home_navigation_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/shared/constants/colors.dart';

import 'contact_support_controller.dart';

class ContactSupportView extends GetView<ContactSupportController> {
  const ContactSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());
    Get.isRegistered<HomeNavigationController>()
        ? Get.find<HomeNavigationController>()
        : Get.put(HomeNavigationController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact and Support'.tr),
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Contact and Support'.tr,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  )),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.mail,
                    size: 24,
                  ),
                  label: const Text(
                    'reliwellpvtltd@gmail.com',
                    style: TextStyle(fontSize: 16),
                  )),

              // TextButton.icon(onPressed: (){
              //   launch('tel: +996 700 000 000');
              // }, icon: const Icon(Ionicons.phone_portrait, size: 24,),
              //     label: const Text('+996 700 000 000', style: TextStyle(fontSize: 16),)),
              //
              // TextButton.icon(onPressed: (){
              //   launch('tel: +996 700 000 000');
              // }, icon: const Icon(Ionicons.ios_logo_whatsapp, size: 24,),
              //     label: const Text('+996700000000', style: TextStyle(fontSize: 16),)),

              const SizedBox(
                height: 24,
              ),

              // Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
