import 'dart:async';
import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:giveme5/admob_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'WebView.dart';

class EpisodeDetailsPage extends StatefulWidget {

  final String index;
  final String imagelink;
  final String link;
  final String description;
  final String password;

  EpisodeDetailsPage(this.index , this.imagelink , this.description , this.link, this.password);


  @override

  _EpisodeDetailsPageState createState() => _EpisodeDetailsPageState();







}


class _EpisodeDetailsPageState extends State<EpisodeDetailsPage> {



  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    Admob.initialize();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }


  final ams = AdmobService();





  @override
  Widget build(BuildContext context) {

    InterstitialAd interstitialAd = ams.showInterstitialAd();
    interstitialAd.load();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: (){
        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        //   },
        // ),
        centerTitle: true,
        title: Image.asset('assets/GiveMe5.png',width: 140, height: 140,),
        backgroundColor: Colors.black,
        actions: [
          TextButton.icon(onPressed:(){
            Phoenix.rebirth(context);
          }, icon: Icon(Icons.refresh), label: Text(''),)
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(color: Colors.grey,),
            SizedBox(height: 10,),


            // TEXT of Episode No
            Center(
              child: Text('Episode No ${widget.index}',style: TextStyle(color: Colors.white,
                  fontSize: 26,fontWeight: FontWeight.w700),),
            ),

            SizedBox(height: 10,),
            Divider(color: Colors.grey,),

            // Here is the Banner Add
            AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.BANNER),


            //  Image to show the thumbnail
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30 , vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white , width: 1),
                  image: DecorationImage(
                    image: NetworkImage(widget.imagelink),
                    fit: BoxFit.fill,
                  )
              ),
            ),



            // This is to show description
            Container(
              //height: 400,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              //color: Colors.white,
              child: Text(
                widget.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                ),
              ),
            ),



            SizedBox(height: 20,),
            // Here is the Banner Add
            AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
            SizedBox(height: 20,),










            // This is for video window

            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  border: Border.all(color: Colors.grey[700] , width: 3),
                  image: DecorationImage(
                    image: NetworkImage(widget.imagelink),
                    fit: BoxFit.fill,
                  )
              ),
              child: WebView(
                initialUrl: widget.link,
                onWebViewCreated: (WebViewController webViewController){
                  _controller.complete(webViewController);
                },
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),


            SizedBox(height: 20,),


            password(widget.password),


            SizedBox(height: 20,),

            // For the Watch now Button
            Center(
              child: GestureDetector(
                onTap: () async{
                  interstitialAd.show(
                    anchorType: AnchorType.bottom,
                    anchorOffset: 0.0,
                    horizontalCenterOffset: 0.0,
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: widget.link)));
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.red[400] , width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                        'Watch in full screen',
                        style: TextStyle(fontSize: 17 , fontWeight: FontWeight.w400 , color: Colors.white),
                      ),
                  ),
                ),
              ),
            ),


            SizedBox(height: 50,)

          ],
        ),
      ),

    );
  }







  Widget password(String password) {
    if(password == 'no')
    {
      return SizedBox(
        height: 5,
      );
    }
    else{
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70,),
            GestureDetector(
              onTap: ()=>()=>FlutterClipboard.copy(password),
              child: Container(
                margin: EdgeInsets.only(left: 35),
                //color: Colors.red,
                child: Center(
                  child: Text("Password:\n$password",
                    style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500 , color: Colors.red),),
                ),
              ),
            ),

            IconButton(icon: Icon(Icons.content_copy), onPressed: ()=>FlutterClipboard.copy(password) , iconSize: 30, color: Colors.white,)
          ],
        ),
      );
    }
  }

}
