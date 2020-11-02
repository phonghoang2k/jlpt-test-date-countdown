import 'package:carousel_slider/carousel_slider.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/counter.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/home.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/home.module.dart';
import 'package:jlpt_testdate_countdown/src/models/date/date.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';
import 'package:jlpt_testdate_countdown/src/utils/style.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  CarouselController buttonCarouselController = CarouselController();
  HomeCubit _homeCubit = HomeCubit();
  CounterCubit _counterCubit = Modular.get<CounterCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlocBuilder<HomeCubit, HomeState>(
              cubit: _homeCubit,
              buildWhen: (prev, now) => now is BackgroundImageChanged,
              builder: (context, state) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: DataConfig.imageAssetsLink[_homeCubit.imageIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.safeBlockVertical * 5),
                Row(
                  children: <Widget>[
                    Spacer(),
                    Column(
                      children: <Widget>[
                        Text("Đếm ngược ngày thi", style: TextStyle(fontSize: 18, color: Colors.white)),
                        Text("Kì thi JLPT mùa đông 2020", style: TextStyle(color: Colors.white, fontSize: 13)),
                      ],
                    ),
                    Spacer(flex: 6),
                    IconButton(
                      icon: Icon(Icons.image, color: Colors.white, size: 25),
                      onPressed: () => _homeCubit.loadNewBackgroundImage(),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 5),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text("CÒN", style: TextStyle(fontSize: 18, color: Colors.white,)),
                      FlatButton(
                        child: BlocBuilder<CounterCubit, CounterState>(
                          cubit: _counterCubit,
                          builder: (context, state) => (state is OneSecondPassed)
                              ? buildCarouselSlider(state.dateCount)
                              : Center(child: CircularProgressIndicator()),
                        ),
                        splashColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        onPressed: () => Modular.link.pushNamed(HomeModule.detailCountdown),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.timer, color: Colors.white, size: 25),
                          SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                          Text(
                            "Ngày thi: ${DateFormat('dd-MM-yyyy').format(DataConfig.testDate)}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * 3),
                      Icon(Icons.chat, color: Colors.white, size: 30),
                      SizedBox(height: SizeConfig.safeBlockVertical),
                      BlocBuilder<HomeCubit, HomeState>(
                        cubit: _homeCubit,
                        buildWhen: (prev, now) => now is QuoteChanged,
                        builder: (context, state) => state is QuoteChanged
                            ? GestureDetector(
                                child: Text(
                                  state.quote,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () => _homeCubit.loadNewQuote(),
                              )
                            : Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
      animatedIcon: AnimatedIcons.view_list,
      animatedIconTheme: IconThemeData(size: 22.0),
      backgroundColor: Colors.blueAccent,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.home, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          label: 'Home',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.mic, color: Colors.white),
          backgroundColor: Colors.green,
          label: 'Recorder',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.share, color: Colors.white),
          backgroundColor: Colors.blue,
          labelWidget: Container(
            color: Colors.blue,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(6),
            child: Text('Share'),
          ),
        ),
      ],
    ),
    );
  }

  CarouselSlider buildCarouselSlider(DateCount date) => CarouselSlider(
        items: [
          buildColumnWithData(date, "NGÀY"),
          buildColumnWithData(date, "GIỜ"),
          buildColumnWithData(date, "PHÚT"),
          buildColumnWithData(date, "GIÂY"),
          buildColumnWithData(date, "THÁNG"),
          buildColumnWithData(date, "TUẦN"),
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

  Column buildColumnWithData(DateCount date, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("${counting(date, type)}", style: TextStyle(color: Colors.white, fontSize: 50)),
        Text(type, style: TextStyle(color: Colors.white, fontSize: 30)),
      ],
    );
  }

  int counting(DateCount date, String type) {
    switch (type) {
      case "NGÀY":
        return date.timeLeft.inDays;
      case "GIỜ":
        return date.timeLeft.inHours;
      case "PHÚT":
        return date.timeLeft.inMinutes;
      case "GIÂY":
        return date.timeLeft.inSeconds;
      case "THÁNG":
        return date.timeLeft.inDays ~/ 30;
      case "TUẦN":
        return date.timeLeft.inDays ~/ 7;
      default:
        return 0;
    }
  }
}
