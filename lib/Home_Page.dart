import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giveme5/DetailPage.dart';
import 'package:giveme5/Episode_Details_Page.dart';
import 'package:giveme5/InterviewsPage.dart';
import 'package:giveme5/MySlider.dart';
import 'package:giveme5/Season_details_Page.dart';
import 'package:giveme5/WebView.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'admob_service.dart';


class info{

  final String link;
  final String description;

  info(this.link , this.description);
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin{


  final ams = AdmobService();


  @override
  void initState() {
    super.initState();
    Admob.initialize();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    InterstitialAd interstitialAd = ams.showInterstitialAd();
    interstitialAd.load();

    Future getData() async {
      final firestore = Firestore.instance;
      QuerySnapshot snapshot = await firestore.collection('latest').getDocuments();
      return snapshot.documents;
    }

    Future getLatestShortClips() async {
      final firestore = Firestore.instance;
      QuerySnapshot latestShortClips = await firestore.collection("latestShortClips").where("isLatest", isGreaterThan: 0).orderBy("isLatest", descending: true).getDocuments();
      return latestShortClips.documents;
    }

    Future getMovies() async {
      final firestore = Firestore.instance;
      QuerySnapshot moviesList = await firestore.collection('movies').getDocuments();    // "moviesList" data ko access krnay kay liay ha...
      return moviesList.documents;
    }

    Future getTrailers() async {
      final firestore = Firestore.instance;
      QuerySnapshot trailersList = await firestore.collection('latestTrailers').getDocuments();
      return trailersList.documents;
    }

    Future getInterviews() async {
      final firestore = Firestore.instance;
      QuerySnapshot trailersList = await firestore.collection('latestInterviews').getDocuments();
      return trailersList.documents;
    }

    Future getSeasonList() async {
      final firestore = Firestore.instance;
      QuerySnapshot trailersList = await firestore.collection('seasonlist').getDocuments();
      return trailersList.documents;
    }

    routeToDetail(DocumentSnapshot info , String listName){
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(info , listName)));
    }

    Widget DividerLine(){
      return Divider(
        color: Colors.grey.withOpacity(0.5),
      );
    }


