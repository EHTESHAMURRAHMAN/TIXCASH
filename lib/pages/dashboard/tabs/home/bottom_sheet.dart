import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/user_response.dart';
import 'package:tixcash/pages/Stack/Stack_Controller.dart';
import 'package:tixcash/pages/account/create_wallet/import_wallet_view.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/controllers/invite_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/settings_controller.dart';
import 'package:tixcash/shared/constants/colors.dart';
import 'package:tixcash/shared/constants/storage.dart';
import 'package:tixcash/shared/widgets/select_profile.dart';

class BottomSheetView extends StatefulWidget {
  final Function() onSelect;
  final ScrollController scrollController;
  const BottomSheetView(
      {Key? key, required this.scrollController, required this.onSelect})
      : super(key: key);

  @override
  State<BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  var controller = Get.find<HomeController>();
  var controller1 = Get.find<SettingsController>();
  var controller2 = Get.find<AppController>();
  List<UserResponse> _users = [];

  @override
  void initState() {
    super.initState();
    final prefs = Get.find<SharedPreferences>();
    String? val = prefs.getString(StorageConstants.userInfo);
    _users = val != null ? userResponseFromJson(val) : [];
    _users.sort((a, b) => a.active == b.active ? 1 : -1);
    if (mounted) setState(() {});
    // controller1.backupPharse1();
    controller2.backupPharse();
    StackController().getwhiteliststatus();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = Get.find<SharedPreferences>();
    String? val = prefs.getString(StorageConstants.userInfo);
    _users = val != null ? userResponseFromJson(val) : [];
    _users.sort((a, b) => a.active == b.active ? 1 : -1);
    return Material(
      child: Container(
        color: Colors.white,
        child: ListView(
          controller: widget.scrollController,
          children: [
            Container(
              height: 8,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3,
                  vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 6),
            Column(
              children: List<Widget>.generate(_users.length, (index) {
                UserResponse user = _users.elementAt(index);
                return SelectProfile(
                  name: user.name,
                  isSelected: userInfo!.id == user.id,
                  onSelect: (val) {
                    if (mounted) {
                      setState(() {
                        userInfo = user;
                        widget.onSelect();
                        controller.getsubs();
                        // controller1.backupPharse1();
                        controller2.backupPharse();
                        InviteController().inviteInits();
                        StackController().getwhiteliststatus();
                      });
                    }
                  },
                  onEdit: (val) {
                    userInfo!.name = val;
                    _users.elementAt(index).name = val;

                    final prefs = Get.find<SharedPreferences>();
                    prefs.setString(
                        StorageConstants.userInfo, userResponseToJson(_users));
                    controller.getsubs();
                  },
                  onDelete: (val) {
                    _users.removeAt(index);

                    final prefs = Get.find<SharedPreferences>();
                    prefs.setString(
                        StorageConstants.userInfo, userResponseToJson(_users));
                    Get.back();
                  },
                );
              }),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () {
                  // controller.subscriptionResponse.value?.pid == 0
                  //     ? EasyLoading.showToast('Get Premium Access First')
                  //     :
                  newWallet(context);
                },
                child: Text('Create New Account'.tr,
                    style: const TextStyle(fontSize: 14))),
            TextButton(
                onPressed: () {
                  Get.to(() => const ImportWalletView(
                        isImportWallet: true,
                      ));
                },
                child: Text('Import an Account'.tr,
                    style: const TextStyle(fontSize: 14))),
          ],
        ),
      ),
    );
  }

