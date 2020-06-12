import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/settings/configuration.dart';
import 'package:jlpt_testdate_countdown/src/blocs/counting/bloc.dart';

class DetailCountDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailCountDownState();
  }
}

class DetailCountDownState extends State<DetailCountDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Config.imageAssetsLink[Config.imageIndex],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 40, left: 20),
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "TỪ NAY ĐẾN HÔM THI CÒN:",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Container(
                child: BlocBuilder<CountBloc, CountState>(
                  builder: (context, state) {
                    if (state is CountInitial) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CountLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is CountLoaded) {
                      int daysLeft = state.date.timeLeft.inDays;
                      int hoursleft =
                          state.date.timeLeft.inHours - (daysLeft * 24);
                      int minutesLeft = state.date.timeLeft.inMinutes -
                          (daysLeft * 24 * 60) -
                          (hoursleft * 60);
                      int secondsLeft = state.date.timeLeft.inSeconds -
                          (daysLeft * 24 * 60 * 60) -
                          (hoursleft * 60 * 60) -
                          (minutesLeft * 60);
                      return Row(
                        children: <Widget>[
                          const Expanded(child: SizedBox()),
                          _buildColumnWithData("$daysLeft", "NGÀY"),
                          const SizedBox(width: 20),
                          _buildColumnWithData("$hoursleft", "GIỜ"),
                          const SizedBox(width: 20),
                          _buildColumnWithData("$minutesLeft", "PHÚT"),
                          const SizedBox(width: 20),
                          _buildColumnWithData("$secondsLeft", "GIÂY"),
                          const Expanded(child: SizedBox()),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumnWithData(String time, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          time,
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Center(
          child: Text(
            type,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