    Widget Heading(String text){
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              text, style: TextStyle(fontSize: 22 , color: Colors.white , fontWeight: FontWeight.w600),
            )
        ),
      );
    }


    return Scaffold(
        backgroundColor: Colors.grey[900],
        drawerScrimColor: Colors.grey[900],

      body: Container(
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.start,
          child: Column(
          children: [


            MySlider(),


            DividerLine(),



            // Here is the Banner Add
            AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.BANNER),



            Heading('Latest'),

            //  This is For Generating Latest List
            ///////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 230,
                //color: Colors.red,
                child: FutureBuilder(
                  future: getData(),
                  builder: (context , snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_,index){
                            return GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeDetailsPage(snapshot.data[index].data['episodeNo'].toString() , snapshot.data[index].data['il'].toString(), snapshot.data[index].data['description'].toString() , snapshot.data[index].data['link'].toString() , snapshot.data[index].data['p'].toString()))),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: "latest${snapshot.data[index].data['name']}",
                                        child: Container(
                                            height: 170,
                                            width: 240,
                                          margin: EdgeInsets.only(left: 8, top: 6 , right: 5 , bottom: 4),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white, width: 1),
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.black.withOpacity(0.4),
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot.data[index].data['il']),
                                                fit: BoxFit.fill,
                                              )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: Container(
                                          width: 110,
                                          height: 50,
                                          //color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              snapshot.data[index].data['name'],style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 , color: Colors.white ),textAlign: TextAlign.center,
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  },
                ),
              ),
            ),


            DividerLine(),
            // Here is the Bara Banner Add
            AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
            DividerLine(),
            Heading('Movies'),

            //  This is For Generating Movies List
            ///////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 180,
                //color: Colors.red,
                child: FutureBuilder(
                  future: getMovies(),
                  builder: (context , moviesList){
                    if(moviesList.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: moviesList.data.length,
                          itemBuilder: (_,index){
                            return GestureDetector(
                              onTap: () => routeToDetail(moviesList.data[index] , "movies"),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: "movies${moviesList.data[index].data['name']}",
                                        //tag: snapshot.toString(),
                                        child: Container(
                                          height: 140,
                                          width: 105,
                                          margin: EdgeInsets.only(left: 8, top: 6 , right: 5 , bottom: 4),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white, width: 1),
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.black.withOpacity(0.4),
                                              image: DecorationImage(
                                                image: NetworkImage(moviesList.data[index].data['link']),
                                                fit: BoxFit.fill,
                                              )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: Container(
                                          width: 110,
                                          height: 30,
                                          //color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              moviesList.data[index].data['name'],style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 , color: Colors.white),
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  },
                ),
              ),
            ),


            DividerLine(),

            // This is for TEXT of Trailer Cards slider
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //color: Colors.red,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Latest Shorts', style: TextStyle(fontSize: 22 , color: Colors.white , fontWeight: FontWeight.w600),
                      )
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => interviewPage(check: 'latestShorts',)));},
                    child: Container(
                      width: 60,
                      height: 30,
                      //color: Colors.yellow,
                      margin: EdgeInsets.only(right: 10),
                      child: Center(
                        child: Text(
                          'More >' , style: TextStyle(fontSize: 16 , color: Colors.blue , fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //  This is For Generating Movies List
            ///////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 210,
                //color: Colors.red,
                child: FutureBuilder(
                  future: getLatestShortClips(),
                  builder: (context , latestShortClips){
                    if(latestShortClips.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: latestShortClips.data.length,
                          itemBuilder: (_,index){
                            return GestureDetector(
                              onTap: () {
                                interstitialAd.show(
                                  anchorType: AnchorType.bottom,
                                  anchorOffset: 0.0,
                                  horizontalCenterOffset: 0.0,
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: latestShortClips.data[index].data['link'])));
                              },


                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 180,
                                        margin: EdgeInsets.only(left: 8, top: 6 , right: 5 , bottom: 4),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white, width: 1),
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.black.withOpacity(0.4),
                                            image: DecorationImage(
                                              image: NetworkImage(latestShortClips.data[index].data['imagelink']),
                                              fit: BoxFit.fill,
                                            )
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(1),
                                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                            ),

                                            // PLAY triangle white
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(Icons.play_arrow, size: 26, color: Colors.white,),
                                                onPressed: (){
                                                  interstitialAd.show(
                                                    anchorType: AnchorType.bottom,
                                                    anchorOffset: 0.0,
                                                    horizontalCenterOffset: 0.0,
                                                  );
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: latestShortClips.data[index].data['link'])));
                                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: snapshot.data[index].data['link'])));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: Container(
                                          width: 150,
                                          height: 50,
                                          //color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              latestShortClips.data[index].data['name'],style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 , color: Colors.white ),textAlign: TextAlign.center,
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  },
                ),
              ),
            ),


            DividerLine(),




            // Here is the Bara Banner Add
            AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
            DividerLine(),






            //  This is For Generating Series List
            ///////////////////////////////////////////////////////////////
            Heading('Series'),


            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 190,
                //color: Colors.red,
                child: FutureBuilder(
                  future: getSeasonList(),
                  builder: (context , snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_,index){
                            return GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonDetailsPage(seasonDetailsList: snapshot.data[index].data['name'], imageLink: snapshot.data[index].data['link'],))),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: "latest${snapshot.data[index].data['name']}",
                                        child: Container(
                                          height: 140,
                                          width: 105,
                                          margin: EdgeInsets.only(left: 8, top: 6 , right: 5 , bottom: 4),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white, width: 1),
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.black.withOpacity(0.4),
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot.data[index].data['link']),
                                                fit: BoxFit.fill,
                                              )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: Container(
                                          width: 110,
                                          height: 30,
                                          //color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              snapshot.data[index].data['name'],style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 , color: Colors.white ),textAlign: TextAlign.center,
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  },
                ),
              ),
            ),


            DividerLine(),





            // This is for TEXT of Trailer Cards slider
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //color: Colors.red,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Latest Trailers', style: TextStyle(fontSize: 20 , color: Colors.white , fontWeight: FontWeight.w600),
                      )
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => interviewPage(check: 'trailer',)));},
                    child: Container(
                      width: 60,
                      height: 30,
                      //color: Colors.yellow,
                      margin: EdgeInsets.only(right: 10),
                      child: Center(
                        child: Text(
                          'More >' , style: TextStyle(fontSize: 16 , color: Colors.blue , fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            //  This is For Generating Trailer Cards slider
            ///////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 220,
                //color: Colors.red,
                child: FutureBuilder(
                  future: getTrailers(),
                  builder: (context , snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_,index){
                            return GestureDetector(
                              onTap: (){
                                interstitialAd.show(
                                  anchorType: AnchorType.bottom,
                                  anchorOffset: 0.0,
                                  horizontalCenterOffset: 0.0,
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: snapshot.data[index].data['link'])));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 170,
                                        width: 240,
                                        margin: EdgeInsets.only(left: 8, top: 6 , right: 5 , bottom: 4),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white, width: 1),
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.black.withOpacity(0.4),
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot.data[index].data['imagelink']),
                                              fit: BoxFit.fill,
                                            )
                                        ),


                                        // Background of the play triangle
                                        child: Center(
                                          child: Container(
                                            height: 55,
                                            width: 55,
                                            decoration: BoxDecoration(
                                                color: Colors.red.withOpacity(1),
                                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                            ),

                                            // PLAY triangle white
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(Icons.play_arrow, size: 34, color: Colors.white,),
                                                onPressed: (){
                                                  interstitialAd.show(
                                                    anchorType: AnchorType.bottom,
                                                    anchorOffset: 0.0,
                                                    horizontalCenterOffset: 0.0,
                                                  );
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: snapshot.data[index].data['link'])));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(child: Text(snapshot.data[index].data['name'],style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 , color: Colors.white),)),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  },
                ),
              ),
            ),




            DividerLine(),



            // Here is the Banner Add
            AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.BANNER),







            //  This is For Generating Latest Interviews list
            ///////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20 ,bottom: 10),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //color: Colors.red,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Latest Interviews', style: TextStyle(fontSize: 20 , color: Colors.white , fontWeight: FontWeight.w600),
                          )
                      ),

                      GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => interviewPage(check: 'interview',)));},
                        child: Container(
                          width: 60,
                          height: 30,
                          //color: Colors.yellow,
                          margin: EdgeInsets.only(right: 10),
                          child: Center(
                            child: Text(
                              'More >' , style: TextStyle(fontSize: 16 , color: Colors.blue , fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 210,
                //color: Colors.red,
                child: FutureBuilder(
                  future: getInterviews(),
                  builder: (context , snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_,index){
                            return GestureDetector(
                              onTap: () {
                                interstitialAd.show(
                                  anchorType: AnchorType.bottom,
                                  anchorOffset: 0.0,
                                  horizontalCenterOffset: 0.0,
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: snapshot.data[index].data['link'])));
                              },


                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 180,
                                        margin: EdgeInsets.only(left: 8, top: 6 , right: 5 , bottom: 4),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white, width: 1),
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.black.withOpacity(0.4),
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot.data[index].data['imagelink']),
                                              fit: BoxFit.fill,
                                            )
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(1),
                                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                            ),

                                            // PLAY triangle white
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(Icons.play_arrow, size: 26, color: Colors.white,),
                                                onPressed: (){
                                                  interstitialAd.show(
                                                    anchorType: AnchorType.bottom,
                                                    anchorOffset: 0.0,
                                                    horizontalCenterOffset: 0.0,
                                                  );
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: snapshot.data[index].data['link'])));
                                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: snapshot.data[index].data['link'])));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: Container(
                                          width: 150,
                                          height: 50,
                                          //color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              snapshot.data[index].data['name'],style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 , color: Colors.white ),textAlign: TextAlign.center,
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
