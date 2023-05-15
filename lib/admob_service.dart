import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';



class AdmobService{

String getAdMobAppId(){
  if(Platform.isIOS){
    return 'IOS AppId from the Admob';
  }
  else if(Platform.isAndroid) {
    return 'ca-app-pub-4175485348048619~9314233724';   // NEW APP ID
  }
  return null;
}


String getBannerAdId(){
  if(Platform.isIOS){
    return 'Banner Add Id for IOS';
  }
  else if(Platform.isAndroid) {
    return 'ca-app-pub-4175485348048619/4341108647';    // NEW add ID

    //return 'ca-app-pub-3940256099942544/6300978111';   // Test add ID
  }
  return null;
}

String getInterstitialAdId(){
  if(Platform.isIOS){
    return 'Interstitial Ads Id for IOS';
  }
  else if(Platform.isAndroid) {
    return 'ca-app-pub-4175485348048619/1034975377';    // Orignal add ID

    //return 'ca-app-pub-3940256099942544/1033173712';   // Test add ID
  }
  return null;
}


InterstitialAd showInterstitialAd(){
  return InterstitialAd(
    adUnitId: getInterstitialAdId(),
    listener: (MobileAdEvent event){
      print("Interstitial event is $event");
    },
  );
}



}