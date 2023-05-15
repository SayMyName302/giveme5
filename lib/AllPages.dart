import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveme5/InterviewsPage.dart';
import 'package:giveme5/Season_And_Movies_list.dart';
import 'package:giveme5/admob_service.dart';


class AllPage extends StatefulWidget {
  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllPage>
    with AutomaticKeepAliveClientMixin{


  final ams = AdmobService();
  @override
  void initState() {
    super.initState();
    Admob.initialize();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children:<Widget> [


              // Here is the Banner Add
              AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.BANNER),
              SizedBox(height: 10.0,),


              BuildWindow('Turkish Seasons', 'https://static.wixstatic.com/media/742fdf_96bd66f301174c4c97746af6b2d7ef3c~mv2.jpg'),

              SizedBox(height: 20,),

              BuildWindow('Turkish Movies', 'https://static.wixstatic.com/media/742fdf_9c71f43f08c246deae5ae1dcec4bb94d~mv2.jpg'),

              SizedBox(height: 20,),

              // Here is the Banner Add
              AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.MEDIUM_RECTANGLE),

              SizedBox(height: 20,),

              BuildWindow('Interviews', 'https://i.ytimg.com/vi/btkG7t6L1Jw/maxresdefault.jpg'),

              SizedBox(height: 20,),

              BuildWindow('Trailers', 'https://i.ytimg.com/vi/Jww62gd_FSY/maxresdefault.jpg'),

              SizedBox(height: 20.0,),

              // Here is the Banner Add
              AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
            ],
          ),
        ),
      ),
    );
  }





  Widget BuildWindow(String check , String imgLink){
    return GestureDetector(
      onTap: (){
        if(check == 'Turkish Seasons'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonAndMoviesListPage(moviesORseasons: "seasons",)));
      }
        else if(check == 'Turkish Movies'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonAndMoviesListPage(moviesORseasons: "movies",)));
        }
        else if(check == 'Interviews'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => interviewPage(check: 'interview',)));
        }
        else if(check == 'Trailers'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => interviewPage(check: 'trailer',)));
        }
        },
      child: Container(
        width: double.infinity,
        height: 210,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: DecorationImage(
              image: NetworkImage(imgLink),
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
              Text(check,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w600),),
              SizedBox(height: 20.0,),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 70.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black.withOpacity(0.5),
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
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
