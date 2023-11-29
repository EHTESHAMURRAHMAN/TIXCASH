import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class marketq extends StatefulWidget {
  const marketq({Key? key}) : super(key: key);

  @override
  State<marketq> createState() => _marketqState();
}

class _marketqState extends State<marketq> {
  @override
  Widget build(BuildContext context) {
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
          Scaffold(
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Market'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      'The Market Page offers details and data about cryptocurrencies, including pricing, trade volumes, and market capitalization, gathered from a variety of well-known websites'
                          .tr,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 40),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all()),
                    ),
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse('https://coinmarketcap.com/');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                        // const url = 'https://coinmarketcap.com/';
                        // if (await canLaunch(url)) {
                        //   await launch(url,
                        //       forceWebView: true, enableJavaScript: true);
                        // } else {
                        //   throw 'Could not launch $url';
                        // }
                        // const url = 'https://coinmarketcap.com/';
                        // openBrowserUrl(url: url, inApp: true);
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                "https://coinmarketcap.com/apple-touch-icon.png",
                                height: 30,
                              ),
                              const SizedBox(width: 15),
                              Text('CoinMarketCap'.tr,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all()),
                    ),
                    InkWell(
                      onTap: () {
                        const url =
                            'https://in.tradingview.com/markets/cryptocurrencies/prices-all/';
                        openBrowserUrl(url: url, inApp: true);
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                "https://seeklogo.com/images/T/tradingview-logo-501309F1AA-seeklogo.com.png",
                                height: 18,
                              ),
                              const SizedBox(width: 15),
                              Text('Trading View'.tr,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
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

class explore extends StatelessWidget {
  const explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Center(
        child: Text('Launching Soon'.tr,
            style:
                GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
