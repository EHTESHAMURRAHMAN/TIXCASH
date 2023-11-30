import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/account/create_wallet/create_wallet_controller.dart';
import 'package:tixcash/shared/shared.dart';
import 'backup_words_controller.dart';
import 'package:collection/collection.dart';

class BackupWordsView extends GetView<BackupWordsController> {
  const BackupWordsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 12;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, size: 20)),

        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: Text(
          'Backup Wallet'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(() => IndexedStack(
                index: controller.viewIndex.value,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(controller.recoveryMessage,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(
                          height: 24,
                        ),
                        Obx(() => GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: (itemWidth / itemHeight),
                              children: controller.phraseList
                                  .mapIndexed((index, element) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}. $element',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )),
                        const SizedBox(height: 15),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Remember :'.tr,
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '● Don\'t disclose secret recovery phrase to anyone Once the secret recovery phrase is lost, assets cannot be recovered'
                                        .tr,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  ),
                                  Text(
                                    '● Please do not backup and save by screenshots or network transmission'
                                        .tr,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  ),
                                  Text(
                                    '● Don\'t uninstall the app when in issues, note the recovery phrase first or contact us for help'
                                        .tr,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          onPressed: () {
                            controller.createBackup();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(9)),
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(
                                'VERIFY NOW'.tr,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //_verifyPassPhrase(context)
                ],
              )),
        ),
      ),
      // body: PhraseContainer(phrase: controller.list_1_4, title: controller.list_labels.elementAt(0), content: controller.recoveryMessage, countIndex: 0,),
      /*
      body: Column(children: [
        Expanded(child: PageView(
          controller: controller.pageController,
          onPageChanged: (page){
            controller.currentPage.value = page;
            int rad = Random().nextInt(12);
            controller.randomNumber.value = rad;
            controller.randomWord.value = controller.phraseList.elementAt(rad);
          },
          children: [

            PhraseContainer(phrase: controller.list_1_4, title: controller.list_labels.elementAt(0), content: controller.recoveryMessage, countIndex: 0,),
            PhraseContainer(phrase: controller.list_5_8, title: controller.list_labels.elementAt(1), countIndex: 4,),
            PhraseContainer(phrase: controller.list_9_12, title: controller.list_labels.elementAt(2), countIndex: 8,),
            _verifyPassPhrase()
          ],)),
        GestureDetector(
          child: Container(
            height: 50,
            padding: const EdgeInsets.all(8),
            color: ColorConstants.secondaryDarkAppColor,
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Obx(() => Text(controller.list_labels.elementAt(controller.currentPage.value).tr, style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 18
                ),),),
                const SizedBox(width: 8,),
                const Icon(Icons.arrow_forward, size: 24,),
                const SizedBox(height: 16,),
              ],
            ),
          ),
          onTap:(){
            if(controller.currentPage.value==3){
              controller.createBackup();
              // }
            }else {
              controller.pageController.animateToPage(controller.currentPage.value+1, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
            }
          },
        )
      ],),
          */
    );
  }

  // Widget _verifyPassPhrase(context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const SizedBox(
  //           height: 16,
  //         ),
  //         Text(
  //           controller.veryfyPhrase.tr,
  //           style: TextStyle(
  //               fontSize: CommonConstants.normalText,
  //               color: ColorConstants.black),
  //         ),
  //         const SizedBox(
  //           height: 16,
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Verify word'.tr,
  //               style: TextStyle(
  //                   fontSize: CommonConstants.normalText,
  //                   color: ColorConstants.black),
  //             ),
  //             Obx(
  //               () => Text(
  //                 '#${controller.randomNumber.value + 1}\t ${controller.searchWord.value}',
  //                 style: TextStyle(
  //                     fontSize: CommonConstants.normalText,
  //                     color: ColorConstants.black),
  //               ),
  //             ),
  //           ],
  //         ),
  //         // Obx(
  //         //   () => Text(
  //         //     'Verify word'
  //         //         .trParams({'name': '${controller.randomNumber.value + 1}', 'value': controller.searchWord.value}),
  //         //     style: TextStyle(fontSize: CommonConstants.normalText, color: ColorConstants.black),
  //         //   ),
  //         // ),
  //         TextFormField(
  //           onChanged: (val) {
  //             controller.searchWords(val);
  //             controller.isActive.value =
  //                 controller.controllerRandom.text.isNotEmpty;
  //           },
  //           controller: controller.controllerRandom,
  //           style: TextStyle(color: ColorConstants.black),
  //           decoration: const InputDecoration(border: InputBorder.none),
  //         ),
  //         Container(
  //           height: 2,
  //           color: ColorConstants.secondaryDarkAppColor,
  //         ),
  //         const SizedBox(
  //           height: 8,
  //         ),
  //         SizedBox(
  //           height: 40,
  //           child: Obx(() => ListView(
  //                 scrollDirection: Axis.horizontal,
  //                 children: controller.searchList.map((element) {
  //                   return SelectContainer(
  //                       title: element,
  //                       onSelect: () {
  //                         controller.searchWord.value = element;
  //                         controller.controllerRandom.text = element;
  //                         controller.searchList.clear();
  //                       });
  //                 }).toList(),
  //               )),
  //         ),
  //         Obx(() => Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: SaveButton(
  //                 title: 'VERIFY NOW'.tr,
  //                 onPress: () {
  //                   controller.createBackup();
  //                 },
  //                 isActive: controller.isActive.value)))
  //       ],
  //     ),
  //   );
  // }
}

