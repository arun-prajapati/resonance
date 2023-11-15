import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webscreen extends StatefulWidget {
  const webscreen({super.key});

  @override
  State<webscreen> createState() => _webscreenState();
}

class _webscreenState extends State<webscreen> {
  WebViewController? _controller;

  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                // 'https://www.mircovsoftware.com/resonance-policy'
                'https://www.mircovsoftware.com/resonance-policies')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
              //Uri.parse('https://www.mircovsoftware.com/resonance-policy')
              Uri.parse('https://www.mircovsoftware.com/resonance-policies'))
          .catchError((error) {
        print(error);
      }).whenComplete(() {
        print("Completed");
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 5, 4, 36),
          centerTitle: true,
          leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 100,
        child: WebViewWidget(
          controller: _controller!,
        ),
      ),
    );
  }
}
