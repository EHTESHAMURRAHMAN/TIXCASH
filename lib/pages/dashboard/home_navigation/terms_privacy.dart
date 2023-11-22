import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsPolicy extends StatefulWidget {
  final String title;
  final String fileName;//TYV_Terms_Conditions//TYV_Privacy_Policy

  const TermsPolicy({Key? key, required this.title, required this.fileName}) : super(key: key);

  @override
  State<TermsPolicy> createState() => _TermsPolicyState();
}

class _TermsPolicyState extends State<TermsPolicy> {

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
    );
    //..loadRequest(Uri.parse('https://flutter.dev'));

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loadHtmlFromAssets();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: WebViewWidget(controller: mWebViewController),
      // body: WebViewW(
      //   controller: mWebViewController!,
      //   initialUrl: widget.title,
      //   onWebViewCreated: (WebViewController webViewController) {
      //     mWebViewController = webViewController;
      //     _loadHtmlFromAssets();
      //   },
      // ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/text_files/${widget.fileName}.html');
    mWebViewController.loadRequest(Uri.dataFromString(fileText));
    // mWebViewController!.loadUrl( Uri.dataFromString(
    //     fileText,
    //     mimeType: 'text/html',
    //     encoding: Encoding.getByName('utf-8')
    // ).toString());
  }
}
