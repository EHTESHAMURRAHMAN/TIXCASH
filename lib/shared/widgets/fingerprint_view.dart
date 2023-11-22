import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tixcash/app_controller.dart';

class FingerPrintUI extends StatefulWidget {
  const FingerPrintUI({Key? key}) : super(key: key);

  @override
  State<FingerPrintUI> createState() => _FingerPrintUIState();
}

class _FingerPrintUIState extends State<FingerPrintUI> {
  final appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();

    authFingerPrint();
  }

  authFingerPrint() {
    appController.checkFingerPrint((auth) {
      if (auth) {
        // onConfirm();
      } else {
        EasyLoading.showToast('Not authorized'.tr);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: IndexedStack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                authFingerPrint();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Please place your finger\nto your phone',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset('assets/icons/finger_print.png',
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.white),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 60))),
                      onPressed: () {},
                      child: const Text('Authenticate'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
