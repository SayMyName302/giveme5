
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:giveme5/Home_Page.dart';
import 'package:giveme5/Latest_Page.dart';
import 'package:giveme5/AllPages.dart';
import 'package:giveme5/MyDrawer.dart';
import 'package:giveme5/Splash_Screen.dart';
import 'package:giveme5/admob_service.dart';

// void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: SplashScreen(),
// ));

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdmobService().getAdMobAppId());
  runApp(Phoenix(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  ));
}


class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screen = [
    HomePage(),AllPage(),LatestPage()
  ];

  void _onPageChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex){
    //_pageController.jumpToPage(selectedIndex);
    _pageController.animateToPage(selectedIndex, duration: Duration(milliseconds: 600), curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(onPressed:(){
            Phoenix.rebirth(context);
          }, icon: Icon(Icons.refresh), label: Text(''),)
        ],
        centerTitle: true,
        title: Image.asset('assets/GiveMe5.png',width: 140, height: 140,),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _screen,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: _currentIndex == 0 ? Colors.red[700] : Colors.blue,),
              label: "Home",
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.widgets_outlined,color: _currentIndex == 1 ? Colors.red[700] : Colors.blue,),
              label: "All",
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.whatshot_rounded,color: _currentIndex == 2 ? Colors.red[700] : Colors.blue,),
              label: "Updates",
              backgroundColor: Colors.black
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
