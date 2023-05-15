import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveme5/admob_service.dart';

class LatestPage extends StatefulWidget {
  @override
  _LatestPageState createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage>
    with AutomaticKeepAliveClientMixin{

  Future getData() async {
    final firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection('comingSoon')
        .getDocuments();
    return snapshot.documents;
  }


  @override
  void initState() {
    super.initState();
    Admob.initialize();
  }


  final ams = AdmobService();



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: null, //() => routeToDetail(snapshot.data[index]),
                        child: Container(
                          height: 150,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width - 30,
                                margin: EdgeInsets.only(top: 30.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey[900], width: 1),
                                  color: Colors.black,
                                  boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey[900],
                                  blurRadius: 10.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    4.0, // Move to right  horizontally
                                    4.0, // Move to bottom Vertically
                                  ),
                                )
                            ],
                                ),
                              ),
                              Container(
                                height: 130,
                                width: 100,
                                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.black.withOpacity(0.4),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index].data['imgLink']),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width - 180,
                                margin: EdgeInsets.only(top: 30.0 , left: 130.0 ,),
                                //color: Colors.yellow,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 190,
                                      margin: EdgeInsets.only(top: 10.0),
                                     //color: Colors.red,
                                      child: Text(snapshot.data[index].data['name'],
                                      style: TextStyle(color: Colors.white, fontSize: 19 , fontWeight: FontWeight.w500),),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          //border: Border.all(color: Colors.white, width: 1),
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.blue.withOpacity(0.7),
                                      ),
                                      child: Center(
                                        child: Text('Coming Soon',
                                        style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w300 , color: Colors.white),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if(snapshot.data.length > 10)...[
                        if(index % (snapshot.data.length / 3).toInt() == 0)...[
                          (index < 10) ?
                          // Here is the Banner Add
                          AdmobBanner(adUnitId: ams.getBannerAdId(),
                              adSize: AdmobBannerSize.BANNER)
                              :
                          AdmobBanner(adUnitId: ams.getBannerAdId(),
                              adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
                        ]
                      ]
                      else...[
                        if(index % 3 == 0)...[
                          (index < 7) ?
                          // Here is the Banner Add
                          AdmobBanner(adUnitId: ams.getBannerAdId(),
                              adSize: AdmobBannerSize.BANNER)
                              :
                          AdmobBanner(adUnitId: ams.getBannerAdId(),
                              adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
                        ]
                      ]
                    ],
                  );
                }
            );
          }
        },
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
