
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {

  int _current = 0;

  List imgList = [
    'https://static.wixstatic.com/media/742fdf_4386a8a127e240d1a3f78d19e7b4a070~mv2.jpg',
    'https://static.wixstatic.com/media/742fdf_96bd66f301174c4c97746af6b2d7ef3c~mv2.jpg',
    'https://static.wixstatic.com/media/742fdf_60959247c8ab40d58721619d478156c4~mv2.jpg',
    'https://static.wixstatic.com/media/742fdf_d32fc1af884f462d888405f49b84dc87~mv2.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CarouselSlider(
              initialPage: 0,
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 7),
              autoPlayAnimationDuration: Duration(seconds: 4),
              onPageChanged: (index){
                setState(() {
                  _current = index;
                });
              },
              items: imgList.map((imgUrl){
                return Builder(
                  builder: (BuildContext context){
                    return Container(
                      width: 300,
                      //width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        border: Border.all(
                            color: Colors.grey[600], width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(12.0),
                      //   child: CachedNetworkImage(
                      //     imageUrl: imgUrl,
                      //     imageBuilder: (context, imageProvider) => Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: imageProvider,
                      //             fit: BoxFit.fill,
                      //             ),
                      //       ),
                      //     ),
                      //     placeholder: (context, url) => CircularProgressIndicator(),
                      //     errorWidget: (context, url, error) => Icon(Icons.error),
                      //   ),
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: imgUrl==null?CircularProgressIndicator():Image.network(imgUrl,fit: BoxFit.fill,),
                      ),
                    );
                  },
                );
              }).toList(),
            )
          ],
        )
      ),
    );
  }
}
