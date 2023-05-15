

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:giveme5/Episode_Details_Page.dart';
import 'package:giveme5/admob_service.dart';

class EpisodeListPage extends StatefulWidget {

  final String seasonNoCheck;
  final String seasonNameCheck;
  final String imageLink;
  final String seasonNo;
  final String EpisodeListIndexNo;
  int episodeNo;
  EpisodeListPage({this.seasonNoCheck, this.seasonNameCheck , this.imageLink , this.seasonNo , this.EpisodeListIndexNo});

  @override
  _EpisodeListPageState createState() => _EpisodeListPageState();
}

class _EpisodeListPageState extends State<EpisodeListPage>
    with AutomaticKeepAliveClientMixin{


  @override
  void initState() {
    super.initState();
    Admob.initialize();
  }


  final ams = AdmobService();




  Future getList(String seasonNoCheck , String seasonNameCheck , String EpisodeListIndexNo) async {
    final firestore = Firestore.instance;
    String episodeCheck;

    if(EpisodeListIndexNo == '1'){
      episodeCheck = 'episodes1-10';
      widget.episodeNo = 1;
    }
    else if(EpisodeListIndexNo == '2'){
      episodeCheck = 'episodes11-20';
      widget.episodeNo = 11;
    }
    else if(EpisodeListIndexNo == '3'){
      episodeCheck = 'episodes21-30';
      widget.episodeNo = 21;
    }
    else if(EpisodeListIndexNo == '4'){
      episodeCheck = 'episodes31-40';
      widget.episodeNo = 31;
    }
    else if(EpisodeListIndexNo == '5'){
      episodeCheck = 'episodes41-50';
      widget.episodeNo = 41;
    }
    else if(EpisodeListIndexNo == '6'){
      episodeCheck = 'episodes51-60';
      widget.episodeNo = 51;
    }
    else if(EpisodeListIndexNo == '7'){
      episodeCheck = 'episodes61-70';
      widget.episodeNo = 61;
    }
    else if(EpisodeListIndexNo == '8'){
      episodeCheck = 'episodes71-80';
      widget.episodeNo = 71;
    }
    else if(EpisodeListIndexNo == '9'){
      episodeCheck = 'episodes81-90';
      widget.episodeNo = 81;
    }
    else if(EpisodeListIndexNo == '10'){
      episodeCheck = 'episodes91-100';
      widget.episodeNo = 91;
    }
    else if(EpisodeListIndexNo == '11'){
      episodeCheck = 'episodes101-110';
      widget.episodeNo = 101;
    }
    else if(EpisodeListIndexNo == '12'){
      episodeCheck = 'episodes111-120';
      widget.episodeNo = 111;
    }
    else if(EpisodeListIndexNo == '13'){
      episodeCheck = 'episodes121-130';
      widget.episodeNo = 121;
    }
    else if(EpisodeListIndexNo == '14'){
      episodeCheck = 'episodes131-140';
      widget.episodeNo = 131;
    }
    else if(EpisodeListIndexNo == '15'){
      episodeCheck = 'episodes141-150';
      widget.episodeNo = 141;
    }


    if(seasonNameCheck == "Ertugrul Ghazi") {
      QuerySnapshot snapshot = await firestore.collection('ertugrulSeasonsList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck).collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }
    else if(seasonNameCheck =="Krulus Osman")
    {
      QuerySnapshot snapshot = await firestore.collection('osmanSeasonList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck).collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }
    else if(seasonNameCheck =="Great Saljuks")
    {
      QuerySnapshot snapshot = await firestore.collection('saljuksSeasonList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck).collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }
    else if(seasonNameCheck == "Mehmetcik Kutul Amare")
    {
      QuerySnapshot snapshot = await firestore.collection('mehmetSeasonList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck). collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }
    else if(seasonNameCheck == "Barbaros")        // yahan say lay kar
    {
      QuerySnapshot snapshot = await firestore.collection('barbaroslarSeasonList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck).collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }


    else if(seasonNameCheck == "Destan")        // yahan say lay kar
        {
      QuerySnapshot snapshot = await firestore.collection('destanSeasonList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck).collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }

    else if(seasonNameCheck == "Mavera")        // yahan say lay kar
        {
      QuerySnapshot snapshot = await firestore.collection('maveraSeasonList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck).collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }
    else if(seasonNameCheck == "Celaluddin")        // yahan say lay kar
        {
      QuerySnapshot snapshot = await firestore.collection('celaluddinSeasonList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck).collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }  // Yahan taq copy paste karna hA
    else
    {
      QuerySnapshot snapshot = await firestore.collection('abdulHameedSeasonList').document(seasonNoCheck).collection('episodes')
          .document(episodeCheck).collection('episodes')
          .getDocuments();
      return snapshot.documents;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonDetailsPage()));
        //   },
        // ),
        actions: [
          TextButton.icon(onPressed:(){
            Phoenix.rebirth(context);
          }, icon: Icon(Icons.refresh), label: Text(''),)
        ],
        centerTitle: true,
        title: Image.asset('assets/GiveMe5.png',width: 140, height: 140,),
        backgroundColor: Colors.black,
      ),

      body: Column(
        children: [
          Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    color: Colors.white, width: 1),
                image: DecorationImage(
                  image: NetworkImage(widget.imageLink),
                  fit: BoxFit.fill,
                )
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                      ]
                  )
              ),



              // TEXT of Season Header
              child: Center(
                child: Text(widget.seasonNo.toString(),style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w600),),
              ),
            ),
          ),



          //  Container for Seasons List
          Container(
            height: MediaQuery.of(context).size.height - 280,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: getList(widget.seasonNoCheck , widget.seasonNameCheck , widget.EpisodeListIndexNo),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index){
                        return Column(
                          children: [
                            if(index == 0)...[
                              // Here is the Bara Banner Add
                              AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.MEDIUM_RECTANGLE)
                            ],
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black.withOpacity(0.4),
                              ),
                              child: Row(
                                children: [

                                  // PLAY BUTTTON

                                  Container(
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.only(left: 25.0),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[700],
                                            blurRadius: 4.0, // soften the shadow
                                            spreadRadius: 1.0, //extend the shadow
                                            offset: Offset(
                                              2.0, // Move to right 10  horizontally
                                              2.0, // Move to bottom 10 Vertically
                                            ),
                                          )]
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(Icons.play_arrow, size: 34, color: Colors.white,),
                                        onPressed: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeDetailsPage((widget.episodeNo.toInt()+index).toString() , snapshot.data[index].data['il'].toString(), snapshot.data[index].data['description'].toString() , snapshot.data[index].data['link'].toString(),snapshot.data[index].data['p'].toString())));
                                        },
                                      ),
                                    ),
                                  ),

                                  // EPISODE NUMBER TEXT
                                  Container(
                                    height: 70,
                                    width: MediaQuery.of(context).size.width - 180,
                                    //color: Colors.red,
                                    child: Center(
                                        child: Text(
                                          "Episode no ${widget.episodeNo.toInt()+index}",
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 22,fontWeight: FontWeight.w600),)),
                                  ),
                                ],
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
                                (index < 5) ?
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
          ),
        ],
      ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
