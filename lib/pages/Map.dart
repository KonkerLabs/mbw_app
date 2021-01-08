import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapPageState();
  }

}

class MapPageState extends State<MapPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool isProduction = bool.fromEnvironment('dart.vm.product');

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: WebView(
              initialUrl: isProduction ? 'http://projac.mybusway.com' : 'http://10.0.2.2',
              javascriptMode: JavascriptMode.unrestricted,
            )
    );
  }

}