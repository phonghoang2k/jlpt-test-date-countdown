import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CarouselController buttonCarouselController = CarouselController();
  String time = "08/08/2020";
  int imageIndex = 0;
  List<AssetImage> imageAssetsLink = List<AssetImage>();

  List<Widget> numbers = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "1",
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Text(
          "Ngày",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "2",
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Text(
          "Ngày",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "3",
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Text(
          "Ngày",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "4",
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Text(
          "Ngày",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "5",
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Text(
          "Ngày",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "6",
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Text(
          "Ngày",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ],
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageAssetsLink = [
      AssetImage(
        "assets/meo1.jpg",
      ),
      AssetImage(
        "assets/meo2.jpg",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageAssetsLink[imageIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 20,
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add,color: Colors.white,))
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Column(
                    children: <Widget>[
                      Text(
                        "Đếm ngược ngày thi",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Kì thi THPT Quốc gia 2020",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  IconButton(
                      icon: Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          if (imageIndex < imageAssetsLink.length - 1) {
                            imageIndex++;
                          } else if (imageIndex == imageAssetsLink.length - 1) {
                            imageIndex = 0;
                          }
                        });
                      }),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "CÒN",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    CarouselSlider(
                      items: numbers,
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        aspectRatio: 2.0,
                        initialPage: 2,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.timer, color: Colors.white, size: 25),
                          SizedBox(width: 5),
                          Text(
                            "Ngày thi: $time",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chat,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    Text(
                      "Không làm mà đòi ăn, thì chỉ có ăn đầu buồi, ăn cứt",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
