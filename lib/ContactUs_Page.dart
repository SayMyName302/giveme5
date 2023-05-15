import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ContactUsPage extends StatelessWidget {
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
        centerTitle: true,
        title: Image.asset('assets/GiveMe5.png',width: 140, height: 140,),
        backgroundColor: Colors.black,
        actions: [
          TextButton.icon(onPressed:(){
            Phoenix.rebirth(context);
          }, icon: Icon(Icons.refresh), label: Text(''),)
        ],
      ),

      body: Column(
        children: [
          Spacer(),

          BuildLinkText('hellogiveme5@gmail.com' , 18),
          Spacer(),
          BuildLinkText('fb.me/HiGiveMe5', 18),
          Spacer(),
          BuildLinkText('instagram.com/giveme5dotco/', 18),
          Spacer(),
          BuildLinkText('twitter.com/higiveme5', 18),
          Spacer(),
          BuildLinkText('youtube.com/giveme5co', 18),
          Spacer(),
          Spacer(),
          BuildLinkText('Donate us : Easypaisa' ,18),
          SizedBox(height: 5,),
          BuildLinkText('03355379937', 24),

        ],
      ),
    );
  }

  Widget BuildLinkText(String text , double size) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: size,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

  Widget Spacer(){
    return Divider(
      height: 30,
    );
  }
}
