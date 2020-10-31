import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/counter.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/detail-countdown/detail-countdown.cubit.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';

class DetailCountdown extends StatefulWidget {
  @override
  _DetailCountdownState createState() => _DetailCountdownState();
}

class _DetailCountdownState extends State<DetailCountdown> {
  CounterCubit _counterCubit = Modular.get<CounterCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: DataConfig.imageAssetsLink[Application.sharePreference.getInt("imageIndex") ?? 0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("TỪ NAY ĐẾN HÔM THI CÒN:", style: TextStyle(fontSize: 20, color: Colors.white)),
              Container(
                child: BlocBuilder<CounterCubit, CounterState>(
                  cubit: _counterCubit,
                  builder: (context, state) => (state is OneSecondPassed)
                      ? Row(
                          children: <Widget>[
                            Spacer(),
                            _buildColumnWithData(
                                "${DetailCountdownData.fromDateCount(state.dateCount).daysLeft}", "NGÀY"),
                            const SizedBox(width: 20),
                            _buildColumnWithData(
                                "${DetailCountdownData.fromDateCount(state.dateCount).hoursLeft}", "GIỜ"),
                            const SizedBox(width: 20),
                            _buildColumnWithData(
                                "${DetailCountdownData.fromDateCount(state.dateCount).minutesLeft}", "PHÚT"),
                            const SizedBox(width: 20),
                            _buildColumnWithData(
                                "${DetailCountdownData.fromDateCount(state.dateCount).secondsLeft}", "GIÂY"),
                            Spacer(),
                          ],
                        )
                      : Center(child: CircularProgressIndicator()),
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
        Text(time, style: TextStyle(color: Colors.white, fontSize: 50)),
        Center(child: Text(type, style: TextStyle(color: Colors.white, fontSize: 20))),
      ],
    );
  }
}
