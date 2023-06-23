import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class NewsTicker extends StatefulWidget {
  @override
  _NewsTickerState createState() => _NewsTickerState();
}

class _NewsTickerState extends State<NewsTicker> {
  List<String> newsTickerTexts = [];
  int currentTextIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchNewsTickerTexts();
  }

  void fetchNewsTickerTexts() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('news_ticker')
        .doc('ticker_texts')
        .get();

    if (snapshot.exists) {
      setState(() {
        newsTickerTexts = List<String>.from(snapshot.data()['texts']);
      });

      startTicker();
    }
  }

  void startTicker() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        currentTextIndex = (currentTextIndex + 1) % newsTickerTexts.length;
      });

      startTicker();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: newsTickerTexts.isEmpty ? '' : newsTickerTexts[currentTextIndex],
      style: TextStyle(fontSize: 16),
      blankSpace: 20.0,
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      velocity: 100.0,
      pauseAfterRound: Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
      textDirection: TextDirection.ltr,
    );
  }
}
