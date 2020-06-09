import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/settings/configuration.dart';
import 'package:jlpt_testdate_countdown/settings/sizeconfig.dart';
import 'package:jlpt_testdate_countdown/src/blocs/clicking/bloc.dart';
import 'package:jlpt_testdate_countdown/src/blocs/counting/bloc.dart';
import 'package:jlpt_testdate_countdown/src/models/date.dart';
import 'package:jlpt_testdate_countdown/src/views/screens/detailscountdown.dart';
import 'package:jlpt_testdate_countdown/src/views/screens/recordermessage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CarouselController buttonCarouselController = CarouselController();
  Timer timer;

  @override
  void initState() {
    super.initState();
    loadCountTime(context);
    loadNewBackgroundImage(context);
    loadNewQuote(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(children: <Widget>[
        BlocBuilder<OnclickBloc, OnclickState>(
          condition: (previousState, state) {
            return state is BackgroundLoaded;
          },
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Config.imageAssetsLink[Config.imageIndex],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height - 20,
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ))),
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
                        loadNewBackgroundImage(context);
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
                    GestureDetector(
                      child: BlocBuilder<CountBloc, CountState>(
                        builder: (context, state) {
                          if (state is CountLoaded) {
                            return buildCarouselSlider(context, state.date);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                      value:
                                          BlocProvider.of<CountBloc>(context),
                                      child: DetailCountDown(),
                                    )));
                      },
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.timer, color: Colors.white, size: 25),
                          SizedBox(width: 5),
                          Text(
                            "Ngày thi: ${formatVietnameseDateStyle(Config.testDate)}",
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
                      onPressed: () {
                        loadNewQuote(context);
                      },
                    ),
                    BlocBuilder<OnclickBloc, OnclickState>(
                      condition: (previousState, state) {
                        return state is QuoteLoaded;
                      },
                      builder: (context, state) {
                        return Text(
                          Config.quoteString[Config.quoteIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FabCircularMenu(
          ringColor: Config.colorApp,
          fabOpenColor: Config.colorApp,
          fabCloseColor: Config.colorApp,

          // ringDiameter: 350,
          animationCurve: Curves.easeInOut,
          children: <Widget>[
            // IconButton(icon: Icon(Icons.home), onPressed: () {}),
            // IconButton(icon: Icon(Icons.share), onPressed: () {}),
            // IconButton(icon: Icon(Icons.error_outline), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<CountBloc>(context),
                              child: DetailCountDown(),
                            )));
              },
            ),
            IconButton(
                icon: Icon(Icons.mic),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Recorder()));
                })
          ]),
    );
  }

  CarouselSlider buildCarouselSlider(BuildContext context, Date date) {
    return CarouselSlider(
      items: [
        buildColumnWithData(context, date, "NGÀY"),
        buildColumnWithData(context, date, "GIỜ"),
        buildColumnWithData(context, date, "PHÚT"),
        buildColumnWithData(context, date, "GIÂY"),
        buildColumnWithData(context, date, "THÁNG"),
        buildColumnWithData(context, date, "TUẦN"),
      ],
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        initialPage: 2,
      ),
    );
  }

  void loadCountTime(BuildContext context) {
    final dateBloc = BlocProvider.of<CountBloc>(context);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      dateBloc.add(GetDate(Config.testDate));
//    print("1");
    });
  }

  void loadNewBackgroundImage(BuildContext context) {
    BlocProvider.of<OnclickBloc>(context)..add(GetNewsBackground());
  }

  void loadNewQuote(BuildContext context) {
    BlocProvider.of<OnclickBloc>(context)..add(GetNewsQuote());
  }

  Column buildColumnWithData(BuildContext context, Date date, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "${counting(date, type)}",
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Text(
          type,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ],
    );
  }

  int counting(Date date, String type) {
    switch (type) {
      case "NGÀY":
        {
          return date.timeLeft.inDays;
        }
      case "GIỜ":
        {
          return date.timeLeft.inHours;
        }
      case "PHÚT":
        {
          return date.timeLeft.inMinutes;
        }
      case "GIÂY":
        {
          return date.timeLeft.inSeconds;
        }
      case "THÁNG":
        {
          return date.timeLeft.inDays ~/ 30;
        }
      case "TUẦN":
        {
          return date.timeLeft.inDays ~/ 7;
        }
    }
  }

  String formatVietnameseDateStyle(DateTime dateTime) {
    return "${(dateTime.day < 10) ? "0${dateTime.day}" : dateTime.day}/"
        "${(dateTime.month < 10) ? "0${dateTime.month}" : dateTime.month}/"
        "${dateTime.year}";
  }
}
