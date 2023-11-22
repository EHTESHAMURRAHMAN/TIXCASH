import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/pages/dashboard/tabs/d_apps/d_apps_controller.dart';
import 'package:tixcash/pages/dashboard/tabs/d_apps/search_page.dart';
import 'package:tixcash/shared/constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TronBrowser extends StatefulWidget {
  final String url;
  final String title;
  final Function() onBack;
  const TronBrowser(
      {Key? key, required this.url, required this.title, required this.onBack})
      : super(key: key);
  @override
  _TronBrowserState createState() => _TronBrowserState();
}

class _TronBrowserState extends State<TronBrowser> {
  late WebViewWidget _webView;
  bool _isLoading = true;
  String _name = 'Loading..';
  String currentURL = '';
  late WebViewController _controller;
  String _hostName = '';

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  final DAppsController dAppsController =
      Get.isRegistered() ? Get.find() : Get.put(DAppsController());

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
    ); //..loadRequest(Uri.parse('https://dapp.tronlink.org/#/'));

  @override
  void initState() {
    currentURL = widget.url;

    mWebViewController.loadRequest(Uri.parse(currentURL));

    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _webView = _loadWebView();
    final uri = Uri.parse(currentURL);
    _hostName = uri.host; // www.wikipedia.org
    super.initState();
  }

  WebViewWidget _loadWebView() => WebViewWidget(controller: mWebViewController);

/*  WebViewWidget _loadWebView() => WebView(
    initialUrl: currentURL,
    javascriptMode: JavascriptMode.unrestricted,
    key: UniqueKey(),
    onWebViewCreated: (WebViewController webViewController) {
      _controllerCompleter.future.then((value) => _controller = value);
      _controllerCompleter.complete(webViewController);
    },
    onPageStarted: (val){
      final uri = Uri.parse(currentURL);
      if (kDebugMode) {
        print('Host => ${uri.host.split('.')[0]}');
      }
      _name = uri.host.split('.')[0];
    },
    onPageFinished: (val){
      if(mounted) {
        setState(() => _isLoading = false);
      }
      _backupHistoryList(currentURL);
    },
  );*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              child: Container(
                width: double.infinity,
                height: 44,
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                child: Text(
                  _hostName,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => Get.to(SearchPage(
                url: currentURL,
              ))?.then((value) {
                if (value == null) return;
                currentURL = value;
                final uri = Uri.parse(currentURL);
                _hostName = uri.host;
                _webView = _loadWebView();
                setState(() {});
              }),
            ),
            // backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: widget.onBack != null
                ? IconButton(
                    onPressed: () {
                      widget.onBack!();
                    },
                    icon: const Icon(Icons.arrow_back))
                : null,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  icon: const Icon(Icons.rotate_right),
                  onPressed: () {
                    _controller.reload();
                  })
            ],
          ),
          body: Stack(
            children: [
              _webView,
              _isLoading
                  ? const LinearProgressIndicator()
                  : Container(
                      height: 0,
                    ),
            ],
          ),
        ));
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      if (widget.onBack != null) widget.onBack!();
      return Future.value(true);
    }
  }

  _backupHistoryList(String url) {
    final prefs = Get.find<SharedPreferences>();
    List<String> list = prefs.getStringList(StorageConstants.historyList) ?? [];
    List<String> listTemp = list.where((element) => element == url).toList();
    if (listTemp.isEmpty) {
      list.add(url);
    }
    prefs.setStringList(StorageConstants.historyList, list);
  }
}
