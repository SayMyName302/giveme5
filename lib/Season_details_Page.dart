import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:giveme5/Episode_List_Page.dart';
import 'package:giveme5/episodes_Divided_List.dart';


class SeasonDetailsPage extends StatefulWidget {

  final String seasonDetailsList;
  final String imageLink;
  SeasonDetailsPage({this.seasonDetailsList , this.imageLink});

  @override
  _SeasonDetailsPageState createState() => _SeasonDetailsPageState();
}

class _SeasonDetailsPageState extends State<SeasonDetailsPage> {


  Future getList(String check) async {
    final firestore = Firestore.instance;
    if(check == "Ertugrul Ghazi"){
      QuerySnapshot snapshot = await firestore.collection('ertugrulSeasonsList')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check =="Krulus Osman")
    {
      QuerySnapshot snapshot = await firestore.collection('osmanSeasonList')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check =="Great Saljuks")
    {
      QuerySnapshot snapshot = await firestore.collection('saljuksSeasonList')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check =="Barbaros")
    {
      QuerySnapshot snapshot = await firestore.collection('barbaroslarSeasonList')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check =="Destan")
    {
      QuerySnapshot snapshot = await firestore.collection('destanSeasonList')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check =="Mavera")
    {
      QuerySnapshot snapshot = await firestore.collection('maveraSeasonList')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check =="Celaluddin")
    {
      QuerySnapshot snapshot = await firestore.collection('celaluddinSeasonList')
          .getDocuments();
      return snapshot.documents;
    }
    else if(check == "Mehmetcik Kutul Amare")
      {
        QuerySnapshot snapshot = await firestore.collection('mehmetSeasonList')
            .getDocuments();
        return snapshot.documents;
      }
    else
    {
      QuerySnapshot snapshot = await firestore.collection('abdulHameedSeasonList')
          .getDocuments();
      return snapshot.documents;
    }

  }



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
        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        //   },
        // ),
        centerTitle: true,
        title: Image.asset('assets/GiveMe5.png',width: 140, height: 140,),
        backgroundColor: Colors.black,
      ),

      body: FutureBuilder(
        future: getList(widget.seasonDetailsList),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () =>{Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodesDividedList(seasonNoCheck: (index+1).toString(), seasonNameCheck: widget.seasonDetailsList, imageLink: snapshot.data[index].data['imglink'], seasonNo: snapshot.data[index].data['seasonNo'],)))},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 210,
                      margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                              color: Colors.white, width: 1),
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data[index].data['imglink']),
                            fit: BoxFit.fill,
                          )
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.4),
                                ]
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(snapshot.data[index].data['seasonNo'],style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w600),),
                            SizedBox(height: 20.0,),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 70.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white,width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: Container(
                                height: 40,
                                width: 120,
                                child: Center(child: Text("Watch Now",style: TextStyle(color: Colors.white),)),
                              ),
                            ),
                            SizedBox(height: 50.0,),
                          ],
                        ),
                      ),
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
