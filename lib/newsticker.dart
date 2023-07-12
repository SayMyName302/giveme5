import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> marqueeTexts = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      DocumentReference documentRef =
      Firestore.instance.collection('news_ticker').document('ticker_texts');
      DocumentSnapshot snapshot = await documentRef.get();

      List<String> texts = List<String>.from(snapshot.data['texts']);

      setState(() {
        marqueeTexts = texts;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildComplexMarquee(),
      ].map(_wrapWithStuff).toList(),
    );
  }

  Widget _buildComplexMarquee() {
    return isLoading
        ? Center(child: Container(
        height:20,width:20,

        child: CircularProgressIndicator())) // Show loading indicator


        : Marquee(
      text: marqueeTexts.join('  🗡  '),
      style: TextStyle(
        fontSize: 18.5,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      textDirection: TextDirection.rtl,
      velocity: 50.0,
      pauseAfterRound: Duration(seconds: 3),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }

  Widget _wrapWithStuff(Widget child) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(height: 40.0, child: child),
    );
  }
}
