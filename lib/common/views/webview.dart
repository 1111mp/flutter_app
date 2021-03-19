import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('webview'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse('http://localhost:3000'),
            ),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                resourceCustomSchemes: ['atom'],
                transparentBackground: true,
              ),
            ),
            onLoadResourceCustomScheme:
                (InAppWebViewController controller, Uri url) async {
              print(url);
              var bytes =
                  await rootBundle.load("assets/flutter-mark-square-64.png");
              var response = CustomSchemeResponse(
                data: bytes.buffer.asUint8List(),
                contentType: "image/png",
              );
              return response;
            },
          );
        },
      ),
    );
  }
}
