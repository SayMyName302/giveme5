import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:giveme5/Episode_List_Page.dart';

class EpisodesDividedList extends StatefulWidget {

  final String seasonNoCheck;
  final String seasonNameCheck;
  final String imageLink;
  final String seasonNo;
  EpisodesDividedList({this.seasonNoCheck, this.seasonNameCheck , this.imageLink , this.seasonNo});


  @override
  _EpisodesDividedListState createState() => _EpisodesDividedListState();
}

class _EpisodesDividedListState extends State<EpisodesDividedList> {
  @override
  Widget build(BuildContext context) {

    Future getList(String seasonNoCheck , String seasonNameCheck) async {
      final firestore = Firestore.instance;
      if(seasonNameCheck == "Ertugrul Ghazi") {
        QuerySnapshot snapshot = await firestore.collection('ertugrulSeasonsList')
            .document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }
      else if(seasonNameCheck =="Krulus Osman")
      {
        QuerySnapshot snapshot = await firestore.collection('osmanSeasonList').document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }
      else if(seasonNameCheck =="Great Saljuks")
      {
        QuerySnapshot snapshot = await firestore.collection('saljuksSeasonList').document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }
      else if(seasonNameCheck == "Mehmetcik Kutul Amare")
      {
        QuerySnapshot snapshot = await firestore.collection('mehmetSeasonList').document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }
      else if(seasonNameCheck =="Barbaros")
      {
        QuerySnapshot snapshot = await firestore.collection('barbaroslarSeasonList').document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }
      else if(seasonNameCheck =="Destan")
      {
        QuerySnapshot snapshot = await firestore.collection('destanSeasonList').document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }
      else if(seasonNameCheck =="Mavera")
      {
        QuerySnapshot snapshot = await firestore.collection('maveraSeasonList').document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }
      else if(seasonNameCheck =="Celaluddin")
      {
        QuerySnapshot snapshot = await firestore.collection('celaluddinSeasonList').document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }
      else
      {
        QuerySnapshot snapshot = await firestore.collection('abdulHameedSeasonList').document(seasonNoCheck).collection('episodes')
            .getDocuments();
        return snapshot.documents;
      }

    }


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
              future: getList(widget.seasonNoCheck , widget.seasonNameCheck),
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeListPage(seasonNoCheck: widget.seasonNoCheck, seasonNameCheck: widget.seasonNameCheck, imageLink: widget.imageLink, seasonNo: widget.seasonNo , EpisodeListIndexNo: (index+1).toString())));
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
                                          snapshot.data[index].data['name'],
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 22,fontWeight: FontWeight.w600),)),
                                  ),
                                ],
                              ),
                            ),
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
}
