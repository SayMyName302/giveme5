import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatefulWidget {

  String filePath;

  PrivacyPolicyPage({this.filePath});

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          TextButton.icon(onPressed:(){
            Phoenix.rebirth(context);
          }, icon: Icon(Icons.refresh), label: Text(''),)
        ],
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonDetailsPage()));
        //   },
        // ),
        centerTitle: true,
        title: Image.asset('assets/GiveMe5.png',width: 140, height: 140,),
        backgroundColor: Colors.black,
      ),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          _webViewController = webViewController;
          _loadHtmlFromAssets();
        }
      ),
    );
  }

  _loadHtmlFromAssets() async{
    String fileHtmlContents = await rootBundle.loadString(widget.filePath);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
    mimeType: 'text/html' , encoding: Encoding.getByName('utf-8')).toString());
  }
}
