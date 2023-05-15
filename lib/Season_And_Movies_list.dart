import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:giveme5/DetailPage.dart';
import 'package:giveme5/Season_details_Page.dart';


class SeasonAndMoviesListPage extends StatefulWidget {

  final String moviesORseasons;
  SeasonAndMoviesListPage({this.moviesORseasons });

  @override
  _SeasonAndMoviesListPageState createState() => _SeasonAndMoviesListPageState();
}

class _SeasonAndMoviesListPageState extends State<SeasonAndMoviesListPage> {


  Future getList(String check) async {
    final firestore = Firestore.instance;
    if(check == "seasons"){
      QuerySnapshot snapshot = await firestore.collection('seasonlist')
          .getDocuments();
      return snapshot.documents;
    }
    else
      {
        QuerySnapshot snapshot = await firestore.collection('movies')
            .getDocuments();
        return snapshot.documents;
      }
  }

  NavigateToDetailsPage(String check,final DocumentSnapshot info , String name)
  {
    if(check == "seasons"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonDetailsPage(seasonDetailsList: name, imageLink: info.data['link'],)));
    }
    else
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(info , "movies")));
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
        future: getList(widget.moviesORseasons),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => NavigateToDetailsPage(widget.moviesORseasons , snapshot.data[index] , snapshot.data[index].data['name']), //() => routeToDetail(snapshot.data[index]),
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
                                  blurRadius: 20.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    4.0, // Move to right 10  horizontally
                                    4.0, // Move to bottom 10 Vertically
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
                                      snapshot.data[index].data['link']),
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
                                  height: 28,
                                  width: 190,
                                  margin: EdgeInsets.only(top: 10.0),
                                  //color: Colors.red,
                                  child: Text(snapshot.data[index].data['name'],
                                    style: TextStyle(color: Colors.white, fontSize: 22 , fontWeight: FontWeight.bold),),
                                ),
                                Container(
                                  height: 62,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    //border: Border.all(color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                    //color: Colors.blue.withOpacity(0.7),
                                  ),
                                  child: Center(
                                    child: Text(snapshot.data[index].data['description'],
                                      style: TextStyle(fontSize: 11 , fontWeight: FontWeight.w300 , color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
