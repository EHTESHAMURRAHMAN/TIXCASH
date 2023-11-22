import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/shared/constants/storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'trone_browser.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  bool _isLoading = true;
  late WebViewWidget _webView;
  final String _url = 'https://dapp.tronlink.org/#/';
  bool _isSearch = false;

  List<String> _historyList = [];

  WebViewController mWebViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://dapp.tronlink.org/#/'));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webView = WebViewWidget(controller: mWebViewController);
    // if (Platform.isAndroid) WebViewWidget.platform = SurfaceAndroidWebView();

    // _webView = WebViewWidget(
    //   initialUrl: _url,
    //   javascriptMode: JavascriptMode.unrestricted,
    //   navigationDelegate: (NavigationRequest request) async {
    //     if (kDebugMode) {
    //       print(request.url);
    //     }
    //     if(request.url==_url){
    //       return NavigationDecision.navigate;
    //     }else{
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => TronBrowser(
    //         url: request.url, title: '', onBack: () {
    //
    //       },
    //       )));
    //       return NavigationDecision.prevent;
    //     }
    //   },
    //   onWebViewCreated: (val){
    //
    //   },
    //   onPageStarted: (val){
    //     if(mounted) {
    //       setState(() => _isLoading = false);
    //     }
    //   },
    //   onPageFinished: (val){
    //   },
    // );

    var prefs = Get.find<SharedPreferences>();
    _historyList = prefs.getStringList(StorageConstants.historyList) ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
                child: Container(
              height: 36,
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                onChanged: (val) {
                  if (mounted) {
                    setState(() => _isSearch = true);
                  }
                },
                onSubmitted: (val) {
                  String url = val;

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
                                  onBack: () {},
                                )))
                        .then((value) {
                      var prefs = Get.find<SharedPreferences>();
                      _historyList =
                          prefs.getStringList(StorageConstants.historyList) ??
                              [];
                    });
                  }

                  if (kDebugMode) {
                    print('Submitted $val _validURL $_validURL');
                  }
                  if (mounted) {
                    setState(() => _isSearch = false);
                  }
                },
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'DApp name or url'),
              ),
            ))
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.access_time), onPressed: () {})
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          _webView ?? Container(),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: 0,
                ),
          _isSearch
              ? HistoryView(
                  list: _historyList,
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}

class HistoryView extends StatelessWidget {
  final List<String> list;
  const HistoryView({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(4, 4),
                spreadRadius: 4,
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(16)),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text(
              'data',
              style: TextStyle(color: Colors.black),
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}

// class PopularView extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return shadeContainer(Container(
//       child: Column(children: [
//         Row(children: [
//
//         ],),
//
//       ],),
//     ));
//   }
// }

class DAppCell {
  final String name;
  final String title;
  final String descp;
  final String image;

  DAppCell(
      {required this.name,
      required this.title,
      required this.descp,
      required this.image});
}
