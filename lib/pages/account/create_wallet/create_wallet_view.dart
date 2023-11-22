// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tixcash/pages/account/create_wallet/import_wallet_view.dart';
// import 'package:tixcash/routes/app_pages.dart';
// import 'package:tixcash/shared/shared.dart';
// import 'package:tixcash/shared/widgets/sa_rounded_button.dart';
// import 'package:tixcash/shared/widgets/submit_button.dart';
// import 'create_wallet_controller.dart';
// import 'open_wallet_view.dart';

// class CreateWalletView extends GetView<CreateWalletController> {
//   const CreateWalletView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Get.isRegistered<CreateWalletController>()
//         ? Get.find<CreateWalletController>()
//         : Get.put(CreateWalletController());
//     return Scaffold(
//       backgroundColor: const Color(0xFF1680ee),
//       body: SafeArea(
//           child: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 32,
//                 ),
//                 Text(
//                   'LINE',
//                   style: GoogleFonts.kodchasan(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w700,
//                       fontStyle: FontStyle.normal),
//                 ),
//                 Text(
//                   'Blockchain wallet'.tr,
//                   style: GoogleFonts.kodchasan(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w300,
//                       fontStyle: FontStyle.normal,
//                       color: const Color(0xFF40C4FF)),
//                 ),
//                 const SizedBox(
//                   height: 90,
//                 ),

//                 // GestureDetector(child: Container(
//                 //   color: const Color(0xFF3A92DB),
//                 //   alignment: Alignment.center,
//                 //   padding: const EdgeInsets.symmetric(vertical: 10),
//                 //   child:  Text('Open Wallet'.tr.toUpperCase(), style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500),),  width: SizeConfig().screenWidth*0.4,),
//                 //   onTap: (){
//                 //     controller.appController.loginDialog(context, (){
//                 //       Get.offAndToNamed(Routes.Dashboard);
//                 //     });
//                 //   },),
//                 // const SizedBox(height: 12,),

//                 GestureDetector(
//                   child: Container(
//                     color: const Color(0xFF3A92DB),
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Text(
//                       'Create Wallet'.tr.toUpperCase(),
//                       style: GoogleFonts.roboto(
//                           fontSize: 13, fontWeight: FontWeight.w500),
//                     ),
//                     width: SizeConfig().screenWidth * 0.4,
//                   ),
//                   onTap: () {
//                     controller.showTermsAndConditions(context);
//                   },
//                 ),

//                 const SizedBox(
//                   height: 12,
//                 ),

//                 GestureDetector(
//                   child: Container(
//                     color: const Color(0xFF3A92DB),
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Text(
//                       'Import Wallet'.tr.toUpperCase(),
//                       style: GoogleFonts.roboto(
//                           fontSize: 13, fontWeight: FontWeight.w500),
//                     ),
//                     width: SizeConfig().screenWidth * 0.4,
//                   ),
//                   onTap: () {
//                     Get.to(() => const ImportWalletView());
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
