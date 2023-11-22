import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tixcash/shared/constants/colors.dart';
import 'package:qr_code_utils/qr_code_utils.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  File? image;
  String data = '';
  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp);
  //     decode(image.path);
  //     print('image path   ${image.path}');
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // /// decode from local file
  // Future decode(String path) async {
  //   print(image?.path);
  //   String? data = await QrCodeUtils.decodeFrom(image!.path);
  //   setState(() {
  //     data = data;
  //   });
  // }
  String decoded = 'Unknown';
  Future<void> initPlatformState() async {
    var imagePicker = ImagePicker();

    XFile? xfile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xfile != null) {
      String? decoded;
      // Platform messages may fail, so we use a try/catch PlatformException.
      // We also handle the message potentially returning null.
      try {
        decoded = await QrCodeUtils.decodeFrom(xfile.path) ??
            'Unknown platform version';
        if (decoded != null) {
          decoded = decoded;
          print('hahahah   $decoded');
          Get.back(result: decoded);
        }
      } on PlatformException {
        decoded = 'Failed to get decoded.';
      }
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    cameraController.barcodes.listen((event) {
      print('Event => $event');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scanner'),
        foregroundColor: Colors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        actions: [
          const SizedBox(width: 15),
          InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 19,
              )),
          const Spacer(),
          const Center(
              child: Text(
            'Scanner',
            style: TextStyle(fontSize: 17),
          )),
          const Spacer(),
        ],
      ),
      backgroundColor: Colors.blue.shade50,
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Image.asset('assets/icons/logo.png',
                height: MediaQuery.of(context).size.height / 12),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3),
                  borderRadius: BorderRadius.circular(23)),
              height: MediaQuery.of(context).size.height / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MobileScanner(
                    allowDuplicates: false,
                    controller: cameraController,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        final String code = barcode.rawValue!;

                        debugPrint('Barcode found! ${barcode.rawValue}');
                        Get.back(result: code);
                      }
                    }),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: ColorConstants.secondaryDarkAppColor),
                height: 45,
                width: MediaQuery.of(context).size.width / 1.8,
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Import From Gallery'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.image, color: Colors.white)
                  ],
                ),
              ),
              onTap: () async {
                initPlatformState();
              },
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// //import 'package:get/get.dart';
// //import 'package:mobile_scanner/mobile_scanner.dart';

// class ScanQR extends StatefulWidget {
//   const ScanQR({Key? key}) : super(key: key);

//   @override
//   State<ScanQR> createState() => _ScanQRState();
// }

// class _ScanQRState extends State<ScanQR> {
//   //MobileScannerController cameraController = MobileScannerController();

//   @override
//   void initState() {
//     super.initState();
//     // cameraController.barcodes.listen((event) {
//     //   print('Event => $event');
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Scanner'),
//         foregroundColor: Colors.black,
//         leading: InkWell(
//             onTap: () => Get.back(),
//             child: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             )),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarIconBrightness: Brightness.dark,
//           statusBarBrightness: Brightness.dark,
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(),
//     );

//     /* return Scaffold(
//         appBar: AppBar(
//           title: const Text('LineChain Scanner'),
//           actions: [
//             IconButton(
//               color: Colors.white,
//               icon: ValueListenableBuilder(
//                 valueListenable: cameraController.torchState,
//                 builder: (context, state, child) {
//                   switch (state as TorchState) {
//                     case TorchState.off:
//                       return const Icon(Icons.flash_off, color: Colors.grey);
//                     case TorchState.on:
//                       return const Icon(Icons.flash_on, color: Colors.yellow);
//                   }
//                 },
//               ),
//               iconSize: 32.0,
//               onPressed: () => cameraController.toggleTorch(),
//             ),
//             IconButton(
//               color: Colors.white,
//               icon: ValueListenableBuilder(
//                 valueListenable: cameraController.cameraFacingState,
//                 builder: (context, state, child) {
//                   switch (state as CameraFacing) {
//                     case CameraFacing.front:
//                       return const Icon(Icons.camera_front);
//                     case CameraFacing.back:
//                       return const Icon(Icons.camera_rear);
//                   }
//                 },
//               ),
//               iconSize: 32.0,
//               onPressed: () => cameraController.switchCamera(),
//             ),
//           ],
//         ),
//         body: MobileScanner(
//             //allowDuplicates: false,
//             controller: cameraController,

//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               final Uint8List? image = capture.image;
//               for (final barcode in barcodes) {
//                 debugPrint('Barcode found! ${barcode.rawValue}');
//               }
//             },

//             // onDetect: (barcode, args) {
//             //   if (barcode.rawValue == null) {
//             //     debugPrint('Failed to scan Barcode');
//             //   } else {
//             //     final String code = barcode.rawValue!;
//             //     debugPrint('Barcode found! $code');
//             //     Get.back(result: code);
//             //   }
//             // }

//             ));*/
//   }
// }
