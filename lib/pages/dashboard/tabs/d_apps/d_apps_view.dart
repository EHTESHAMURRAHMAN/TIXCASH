import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/pages/dashboard/tabs/d_apps/trone_browser.dart';
import 'package:tixcash/pages/dashboard/tabs/home/home_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/views/invite_view.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';
import 'd_apps_controller.dart';

class DAppsView extends GetView<DAppsController> {
  const DAppsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.put(HomeController());
    //String textValue = '';
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff1680ee),
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff1680ee),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          /*Scaffold(
          backgroundColor: Colors.white,
          body: ListView(children: [
            Stack(children: [
              Container(
                height: size.height/3+50,
              ),
              Container(
                height: size.height/3,
                width: double.infinity,
                child: Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/slogo.png', width: size.height/8,),
                    const SizedBox(height: 8,),
                    Text('LINE Chain', style: GoogleFonts.roboto(
                        fontSize: 24, fontWeight: FontWeight.w700))
                  ],),),
                decoration:  const BoxDecoration(
                    color: Color(0xFF1680ee),
                    image: DecorationImage(image: AssetImage('assets/images/gfx-a.png'))
                  // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                  // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 10, offset: Offset(4, 4))]
                ),
              ),
              Positioned(
                  bottom: 25, left: 0, right: 0,
                  child: GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      height: 50, width: double.infinity,
                      child: TextField(
                        enabled: false,
                        onChanged: (val){
                          textValue = val;
                          controller.isSearch.value = true;
                          controller.getHistoryList(val);
                        },
                        onSubmitted: (val){
                          _onSubmit(context, val);
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration:  InputDecoration(
                            hintText: 'Search or Type URL',
                            hintStyle: const TextStyle(color: Colors.black26),
                            border: InputBorder.none,
                            // suffixIcon: Icon(Icons.search),
                            suffix: GestureDetector(onTap: (){
    
                              AppFocus.unfocus(context);
                              _onSubmit(context, textValue);
    
                            }, child: const Icon(Icons.search, color: Colors.black, size: 24,))
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 4, offset: Offset(4, 4))]
                      ),
                    ),
                    onTap: (){
                      AppFocus.unfocus(context);
                      Get.to(const SearchPage())?.then((value){
                        if(controller.mFocus.hasFocus){
                          controller.mFocus.unfocus();
                        }
                        if(value!=null){
                          _onSubmit(context, value);
                        }
                      });
                    },
                  )),
            ],),
    
            Row(children: const [
              DAppCard(icon: Icons.account_balance_wallet_rounded, title: 'Decentralized Finance', color: Colors.greenAccent,),
              DAppCard(icon: Icons.swap_horiz, title: 'Decentralized Exchanges', color: Colors.purple,),
            ],),
            const SizedBox(height: 8,),
            Row(children: const [
              DAppCard(icon: Icons.home, title: 'Arts & Collectables', color: Colors.orange,),
              DAppCard(icon: Icons.wallet_giftcard, title: 'Earn Crypto', color: Colors.blue,),
            ],),
    
            const SizedBox(height: 8,),
            Row(children: const [
              DAppCard(icon: Icons.app_registration, title: 'Developers Tools', color: Colors.blueGrey,),
              DAppCard(icon: Icons.chat, title: 'Earn Crypto', color: Colors.yellow,),
            ],),
          ],),
        ),*/
          Obx(() => controller.lastUrl.value.isEmpty
              ? Scaffold(
                  backgroundColor: Colors.white,
                  body: ListView(
                    children: [
                      Container(
                        height: size.height / 3,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1680ee),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                        ),
                        // launchUrlString('https://coinmarketcap.com/', mode: LaunchMode.externalApplication);
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/logo.png',
                                width: size.height / 6,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                    'Embark on your journey with Tixcash Wallet\'s revamped brand identity, tailored to enrich your Web3 experience. Uncover our intuitive layout and much more. Start your journey today'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Tixcash Services'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              homeCtrl.subscriptionResponse.value?.pid == 0
                                  ? stakePopup(context)
                                  : Get.to(stakingIncome());
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/logo.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Tixcash Stake'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              EasyLoading.showToast('Launching Soon'.tr,
                                  toastPosition: EasyLoadingToastPosition.top);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/fitness.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Fitness Club'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              EasyLoading.showToast('Launching Soon'.tr,
                                  toastPosition: EasyLoadingToastPosition.top);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/2170/2170714.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Community'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              EasyLoading.showToast('Launching Soon'.tr,
                                  toastPosition: EasyLoadingToastPosition.top);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/mining.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Mining Pool'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              EasyLoading.showToast('Launching Soon'.tr,
                                  toastPosition: EasyLoadingToastPosition.top);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/store.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Tixcash Stores'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(const Courses());
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/courses.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Courses'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              EasyLoading.showToast('Launching Soon'.tr,
                                  toastPosition: EasyLoadingToastPosition.top);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/cash_share.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Cash Sharing'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              EasyLoading.showToast('Launching Soon'.tr,
                                  toastPosition: EasyLoadingToastPosition.top);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/foundation.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Foundation'.tr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('DeFi'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              const url = 'https://pancakeswap.finance/';
                              openBrowserUrl(url: url, inApp: true);
                              // launchUrlString('https://pancakeswap.finance/',
                              //     mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.network(
                                    'https://s2.coinmarketcap.com/static/img/coins/200x200/7186.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Pancakeswap',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          // DAppCard(
                          //   // icon: Icons.account_balance_wallet_rounded,
                          //   title: 'Pancakeswap',
                          //   color: Colors.greenAccent,
                          //   onTap: () {
                          //     launchUrlString('https://pancakeswap.finance/', mode: LaunchMode.externalApplication);
                          //   },
                          // ),

                          InkWell(
                            onTap: () {
                              const url = 'https://app.uniswap.org/';
                              openBrowserUrl(url: url, inApp: true);
                              // launchUrlString('https://app.uniswap.org/',
                              //     mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Uniswap_Logo.svg/1200px-Uniswap_Logo.svg.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Uniswap',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),

                          // DAppCard(
                          //   //  icon: Icons.swap_horiz,
                          //   title: 'Uniswap',
                          //   color: Colors.purple,
                          //   onTap: () {
                          //     launchUrlString('https://app.uniswap.org/', mode: LaunchMode.externalApplication);
                          //   },
                          // ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              const url = 'https://curve.fi/#/ethereum/swap';
                              openBrowserUrl(url: url, inApp: true);
                              // launchUrlString('https://curve.fi/#/ethereum/swap',
                              //     mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.network(
                                    'https://miro.medium.com/v2/resize:fit:1400/1*TJp7SItIYcHFKtOLbcAeeQ.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Curve',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),

                          // DAppCard(
                          //   //  icon: Icons.home,
                          //   title: 'Curve',
                          //   color: Colors.orange,
                          //   onTap: () {
                          //     launchUrlString('https://curve.fi/#/ethereum/swap', mode: LaunchMode.externalApplication);
                          //   },
                          // ),
                          InkWell(
                            onTap: () {
                              const url =
                                  'https://app.1inch.io/#/1/simple/swap/USDT';
                              openBrowserUrl(url: url, inApp: true);
                              // launchUrlString(
                              //     'https://app.1inch.io/#/1/simple/swap/USDT',
                              //     mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.network(
                                    'https://static.vecteezy.com/system/resources/previews/024/092/590/original/1inch-network-1inch-glass-crypto-coin-3d-illustration-free-png.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('1inch',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              const url = 'https://yearn.fi/vaults';
                              openBrowserUrl(url: url, inApp: true);
                              // launchUrlString('https://yearn.fi/vaults',
                              //     mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/6001/6001662.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Yearn',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              const url = 'https://www.sushi.com/swap';
                              openBrowserUrl(url: url, inApp: true);
                              //launchUrlString('https://www.sushi.com/swap', mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.network(
                                    'https://img.freepik.com/premium-vector/sushiswap-sushi-token-symbol-cryptocurrency-logo-coin-icon-isolated-white-background-vector-illustration_337410-1379.jpg',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Sushi',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          // DAppCard(
                          //   //child: Image.network(''),
                          //   title: '',
                          //   color: Colors.yellow,
                          //   onTap: () {
                          //     launchUrlString('https://curve.fi/#/ethereum/swap', mode: LaunchMode.externalApplication);
                          //   },
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                )
              : TronBrowser(
                  url: controller.lastUrl.value,
                  title: '',
                  onBack: () {
                    // controller.lastUrl.value = '';
                    // final prefs = Get.find<SharedPreferences>();
                    // prefs.setString(StorageConstants.lastOPen, '');

                    //controller.dashboardController.updateIndex(0);
                  },
                ))
        ],
      ),
    );
  }

  void stakePopup(context) {
    // BackupWordsController controller1 = Get.put(BackupWordsController());

    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/icons/logo.png',
            height: MediaQuery.of(context).size.height / 12,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Text('Linking to Tixcash Stake'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.to(stakingIncome());
                          },
                          child: Text('Sign'.tr),
                          //    child: const Text('Pay \$5'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel'.tr),
                          //    child: const Text('Pay \$5'),
                        ),
                      ],
                    )
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

  _onSubmit(context, val) {
    String url = val;
    if (val.toString().contains('http')) {
      url = 'https://$url';
    }

    var urlPattern =
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+))';
    bool _validURL = RegExp(urlPattern).hasMatch(val);

    if (_validURL && val.contains('http')) {
      url = val;
    } else {
      _validURL = RegExp(urlPattern).hasMatch('http://$val');
      if (_validURL) {
        url = 'https://$val';
      } else {
        url = "https://www.google.com/search?q=$val";
      }
    }
    if (val.isNotEmpty) {
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => TronBrowser(
                    url: url,
                    title: '',
                    onBack: () {
                      //controller.dashboardController.updateIndex(0);
                    },
                  )))
          .then((value) {
        var prefs = Get.find<SharedPreferences>();
        controller.historyList.value =
            prefs.getStringList(StorageConstants.historyList) ?? [];
      });
    }

    if (kDebugMode) {
      print('Submitted $val _validURL $_validURL');
    }
    controller.isSearch.value = false;
  }

  Future openBrowserUrl({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }
}

class DAppCard extends StatelessWidget {
  final String title;
  final Color color;
  final Function()? onTap;
  const DAppCard(
      {Key? key, required this.title, this.color = Colors.black, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(1, 1),
                  spreadRadius: 2,
                  blurRadius: 4)
            ]),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
                child: Text(title,
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
          ],
        ),
      ),
    ));
  }
}

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
        title: Text('Courses'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        // ignore: prefer_const_constructors
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Official Tixcash preorder and purchase channel'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              const Text('0x9845A79fCBa15D3411aba3DD3e04A7A47F7cA3ED',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              Text('Only USDC and BUSD of BEP20 accepted.'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ]),
      ),
    );
  }
}