class PhraseContainer extends StatelessWidget {
  final List<String> phrase;
  final String title;
  final String? content;
  final int countIndex;

  const PhraseContainer(
      {Key? key,
      required this.phrase,
      required this.title,
      this.content,
      required this.countIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.warning,
                size: SizeConfig().screenWidth * 0.2,
                color: Colors.red,
              ),
            ),
            content != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      content!,
                      style: TextStyle(
                          fontSize: CommonConstants.smallText,
                          color: ColorConstants.black),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 8,
            ),
            Text(
              title.tr,
              style: TextStyle(
                  fontSize: CommonConstants.normalText,
                  color: ColorConstants.black),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: phrase.mapIndexed((index, element) {
                    return ListTile(
                      leading: Text('${countIndex + index + 1}.',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: CommonConstants.normalText)),
                      title: Text(
                        element,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }).toList(),
                ))
          ],
        ),
      ),
    );
  }
}

// import 'dart:math';
// import 'dart:ui';
//
// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tixcash/shared/shared.dart';
//
// import 'backup_words_controller.dart';
//
// class BackupWordsView extends GetView<BackupWordsController> {
//   const BackupWordsView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Backup Wallet'.tr,
//           style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
//         ),
//         elevation: 0,
//       ),
//       backgroundColor: ColorConstants.white,
//       body: Column(
//         children: [
//           Expanded(
//               child: ListView(
//             controller: controller.pageController,
//
//             children: [
//               PhraseContainer(
//                 phrase: controller.list_1_4,
//                 title: controller.list_labels.elementAt(0),
//                 content: controller.recoveryMessage,
//                 countIndex: 0,
//               ),
//               PhraseContainer(
//                 phrase: controller.list_5_8,
//                 title: controller.list_labels.elementAt(1),
//                 countIndex: 4,
//               ),
//               PhraseContainer(
//                 phrase: controller.list_9_12,
//                 title: controller.list_labels.elementAt(2),
//                 countIndex: 8,
//               ),
//               _verifyPassPhrase()
//             ],
//           )),
//           GestureDetector(
//             child: Container(
//               height: 50,
//               padding: const EdgeInsets.all(8),
//               color: ColorConstants.secondaryDarkAppColor,
//               child: Row(
//                 children: [
//                   Expanded(child: SizedBox()),
//                   Obx(
//                     () => Text(
//                       controller.list_labels
//                           .elementAt(controller.currentPage.value)
//                           .tr,
//                       style: GoogleFonts.roboto(
//                           fontWeight: FontWeight.w500, fontSize: 18),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   const Icon(
//                     Icons.arrow_forward,
//                     size: 24,
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                 ],
//               ),
//             ),
//             onTap: () {
//               if (controller.currentPage.value == 0) {
//                 controller.createBackup();
//                 // }
//               }
//               // else {
//               //   controller.pageController.animateToPage(
//               //       controller.currentPage.value + 1,
//               //       duration: const Duration(milliseconds: 200),
//               //       curve: Curves.easeIn);
//               // }
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _verifyPassPhrase() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 16,
//           ),
//           Text(
//             controller.veryfyPhrase.tr,
//             style: TextStyle(
//                 fontSize: CommonConstants.normalText,
//                 color: ColorConstants.black),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//
//           // Obx(() =>Text('Verify word #${controller.randomNumber.value+1}\t ${controller.searchWord.value}', style: TextStyle(fontSize: CommonConstants.normalText, color: ColorConstants.black),),),
//           Obx(
//             () => Text(
//               'Verify word'.trParams({
//                 'name': '${controller.randomNumber.value + 1}',
//                 'value': controller.searchWord.value
//               }),
//               style: TextStyle(
//                   fontSize: CommonConstants.normalText,
//                   color: ColorConstants.black),
//             ),
//           ),
//           TextFormField(
//             onChanged: (val) {
//               controller.searchWords(val);
//             },
//             controller: controller.controllerRandom,
//             style: TextStyle(color: ColorConstants.black),
//             decoration: const InputDecoration(border: InputBorder.none),
//           ),
//           Container(
//             height: 2,
//             color: ColorConstants.secondaryDarkAppColor,
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           SizedBox(
//             height: 40,
//             child: Obx(() => ListView(
//                   children: controller.searchList.map((element) {
//                     return SelectContainer(
//                         title: element,
//                         onSelect: () {
//                           controller.searchWord.value = element;
//                           controller.controllerRandom.text = element;
//                           controller.searchList.clear();
//                         });
//                   }).toList(),
//                   scrollDirection: Axis.horizontal,
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class PhraseContainer extends StatelessWidget {
//   final List<String> phrase;
//   final String title;
//   final String? content;
//   final int countIndex;
//
//   const PhraseContainer(
//       {Key? key,
//       required this.phrase,
//       required this.title,
//       this.content,
//       required this.countIndex})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Align(
//             //   alignment: Alignment.center,
//             //   child: Icon(
//             //     Icons.warning,
//             //     size: SizeConfig().screenWidth * 0.2,
//             //     color: Colors.red,
//             //   ),
//             // ),
//             content != null
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Text(
//                       content!,
//                       style: TextStyle(
//                           fontSize: CommonConstants.smallText,
//                           color: ColorConstants.black),
//                     ),
//                   )
//                 : const SizedBox(),
//             const SizedBox(
//               height: 8,
//             ),
//             Text(
//               title.tr,
//               style: TextStyle(
//                   fontSize: CommonConstants.normalText,
//                   color: ColorConstants.black),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Obx(() => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: phrase.mapIndexed((index, element) {
//                     return ListTile(
//                       leading: Text('${countIndex + index + 1}.',
//                           style: const TextStyle(
//                               color: Colors.red,
//                               fontSize: CommonConstants.normalText)),
//                       title: Text(
//                         element,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     );
//                   }).toList(),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tixcash/shared/shared.dart';
// import 'backup_words_controller.dart';
// import 'package:collection/collection.dart';

// class BackupWordsView extends GetView<BackupWordsController> {
//   const BackupWordsView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     /*24 is for notification bar on Android*/
//     final double itemHeight = (size.height - kToolbarHeight - 24) / 12;
//     final double itemWidth = size.width / 2;

//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//             onTap: () => Get.back(),
//             child: const Icon(
//               Icons.arrow_back_ios,
//
//               size: 20,
//             )),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         // backgroundColor: Colors.transparent,
//         title: Text(
//           'Backup Wallet'.tr,
//           style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
//         ),
//       ),
//       backgroundColor: ColorConstants.white,
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           child: Obx(() => IndexedStack(
//                 index: controller.viewIndex.value,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       children: [
//                         Text(controller.recoveryMessage, style: const TextStyle(   fontSize: 16)),
//                         const SizedBox(
//                           height: 24,
//                         ),
//                         Obx(() => GridView.count(
//                               shrinkWrap: true,
//                               crossAxisCount: 3,
//                               mainAxisSpacing: 5,
//                               crossAxisSpacing: 5,
//                               childAspectRatio: (itemWidth / itemHeight),
//                               children: controller.phraseList.mapIndexed((index, element) {
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                       color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(9)),
//                                   child: Center(
//                                     child: Text(
//                                       '${index + 1}. $element',
//                                       style: const TextStyle(color: Colors.white, fontSize: 13),
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             )),
//                         const SizedBox(height: 15),
//                         Text(
//                           'Please Note Down Secret Recovery Pharse'.tr,
//                           style: TextStyle(   fontSize: 15),
//                         ),
//                         const SizedBox(height: 25),
//                         Container(
//                             padding: const EdgeInsets.all(10),
//                             height: MediaQuery.of(context).size.height / 4.3,
//                             width: MediaQuery.of(context).size.width,
//                             decoration:
//                                 BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(9)),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Remember :'.tr,
//                                   style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   '● Don\'t disclose secret recovery phrase to anyone Once the secret recovery phrase is lost, assets cannot be recovered'
//                                       .tr,
//                                   style: TextStyle(color: Colors.red, fontSize: 13),
//                                 ),
//                                 Text(
//                                   '● Please do not backup and save by screenshots or network transmission'.tr,
//                                   style: TextStyle(color: Colors.red, fontSize: 13),
//                                 ),
//                                 Text(
//                                   '● Don\'t uninstall the app when in issues, note the recovery phrase first or contact us for help'
//                                       .tr,
//                                   style: TextStyle(color: Colors.red, fontSize: 13),
//                                 ),
//                               ],
//                             )),
//                         const SizedBox(height: 20),
//                         MaterialButton(
//                           onPressed: () {
//                             controller.viewIndex.value = 1;
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(9)),
//                             width: double.infinity,
//                             height: 50,
//                             child: Center(
//                               child: Text(
//                                 'VERIFY NOW'.tr,
//                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   _verifyPassPhrase(context)
//                 ],
//               )),
//         ),
//       ),
//       // body: PhraseContainer(phrase: controller.list_1_4, title: controller.list_labels.elementAt(0), content: controller.recoveryMessage, countIndex: 0,),
//       /*
//       body: Column(children: [
//         Expanded(child: PageView(
//           controller: controller.pageController,
//           onPageChanged: (page){
//             controller.currentPage.value = page;
//             int rad = Random().nextInt(12);
//             controller.randomNumber.value = rad;
//             controller.randomWord.value = controller.phraseList.elementAt(rad);
//           },
//           children: [

//             PhraseContainer(phrase: controller.list_1_4, title: controller.list_labels.elementAt(0), content: controller.recoveryMessage, countIndex: 0,),
//             PhraseContainer(phrase: controller.list_5_8, title: controller.list_labels.elementAt(1), countIndex: 4,),
//             PhraseContainer(phrase: controller.list_9_12, title: controller.list_labels.elementAt(2), countIndex: 8,),
//             _verifyPassPhrase()
//           ],)),
//         GestureDetector(
//           child: Container(
//             height: 50,
//             padding: const EdgeInsets.all(8),
//             color: ColorConstants.secondaryDarkAppColor,
//             child: Row(
//               children: [
//                 Expanded(child: SizedBox()),
//                 Obx(() => Text(controller.list_labels.elementAt(controller.currentPage.value).tr, style: GoogleFonts.roboto(
//                     fontWeight: FontWeight.w500, fontSize: 18
//                 ),),),
//                 const SizedBox(width: 8,),
//                 const Icon(Icons.arrow_forward, size: 24,),
//                 const SizedBox(height: 16,),
//               ],
//             ),
//           ),
//           onTap:(){
//             if(controller.currentPage.value==3){
//               controller.createBackup();
//               // }
//             }else {
//               controller.pageController.animateToPage(controller.currentPage.value+1, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
//             }
//           },
//         )
//       ],),
//           */
//     );
//   }

//   Widget _verifyPassPhrase(context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 16,
//           ),
//           Text(
//             controller.veryfyPhrase.tr,
//             style: TextStyle(fontSize: CommonConstants.normalText, color: ColorConstants.black),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           Row(
//             children: [
//               Text(
//                 'Verify word'.tr,
//                 style: TextStyle(fontSize: CommonConstants.normalText, color: ColorConstants.black),
//               ),
//               Obx(
//                 () => Text(
//                   '#${controller.randomNumber.value + 1}\t ${controller.searchWord.value}',
//                   style: TextStyle(fontSize: CommonConstants.normalText, color: ColorConstants.black),
//                 ),
//               ),
//             ],
//           ),
//           // Obx(
//           //   () => Text(
//           //     'Verify word'
//           //         .trParams({'name': '${controller.randomNumber.value + 1}', 'value': controller.searchWord.value}),
//           //     style: TextStyle(fontSize: CommonConstants.normalText, color: ColorConstants.black),
//           //   ),
//           // ),
//           TextFormField(
//             onChanged: (val) {
//               controller.searchWords(val);
//             },
//             controller: controller.controllerRandom,
//             style: TextStyle(color: ColorConstants.black),
//             decoration: const InputDecoration(border: InputBorder.none),
//           ),
//           Container(
//             height: 2,
//             color: ColorConstants.secondaryDarkAppColor,
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           SizedBox(
//             height: 40,
//             child: Obx(() => ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: controller.searchList.map((element) {
//                     return SelectContainer(
//                         title: element,
//                         onSelect: () {
//                           controller.searchWord.value = element;
//                           controller.controllerRandom.text = element;
//                           controller.searchList.clear();
//                         });
//                   }).toList(),
//                 )),
//           ),
//           MaterialButton(
//             onPressed: () {
//               controller.createBackup();
//             },
//             child: Container(
//               decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(9)),
//               width: double.infinity,
//               height: 50,
//               child: Center(
//                 child: Text(
//                   'VERIFY NOW'.tr,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class PhraseContainer extends StatelessWidget {
//   final List<String> phrase;
//   final String title;
//   final String? content;
//   final int countIndex;

//   const PhraseContainer({Key? key, required this.phrase, required this.title, this.content, required this.countIndex})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Icon(
//                 Icons.warning,
//                 size: SizeConfig().screenWidth * 0.2,
//                 color: Colors.red,
//               ),
//             ),
//             content != null
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Text(
//                       content!,
//                       style: TextStyle(fontSize: CommonConstants.smallText, color: ColorConstants.black),
//                     ),
//                   )
//                 : const SizedBox(),
//             const SizedBox(
//               height: 8,
//             ),
//             Text(
//               title.tr,
//               style: TextStyle(fontSize: CommonConstants.normalText, color: ColorConstants.black),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Obx(() => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: phrase.mapIndexed((index, element) {
//                     return ListTile(
//                       leading: Text('${countIndex + index + 1}.',
//                           style: const TextStyle(color: Colors.red, fontSize: CommonConstants.normalText)),
//                       title: Text(
//                         element,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     );
//                   }).toList(),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'dart:math';
// // import 'dart:ui';
// //
// // import 'package:collection/collection.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:tixcash/shared/shared.dart';
// //
// // import 'backup_words_controller.dart';
// //
// // class BackupWordsView extends GetView<BackupWordsController> {
// //   const BackupWordsView({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           'Backup Wallet'.tr,
// //           style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
// //         ),
// //         elevation: 0,
// //       ),
// //       backgroundColor: ColorConstants.white,
// //       body: Column(
// //         children: [
// //           Expanded(
// //               child: ListView(
// //             controller: controller.pageController,
// //
// //             children: [
// //               PhraseContainer(
// //                 phrase: controller.list_1_4,
// //                 title: controller.list_labels.elementAt(0),
// //                 content: controller.recoveryMessage,
// //                 countIndex: 0,
// //               ),
// //               PhraseContainer(
// //                 phrase: controller.list_5_8,
// //                 title: controller.list_labels.elementAt(1),
// //                 countIndex: 4,
// //               ),
// //               PhraseContainer(
// //                 phrase: controller.list_9_12,
// //                 title: controller.list_labels.elementAt(2),
// //                 countIndex: 8,
// //               ),
// //               _verifyPassPhrase()
// //             ],
// //           )),
// //           GestureDetector(
// //             child: Container(
// //               height: 50,
// //               padding: const EdgeInsets.all(8),
// //               color: ColorConstants.secondaryDarkAppColor,
// //               child: Row(
// //                 children: [
// //                   Expanded(child: SizedBox()),
// //                   Obx(
// //                     () => Text(
// //                       controller.list_labels
// //                           .elementAt(controller.currentPage.value)
// //                           .tr,
// //                       style: GoogleFonts.roboto(
// //                           fontWeight: FontWeight.w500, fontSize: 18),
// //                     ),
// //                   ),
// //                   const SizedBox(
// //                     width: 8,
// //                   ),
// //                   const Icon(
// //                     Icons.arrow_forward,
// //                     size: 24,
// //                   ),
// //                   const SizedBox(
// //                     height: 16,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             onTap: () {
// //               if (controller.currentPage.value == 0) {
// //                 controller.createBackup();
// //                 // }
// //               }
// //               // else {
// //               //   controller.pageController.animateToPage(
// //               //       controller.currentPage.value + 1,
// //               //       duration: const Duration(milliseconds: 200),
// //               //       curve: Curves.easeIn);
// //               // }
// //             },
// //           )
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _verifyPassPhrase() {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const SizedBox(
// //             height: 16,
// //           ),
// //           Text(
// //             controller.veryfyPhrase.tr,
// //             style: TextStyle(
// //                 fontSize: CommonConstants.normalText,
// //                 color: ColorConstants.black),
// //           ),
// //           const SizedBox(
// //             height: 16,
// //           ),
// //
// //           // Obx(() =>Text('Verify word #${controller.randomNumber.value+1}\t ${controller.searchWord.value}', style: TextStyle(fontSize: CommonConstants.normalText, color: ColorConstants.black),),),
// //           Obx(
// //             () => Text(
// //               'Verify word'.trParams({
// //                 'name': '${controller.randomNumber.value + 1}',
// //                 'value': controller.searchWord.value
// //               }),
// //               style: TextStyle(
// //                   fontSize: CommonConstants.normalText,
// //                   color: ColorConstants.black),
// //             ),
// //           ),
// //           TextFormField(
// //             onChanged: (val) {
// //               controller.searchWords(val);
// //             },
// //             controller: controller.controllerRandom,
// //             style: TextStyle(color: ColorConstants.black),
// //             decoration: const InputDecoration(border: InputBorder.none),
// //           ),
// //           Container(
// //             height: 2,
// //             color: ColorConstants.secondaryDarkAppColor,
// //           ),
// //           const SizedBox(
// //             height: 8,
// //           ),
// //           SizedBox(
// //             height: 40,
// //             child: Obx(() => ListView(
// //                   children: controller.searchList.map((element) {
// //                     return SelectContainer(
// //                         title: element,
// //                         onSelect: () {
// //                           controller.searchWord.value = element;
// //                           controller.controllerRandom.text = element;
// //                           controller.searchList.clear();
// //                         });
// //                   }).toList(),
// //                   scrollDirection: Axis.horizontal,
// //                 )),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class PhraseContainer extends StatelessWidget {
// //   final List<String> phrase;
// //   final String title;
// //   final String? content;
// //   final int countIndex;
// //
// //   const PhraseContainer(
// //       {Key? key,
// //       required this.phrase,
// //       required this.title,
// //       this.content,
// //       required this.countIndex})
// //       : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Align(
// //             //   alignment: Alignment.center,
// //             //   child: Icon(
// //             //     Icons.warning,
// //             //     size: SizeConfig().screenWidth * 0.2,
// //             //     color: Colors.red,
// //             //   ),
// //             // ),
// //             content != null
// //                 ? Padding(
// //                     padding: const EdgeInsets.symmetric(vertical: 8),
// //                     child: Text(
// //                       content!,
// //                       style: TextStyle(
// //                           fontSize: CommonConstants.smallText,
// //                           color: ColorConstants.black),
// //                     ),
// //                   )
// //                 : const SizedBox(),
// //             const SizedBox(
// //               height: 8,
// //             ),
// //             Text(
// //               title.tr,
// //               style: TextStyle(
// //                   fontSize: CommonConstants.normalText,
// //                   color: ColorConstants.black),
// //             ),
// //             const SizedBox(
// //               height: 8,
// //             ),
// //             Obx(() => Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: phrase.mapIndexed((index, element) {
// //                     return ListTile(
// //                       leading: Text('${countIndex + index + 1}.',
// //                           style: const TextStyle(
// //                               color: Colors.red,
// //                               fontSize: CommonConstants.normalText)),
// //                       title: Text(
// //                         element,
// //                         style: const TextStyle(color: Colors.red),
// //                       ),
// //                     );
// //                   }).toList(),
// //                 ))
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

class Verify extends GetView {
  Verify({Key? key}) : super(key: key);

  @override
  CreateWalletController controller = Get.put(CreateWalletController());

  @override
  Widget build(BuildContext context) {
    // Get.isRegistered<CreateWalletController>()
    //     ? Get.find<CreateWalletController>()
    //     : Get.put(CreateWalletController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, size: 18)),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verify Account'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                //color: ColorConstants.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.controllerRandom,
                      onChanged: (val) {
                        controller.searchWords(val);
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter 24 Word Secrate Phrase'.tr,
                          hintStyle: const TextStyle(fontSize: 12),
                          labelStyle: const TextStyle(fontSize: 12),
                          label: Text('Enter 24 Word Secrate Phrase'.tr),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.secondaryAppColor),
                              borderRadius: BorderRadius.circular(20)),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.secondaryAppColor),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 40,
                      child: Obx(() => ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.searchList.map((element) {
                              return SelectContainer(
                                  title: element,
                                  onSelect: () {
                                    if (controller.selectedEdit.value < 1000) {
                                      controller.phraseList[controller
                                          .selectedEdit.value] = element;
                                      controller.selectedEdit.value = 10001;
                                    } else {
                                      controller.phraseList.add(element);
                                    }
                                    controller.isActive.value =
                                        controller.phraseList.length >= 24;

                                    controller.controllerRandom.text = '';
                                    controller.searchList.clear();
                                  });
                            }).toList(),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => controller.phraseList.isNotEmpty
                    ? Text(
                        'Passphrase Entered (click to Edit)'.tr,
                        style: GoogleFonts.roboto(fontSize: 16),
                      )
                    : const SizedBox()),
              ),
              Obx(() => Column(
                    children:
                        controller.phraseList.mapIndexed((index, element) {
                      return ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                        title: Text(
                          element,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: controller.selectedEdit.value == index
                                ? ColorConstants.secondaryDarkAppColor
                                : Colors.red,
                          ),
                        ),
                        onTap: () {
                          controller.selectedEdit.value = index;
                          controller.controllerRandom.text = element;
                        },
                      );
                    }).toList(),
                  ))
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() => SaveButton(
                  title: 'Next Step'.tr,
                  onPress: () {
                    controller.verify();
                  },
                  isActive: controller.isActive.value,
                )),
          )
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/shared/shared.dart';
import 'create_wallet_controller.dart';
import 'package:collection/collection.dart';

