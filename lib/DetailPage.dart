

import 'package:admob_flutter/admob_flutter.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:giveme5/WebView.dart';
import 'package:giveme5/admob_service.dart';

class DetailPage extends StatefulWidget {

  final DocumentSnapshot info;
  final String listName;
  DetailPage(this.info , this.listName);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {



  @override
  void initState() {
    super.initState();
    Admob.initialize();
  }


  final ams = AdmobService();





  @override
  Widget build(BuildContext context) {




    InterstitialAd interstitialAd = ams.showInterstitialAd();
    interstitialAd.load();



    return Scaffold(
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [



            // THIS IS THE MAIN CONTAINER FOR THE TITLE IMAGE
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(40.0) , bottomLeft: Radius.circular(40.0)),
                image: DecorationImage(
                  image: NetworkImage(widget.info.data['link']),
                  fit: BoxFit.fill,
                )
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(40.0) , bottomLeft: Radius.circular(40.0)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.blue.withOpacity(0.6),
                          Colors.black.withOpacity(0.5),
                        ]
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 25),
                      //color: Colors.yellow,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                width: MediaQuery.of(context).size.width - 120,
                                margin: EdgeInsets.only(left: 20.0),
                                //color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: Text(widget.info.data['name'],
                                        style: TextStyle(fontSize: 28 , fontWeight: FontWeight.w600 , color: Colors.white),),
                                    ),

                                    SizedBox(height: 10,),


                                    // TAGS ROW
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.6),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        border: Border.all(color: Colors.white,width: 1.5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.info.data['duration'].toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


            SizedBox(height: 20,),
            // Here is the Banner Add
            AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.BANNER),



            // THIS IS THE 2ND CONTAINER FOR THE BODY
            Container(
              //color: Colors.red,
              width: MediaQuery.of(context).size.width-10,
              child: Column(
                children: [
                  password(widget.info),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //height: 400,
                        width: 180,
                        margin: EdgeInsets.only(top: 20 , left: 20 , right: 10),
                        //color: Colors.white,
                        child: Text(
                          widget.info.data['description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),

                      if(widget.listName == "latest")...[
                        Hero(
                          tag: "latest${widget.info.data['name']}",
                          child: Container(
                            height: 175,
                            width: 130,
                            margin: EdgeInsets.only(top: 20 ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.white , width: 1),
                                image: DecorationImage(
                                  image: NetworkImage(widget.info.data['link']),
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),
                        ),
                      ]
                      else...[
                        Hero(
                          tag: "movies${widget.info.data['name']}",
                          child: Container(
                            height: 175,
                            width: 130,
                            margin: EdgeInsets.only(top: 20 ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.white , width: 1),
                                image: DecorationImage(
                                  image: NetworkImage(widget.info.data['link']),
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),


                  SizedBox(height: 30,),
                  // Here is the Banner Add
                  AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
                  SizedBox(height: 50,),


                  Center(
                    child: GestureDetector(
                      onTap: () async{
                        interstitialAd.show(
                          anchorType: AnchorType.bottom,
                          anchorOffset: 0.0,
                          horizontalCenterOffset: 0.0,
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: widget.info.data['trailer'])));
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 70 , vertical: 10),
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
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget password(DocumentSnapshot info) {
    if(info.data['p'] != "no" &&  info.data['p'] != null)
      {
        return Center(
          child: Row(
            children: [
              SizedBox(height: 70,),
              GestureDetector(
                onTap: ()=>()=>FlutterClipboard.copy(widget.info.data['p']),
                child: Container(
                  margin: EdgeInsets.only(left: 35),
                  //color: Colors.red,
                  child: Center(
                    child: Text("Press to copy Password",
                      style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w500 , color: Colors.red),),
                  ),
                ),
              ),

              IconButton(icon: Icon(Icons.content_copy), onPressed: ()=>FlutterClipboard.copy(widget.info.data['password']) , iconSize: 30, color: Colors.white,)
            ],
          ),
        );
      }
    else{
      return SizedBox(
        height: 5,
      );
    }
  }
}
