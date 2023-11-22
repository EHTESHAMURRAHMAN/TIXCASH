import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/pages/dashboard/home_navigation/home_navigation_view.dart';
import 'package:tixcash/pages/dashboard/scan_qr/scan_qr_child_view.dart';
import 'scan_qr_controller.dart';

class ScanQrView extends GetView<ScanQrController> {
  const ScanQrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const HomeNavigationView(
        child: ScanQRChild(
      hasActionBar: false,
    ));
  }
}