class ImportWalletView extends GetView<CreateWalletController> {
  final bool isImportWallet;
  const ImportWalletView({
    Key? key,
    this.isImportWallet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<CreateWalletController>()
        ? Get.find<CreateWalletController>()
        : Get.put(CreateWalletController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios,
                   size: 18)),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Enter Passphrase'.tr,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                //color: ColorConstants.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter 12 Word Secrate Phrase'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: ColorConstants.black),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.controllerRandom,
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: ColorConstants.black),
                      onChanged: (val) {
                        controller.searchWords(val);
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter 12 Word Secrate Phrase'.tr,
                          hintStyle: const TextStyle(
                                 fontSize: 12),
                          labelStyle: const TextStyle(
                                 fontSize: 12),
                          label: Text('Enter & Select'.tr),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.secondaryAppColor),
                              borderRadius: BorderRadius.circular(12)),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.secondaryAppColor),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 40,
                      child: Obx(() => ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.searchList.map((element) {
                              return SelectContainer(
                                  title: element,
                                  onSelect: () {
                                    if (controller.selectedEdit.value < 1000) {
                                      controller.phraseList[controller
                                          .selectedEdit.value] = element;
                                      controller.selectedEdit.value = 10001;
                                    } else {
                                      controller.phraseList.add(element);
                                    }
                                    controller.isActive.value =
                                        controller.phraseList.length >= 12;

                                    controller.controllerRandom.text = '';
                                    controller.searchList.clear();
                                  });
                            }).toList(),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => controller.phraseList.isNotEmpty
                    ? Text(
                        'Passphrase Entered (click to Edit)'.tr,
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: ColorConstants.black),
                      )
                    : const SizedBox()),
              ),
              Obx(() => Column(
                    children:
                        controller.phraseList.mapIndexed((index, element) {
                      return ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: ColorConstants.black),
                        ),
                        title: Text(
                          element,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: controller.selectedEdit.value == index
                                ? ColorConstants.secondaryDarkAppColor
                                : ColorConstants.black,
                          ),
                        ),
                        onTap: () {
                          controller.selectedEdit.value = index;
                          controller.controllerRandom.text = element;
                        },
                      );
                    }).toList(),
                  ))
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() => SaveButton(
                  title: 'Next Step'.tr,
                  onPress: () {
                    controller.sendPassphrase(isImportWallet: isImportWallet);
                  },
                  isActive: controller.isActive.value,
                )),
          )
        ],
      ),
    );
  }
}
*/
class RecoveryDropDown extends StatelessWidget {
  RecoveryDropDown({Key? key}) : super(key: key);

  final recovertype = [
    ["Secrate Phrase".tr],
    ["Private Key".tr],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Select Recovery type'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              ...recovertype.map((i) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: ListTile(
                    //  trailing: const Icon(Icons.circle, color: Colors.blue),
                    title: Text(
                      i.first,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.back(result: {'type': i.first});
                    },
                  )))),
            ],
          )),
    );
  }
}
