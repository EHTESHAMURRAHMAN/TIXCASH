import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'add_coin_controller.dart';

class AddNetworkView extends GetView<AddCoinController> {
  const AddNetworkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Network'),
        foregroundColor: Colors.black,
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() => ListView.builder(
              itemBuilder: (context, index) {
                String network =
                    controller.networkList.elementAt(index).network;
                return ListTile(
                  title: Text(
                    network,
                    style: const TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Get.back(result: {'network': network});
                  },
                );
              },
              itemCount: controller.networkList.length,
            )),
      ),
    );
  }
}
