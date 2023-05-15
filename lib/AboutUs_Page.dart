import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
        //title: Image.asset('assets/GiveMe5.png',width: 140, height: 140,),
        backgroundColor: Colors.black,
        actions: [
          TextButton.icon(onPressed:(){
            Phoenix.rebirth(context);
          }, icon: Icon(Icons.refresh), label: Text(''),)
        ],
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [

            // GiveMe5 LOGO
            Container(
              width: MediaQuery.of(context).size.width,
              height: 65,
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                    image: AssetImage('assets/GiveMe5.png',),
                    fit: BoxFit.fill,
                  )
              ),
            ),

            SizedBox(height: 10,),

            // Urdu Text Container
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              //color: Colors.blue,
              child: Center(
                child: Text('ناظرین کو اطلاع دی جاتی ہے کہ اس ویب سائٹ کے علاوہ ہماری کوئی ویب سائٹ نہیں۔\nآپ سے درخواست کی جاتی ہے کہ جو لوگ ہمارا نام اور مواد چوری کررہے ہیں ، ان کا بائیکاٹ کریں۔اور تمام اقساط ہماری ویب سائٹ پر دیکھیں۔\nتاکہ ہماری محنت کا معاوضہ ہمیں مل سکے اور ہم اس کام کو بہتر طور پر جاری رکھ سکیں۔ شکریہ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400 , color: Colors.white ),textAlign: TextAlign.center,),
              ),
            ),


            Divider(color: Colors.grey[600],),

            // Developed By
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              //color: Colors.blue,
              child: Center(
                child: Text('About Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400 , color: Colors.white ),textAlign: TextAlign.center,),
              ),
            ),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              //color: Colors.red,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome to GiveMe5, your number one source for watching different series, Films, and short interviews with Urdu Subtitles. We\'re dedicated to providing you the very best of Urdu Subtitles, with a meaningful and understandable word selection.'
                  '\n\nFounded in 2017 by Sheraz Haider Malik, GiveMe5 has come a long way from its beginnings in Islamabad. When Sheraz Haider Malik first started out, his passion for "Pioneers of Urdu Subtitling" drove them to start their own business.'
                  '\n\nWe have built a wonderful and expert team for all the fields of Social Media. Here we can mention some main Team Members of GiveMe5',
                  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w300 , color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            SizedBox(height: 10,),

            Divider(color: Colors.grey[600],),

            SizedBox(height: 10,),
            // Developed By
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              //color: Colors.blue,
              child: Center(
                child: Text('GiveMe5 Team',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400 , color: Colors.white ),textAlign: TextAlign.center,),
              ),
            ),

            SizedBox(height: 10,),

            memberName('Sheraz Haider Malik (The Founder of GiveMe5)'),
            memberDetails('He is an experienced Video Editor and Director since 2001. He has a vast vision of understanding the drama\'s dialogues because of his close contact with video while editing.'),

            memberName('\nSaqib Shahzad (Non-Linear Editor and Administrator)'),
            memberDetails('He is also an experienced Editor and also taking the administrative responsibilities of the company. He is a very energetic and hardworking member of The Team.'),

            memberName('\nSameer Gul (Software Developer and Translator)'),
            memberDetails('Sameer has the honor of the first employee of GiveMe5 as a software developer and he also gives us his services for Urdu Translation. This App is also built by Sameer who has done a wonderful job of designing and developing this App for the company and the audience. He is also a very dedicated and Hardowork member of our team family.'),

            memberName('\nUmair Mirza (Translator and Video Editor)'),
            memberDetails('He is a very hard-working and dedicated person on our team. He has translated some of our Episodes of different series. He is a young and energetic member of our team.'),

            memberName('\nAwais Mubashir (Developer and Translator)'),
            memberDetails('Awais is also a software developer. He has the honor of building the first App of GiveMe5 with his full devotion and experience. He is also a good translater and provides his services for some series and films.'),

            memberDetails('We hope you enjoy our Translation as much as we enjoy translating them for you. If you have any questions or comments, please don\'t hesitate to contact us.'),


            SizedBox(height: 20,),

            Divider(color: Colors.grey[400],),

            // CopyRight Text
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              //color: Colors.blue,
              child: Center(
                child: Text('Copyright © ${DateTime.now().year} GiveMe5. All rights reserved',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 , color: Colors.white ),textAlign: TextAlign.center,),
              ),
            ),



          ],
        ),
      ),
    );
  }

  Widget memberDetails(String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      //color: Colors.red,
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w300 , color: Colors.white),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget memberName(String name) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          name,
          style: TextStyle(fontSize: 17 , fontWeight: FontWeight.w700 , color: Colors.white),
        ),
      ),
    );
  }


}
