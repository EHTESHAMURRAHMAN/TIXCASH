import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tixcash/pages/dashboard/home_navigation/home_navigation_view.dart';
import 'package:tixcash/shared/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'tyv_market_controller.dart';

class TyvMarketView extends GetView<TyvMarketController> {
  const TyvMarketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeNavigationView(
        child: Container(
      padding: const EdgeInsets.all(12),
      child: RefreshIndicator(
          onRefresh: controller.marketListuser,
          child: Obx(() => ListView(
                children: controller.marketResponse.map((element) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorConstants.blackBg),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network(element.shopLogo, width: 40,),

                        FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: element.shopLogo,
                          width: 40,
                          height: 40,
                          imageErrorBuilder: (context, url, error) =>
                              Image.asset(
                            'assets/images/global.png',
                            width: 40,
                            height: 40,
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  element.marketName,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )),
                                Icon(
                                  Ionicons.location,
                                  size: 24,
                                  color: ColorConstants.secondaryDarkAppColor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          launch(element.contact);
                                        },
                                        child: Text(element.marketLocation,
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.right))),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          launch(element.contact);
                                        },
                                        child: Text(
                                          element.contact,
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ))),
                                Icon(
                                  Ionicons.logo_whatsapp,
                                  size: 24,
                                  color: ColorConstants.secondaryDarkAppColor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Text(element.contact,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.right)),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  element.address,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )),
                                IconButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: element.address));
                                      EasyLoading.showToast('Copied'.tr);
                                    },
                                    icon: const Icon(Icons.copy))
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  );
                }).toList(),
              ))),
    ));
  }
}