  void newWallet(context) {
    // BackupWordsController controller1 = Get.put(BackupWordsController());

    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.cancel, color: Colors.transparent),
              Text('Create New Account'.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.cancel, color: Colors.black, size: 25),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300),
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: controller.editingController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: 'Username'.tr,
                            hintStyle: const TextStyle(color: Colors.black26),
                            border: InputBorder.none),
                      ),
                    ),
                    // const Text('Select Currency',
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.bold)),
                    //
                    //const SizedBox(height: 15),
                    // InkWell(
                    //   onTap: () {
                    //     Get.to(currencyPremium())?.then((value) {
                    //       if (value != null) {
                    //         controller.selectCurrencys.value = value['name'];
                    //       }
                    //     });
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 12),
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         color: Colors.grey.shade300),
                    //     width: MediaQuery.of(context).size.width,
                    //     child: Row(
                    //       children: [
                    //         Obx(() => controller.selectCurrencys.value.isEmpty
                    //             ? const Text('Select Currency',
                    //                 style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.bold))
                    //             : Text(controller.selectCurrencys.value,
                    //                 style: const TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.bold),
                    //                 maxLines: 1)),
                    //         const Spacer(),
                    //         const Icon(
                    //           Icons.arrow_drop_down,
                    //           size: 25,
                    //           color: Colors.black,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller.multipleAccount(
                            context, controller.editingController.text);
                        //  controller.editingController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.secondaryDarkAppColor,
                        // side: BorderSide(
                        //     color: ColorConstants.secondaryDarkAppColor
                        //         .withOpacity(.5)),
                        shape: const BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        shadowColor: Colors.lightBlue,
                      ),
                      child: Text('Create New Account'.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tixcash/api/apis.dart';
// import 'package:tixcash/models/user_response.dart';
// import 'package:tixcash/models/walletListResp.dart';
// import 'package:tixcash/pages/account/create_wallet/import_wallet_view.dart';
// import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
// import 'package:tixcash/shared/constants/storage.dart';
// import 'package:tixcash/shared/utils/common_widget.dart';
// import 'package:tixcash/shared/widgets/select_profile.dart';

// class BottomSheetView extends StatefulWidget {
//   final Function() onSelect;
//   final ScrollController scrollController;
//   const BottomSheetView(
//       {Key? key, required this.scrollController, required this.onSelect})
//       : super(key: key);

//   @override
//   State<BottomSheetView> createState() => _BottomSheetViewState();
// }

// class _BottomSheetViewState extends State<BottomSheetView> {
//   var controller = Get.find<HomeController>();
//   List<UserResponse> users = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final prefs = Get.find<SharedPreferences>();
//     String? val = prefs.getString(StorageConstants.userInfo);
//     users = val != null ? userResponseFromJson(val) : [];
//     users.sort((a, b) => a.active == b.active ? 1 : -1);
//     if (mounted) setState(() {});
//     setState(() {
//       userInfo?.id;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         color: Colors.white,
//         child: ListView(
//           controller: widget.scrollController,
//           children: [
//             Container(
//               height: 8,
//               width: double.infinity,
//               margin: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width / 3,
//                   vertical: 8),
//               decoration: BoxDecoration(
//                   color: Colors.black26,
//                   borderRadius: BorderRadius.circular(4)),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 // UserResponse user = users.elementAt(index);
//                 WalletListResp model =
//                     controller.walletListRespResponse.elementAt(index);
//                 return InkWell(
//                   onTap: () {
//                     setState(() {
//                       //userInfo = user;
//                       controller.addresslogin();
//                     });
//                   },
//                   child: Container(
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(18),
//                         color: Colors.blue.shade100),
//                     child: ListTile(
//                       title: Text(
//                         model.accountname,
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               itemCount: controller.walletListRespResponse.length,
//             ),
//             // ListView(
//             //   shrinkWrap: true,
//             //   children: [
//             //     SizedBox(
//             //       height: 200,
//             //       child: Column(
//             //         children: List<Widget>.generate(users.length, (index) {
//             //           UserResponse user = users.elementAt(index);
//             //           return SelectProfile(
//             //             name: user.name,
//             //             isSelected: userInfo!.id == user.id,
//             //             onSelect: (val) {
//             //               if (mounted) {
//             //                 setState(() {
//             //                   userInfo = user;
//             //                   widget.onSelect();
//             //                   controller.getsubs();
//             //                 });
//             //               }
//             //             },
//             //             onEdit: (val) {
//             //               userInfo!.name = val;
//             //               users.elementAt(index).name = val;

//             //               final prefs = Get.find<SharedPreferences>();
//             //               prefs.setString(StorageConstants.userInfo,
//             //                   userResponseToJson(users));
//             //               controller.getsubs();
//             //             },
//             //             onDelete: (val) {
//             //               users.removeAt(index);

//             //               final prefs = Get.find<SharedPreferences>();
//             //               prefs.setString(StorageConstants.userInfo,
//             //                   userResponseToJson(users));
//             //               Get.back();
//             //             },
//             //           );
//             //         }),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             const SizedBox(height: 40),
//             TextButton(
//                 onPressed: () {
//                   controller.subscriptionResponse.value?.pid == 0
//                       ? EasyLoading.showToast('Get Premium Access First')
//                       : paymentforNewWallet(context);
//                 },
//                 child: Text('Create New Account'.tr,
//                     style: const TextStyle(fontSize: 14))),
//             TextButton(
//                 onPressed: () {
//                   Get.to(() => const ImportWalletView(
//                         isImportWallet: true,
//                       ));
//                 },
//                 child: Text('Import an Account'.tr,
//                     style: const TextStyle(fontSize: 14))),
//           ],
//         ),
//       ),
//     );
//   }

//   void paymentforNewWallet(context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Icon(Icons.cancel, color: Colors.transparent),
//               const Text('Pay \$5 For New Wallet',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold)),
//               InkWell(
//                 onTap: () => Get.back(),
//                 child: const Icon(Icons.cancel, color: Colors.black, size: 25),
//               ),
//             ],
//           ),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: [
//                 Column(
//                   children: [
//                     const Text('Select Currency',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 15),
//                     InkWell(
//                       onTap: () {
//                         Get.to(currencyPremium())?.then((value) {
//                           if (value != null) {
//                             controller.selectCurrencys.value = value['name'];
//                           }
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         height: 60,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.grey.shade300),
//                         width: MediaQuery.of(context).size.width,
//                         child: Row(
//                           children: [
//                             Obx(() => controller.selectCurrencys.value.isEmpty
//                                 ? const Text('Select Currency',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold))
//                                 : Text(controller.selectCurrencys.value,
//                                     style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold),
//                                     maxLines: 1)),
//                             const Spacer(),
//                             const Icon(
//                               Icons.arrow_drop_down,
//                               size: 25,
//                               color: Colors.black,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         controller.multipleAccount();
//                         //controller.createNewUser(context);
//                       },
//                       child: const Text('Pay \$5'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         );
//       },
//     );
//   }
// }
