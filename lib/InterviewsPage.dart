import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:giveme5/WebView.dart';
import 'package:giveme5/admob_service.dart';

class interviewPage extends StatefulWidget {

  final String check;
  interviewPage({this.check});

  @override
  _interviewPageState createState() => _interviewPageState();
}

class _interviewPageState extends State<interviewPage> {

  final ams = AdmobService();


  @override
  void initState() {
    super.initState();
    Admob.initialize();
  }


  Future getList(String check) async {
    final firestore = Firestore.instance;
    if(check == "trailer"){
      QuerySnapshot snapshot = await firestore.collection('trailers')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check == "interviews")
    {
      QuerySnapshot snapshot = await firestore.collection('interviews')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check == "latestShorts")
    {
      QuerySnapshot snapshot = await firestore.collection('latestShortClips').orderBy("timeStamp", descending: true).getDocuments();
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
        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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



      body: FutureBuilder(
        future: getList(widget.check),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => null,//NavigateToDetailsPage(widget.moviesORseasons , snapshot.data[index] , snapshot.data[index].data['name']), //() => routeToDetail(snapshot.data[index]),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          //color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 150,
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(videoData: snapshot.data[index].data['link'])));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                              // TEXT
                              Container(
                                height: 100,
                                width: 180,
                                //color: Colors.red,
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(snapshot.data[index].data['name'] , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: Colors.white),),
                                )),
                              ),

                            ],
                          ),
                        ),

                        Divider(
                          color: Colors.grey.withOpacity(0.3),
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
                    ),
                  );
                }
            );
          }
        },
      ),


    );
  }
}
