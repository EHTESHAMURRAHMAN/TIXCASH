import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/pages/dashboard/home_navigation/home_navigation_view.dart';
import 'add_store_controller.dart';

class AddStoreView extends GetView<AddStoreController> {
  const AddStoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeNavigationView(child: Container());
  }
}
