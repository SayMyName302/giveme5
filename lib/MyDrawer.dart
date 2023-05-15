import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giveme5/AboutUs_Page.dart';
import 'package:giveme5/ContactUs_Page.dart';
import 'package:giveme5/PrivacyPolicy_Page.dart';
import 'package:share/share.dart';

class MyDrawer extends StatelessWidget {
  @override

  String playstoreLink = null;


  Future getData() async {
    final firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection('appPlaystoreLink').getDocuments();
    return snapshot.documents;
  }


  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 220.0,
                  height: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/GiveMe5.png'),
                    fit: BoxFit.fill,
                  )),
                  //backgroundImage: AssetImage('assets/GiveMe5.png',),
                ),
                Text(
                  'Pioneers of Urdu Subtitling',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),


                SizedBox(
                  height: 40.0,
                ),


                Text(
                  'www.giveme5tv.co',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'www.giveme5.co',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),



                SetTheLink(),



                Divider(
                  color: Colors.grey[400],
                ),



                ListTile(
                  contentPadding: EdgeInsets.only(left: 30),
                  onTap: () => share(context, getData()),
                  leading: Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                  title: Text('Share'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 30),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicyPage(filePath: 'files/privacypolicy.html',)));
                  },
                  leading: Icon(
                    Icons.assignment_outlined,
                    color: Colors.black,
                  ),
                  title: Text('Privacy Policy'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 30),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PrivacyPolicyPage(filePath: 'files/termsandcondition.html',)));
                  },
                  leading: Icon(
                    Icons.verified_user,
                    color: Colors.black,
                  ),
                  title: Text('Terms & Conditions'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 30),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutUsPage()));
                  },
                  leading: Icon(
                    Icons.info_outline,
                    color: Colors.black,
                  ),
                  title: Text('About Us'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 30),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactUsPage()));
                  },
                  leading: Icon(
                    Icons.contacts_outlined,
                    color: Colors.black,
                  ),
                  title: Text('Contact Us'),
                ),

                SizedBox(height: 40,),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Copyright © ${DateTime.now().year} GiveMe5',
                        style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  share(BuildContext context, Future info) {
    final RenderBox box = context.findRenderObject();

    Share.share(
      playstoreLink,
      subject: "Link of GiveMe5 App",
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }


  Widget SetTheLink() {
    return FutureBuilder(
        future: getData(),
        builder: (context , snapshot){
        //   playstoreLink = snapshot.data[0].data['link'];
        //   return Container(height: 0, width: 0,);
        // }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container();
        }
        else{
          playstoreLink = snapshot.data[0].data['link'];
           return Container();
           //return SizedBox(height: 0,);
        }
      },
    );
  }
}
