import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import '../controllers/auth_fingerprint_controller.dart';

class AuthFingerprintView extends GetView<AuthFingerprintController> {
  const AuthFingerprintView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, size: 18)),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(height: 44,),
                  Text(
                    controller.saveItMessage,
                    style: GoogleFonts.roboto(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.hide_source,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          controller.warningMsg.tr,
                          style: GoogleFonts.roboto(
                              fontSize: 14, color: Colors.red),
                        ))
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Your private key'.tr,
                    style: GoogleFonts.roboto(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          toolbarHeight: 0,
                          automaticallyImplyLeading: false,
                          // title: Text('Flutter Tabs Demo'),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          bottom: TabBar(
                            indicator: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            unselectedLabelColor:
                                Theme.of(context).primaryColor,
                            labelColor: Colors.white,
                            dividerColor: Colors.black,
                            tabs: const [
                              Tab(icon: Icon(Icons.key_outlined)),
                              Tab(icon: Icon(Icons.qr_code))
                            ],
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() => Text(
                                          controller.isShowBalance.value
                                              ? '••••••'
                                              : controller.privateKey.value,
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        )),
                                    const SizedBox(height: 10),
                                    InkWell(
                                      child: Icon(
                                        controller.isShowBalance.value
                                            ? CupertinoIcons.eye_slash
                                            : CupertinoIcons.eye_fill,
                                        color: controller.isShowBalance.value
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      onTap: () {
                                        controller.isShowBalance.value =
                                            !controller.isShowBalance.value;
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text: controller
                                                    .privateKey.value));
                                            EasyLoading.showToast(
                                                'Address Copied'.tr);
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 24),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              child: Center(
                                                  child: Text(
                                                'Copy'.tr,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Share.share(
                                                controller.privateKey.value);
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 24),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              child: Center(
                                                  child: Text(
                                                'Share'.tr,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Screenshot(
                                    controller: controller.screenshotController,
                                    child: Center(
                                      child: Obx(() => QrImageView(
                                            backgroundColor: Colors.white,
                                            data: controller.privateKey.value,
                                            version: QrVersions.auto,
                                            size: 180,
                                          )),
                                    )),
                                const SizedBox(height: 15),
                                InkWell(
                                  onTap: () {
                                    shareQrCode();
                                  },
                                  child: const Center(
                                      child: Icon(Icons.share, size: 30)),
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 10),
                            //   child: Container(
                            //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(20),
                            //         border: Border.all(color: Theme.of(context).primaryColor)),
                            //     child: Center(
                            //       child: Obx(() => QrImageView(
                            //             data: controller.privateKey.value,
                            //             version: QrVersions.auto,
                            //             size: 200.0,
                            //           )),
                            //     ),
                            //   ),
                            // )
                            // SecondScreen(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Row(
                  //   children: [
                  //     const Spacer(),
                  //     Container(
                  //       color: Colors.white,
                  //       // width: 220,
                  //       child:
                  //     ),
                  //     const Spacer()
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: Center(
                              child: Text(
                            'Done'.tr,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: InkWell(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Container(
      //       height: 50,
      //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      //       decoration: BoxDecoration(
      //           color: Colors.grey.shade200,
      //           borderRadius: BorderRadius.circular(30),
      //           border: Border.all(color: Theme.of(context).primaryColor)),
      //       child: Center(
      //           child: Text(
      //         'DONE',
      //         style: TextStyle(color: Theme.of(context).primaryColor),
      //       )),
      //     ),
      //   ),
      // ),
    );
  }

  shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    controller.screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          await imagePath.writeAsBytes(image);

          Share.shareFiles([imagePath.path], text: 'This is PrivateKey\'s QR');
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../controllers/auth_fingerprint_controller.dart';

// class AuthFingerprintView extends GetView<AuthFingerprintController> {
//   const AuthFingerprintView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     controller.authFingerPrint();
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//       ),
//       backgroundColor: Theme.of(context).primaryColor,
//       body: Obx(() => IndexedStack(
//             index: controller.stackIndex.value,
//             children: [
//               Center(
//                 child: GestureDetector(
//                   onTap: () {
//                     controller.authFingerPrint();
//                   },
//                   onLongPress: () {
//                     controller.authFingerPrint();
//                   },
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         'Please place your finger\nto your phone',
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       Image.asset('assets/icons/finger_print.png',
//                           width: MediaQuery.of(context).size.width / 3,
//                             ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       ElevatedButton(
//                           style: ButtonStyle(
//                               padding: MaterialStateProperty.all(
//                                   const EdgeInsets.symmetric(horizontal: 60))),
//                           onPressed: () {},
//                           child: const Text('Authenticate'))
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     // SizedBox(height: 44,),
//                     Text(
//                       controller.saveItMessage,
//                       style: GoogleFonts.roboto(
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 32),
//                       decoration: BoxDecoration(
//                             
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Row(
//                         children: <Widget>[
//                           const Icon(
//                             Icons.hide_source,
//                             color: Colors.red,
//                             size: 48,
//                           ),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           Expanded(
//                               child: Text(
//                             controller.warningMsg,
//                             style: GoogleFonts.roboto(
//                                 fontSize: 14, color: Colors.red),
//                           ))
//                         ],
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 24,
//                     ),

//                     Text(
//                       'Your private key',
//                       style: GoogleFonts.roboto(
//                           fontSize: 14, fontWeight: FontWeight.bold),
//                     ),

//                     const SizedBox(
//                       height: 16,
//                     ),

//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 32),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(  )),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             controller.privateKey.value,
//                             style: GoogleFonts.roboto(
//                                   
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 24,
//                           ),
//                           MaterialButton(
//                             onPressed: () {
//                               Clipboard.setData(ClipboardData(
//                                   text: controller.privateKey.value));
//                               EasyLoading.showToast('Address Copied');
//                             },
//                             child: Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 16, horizontal: 24),
//                               child: const Center(
//                                   child: Text('Copy to Clipboard')),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30),
//                                   border: Border.all(  )),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),

//                     const Spacer(),

//                     MaterialButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16, horizontal: 24),
//                         decoration: BoxDecoration(
//                               
//                             borderRadius: BorderRadius.circular(30),
//                             border: Border.all(  )),
//                         child: Center(
//                             child: Text(
//                           'DONE',
//                           style:
//                               TextStyle(color: Theme.of(context).primaryColor),
//                         )),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
