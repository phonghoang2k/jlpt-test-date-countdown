import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/counter.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/detail-countdown/detail-countdown.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/note/note-page.cubit.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailCountdown extends StatefulWidget {
  @override
  _DetailCountdownState createState() => _DetailCountdownState();
}

class _DetailCountdownState extends State<DetailCountdown> with SingleTickerProviderStateMixin {
  CounterCubit _counterCubit = Modular.get<CounterCubit>();
  NoteCubit _noteCubit = NoteCubit();
  CalendarController _calendarController;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                image: DataConfig.imageAssetsLink[Application.sharePreference.getInt("imageIndex") ?? 0],
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.0))),
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
          Container(
            height: SizeConfig.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: SizeConfig.safeBlockVertical * 20),
                Text("TỪ NAY ĐẾN HÔM THI CÒN",
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
                SizedBox(height: SizeConfig.blockSizeVertical * 4),
                Container(
                  child: BlocBuilder<CounterCubit, CounterState>(
                    cubit: _counterCubit,
                    builder: (context, state) => (state is OneSecondPassed)
                        ? Row(
                            children: <Widget>[
                              Spacer(),
                              _buildColumnWithData(
                                  "${DetailCountdownData.fromDateCount(state.dateCount).daysLeft}", "NGÀY"),
                              const SizedBox(width: 26),
                              _buildColumnWithData(
                                  "${DetailCountdownData.fromDateCount(state.dateCount).hoursLeft}", "GIỜ"),
                              const SizedBox(width: 26),
                              _buildColumnWithData(
                                  "${DetailCountdownData.fromDateCount(state.dateCount).minutesLeft}", "PHÚT"),
                              const SizedBox(width: 26),
                              _buildColumnWithData(
                                  "${DetailCountdownData.fromDateCount(state.dateCount).secondsLeft}", "GIÂY"),
                              Spacer(),
                            ],
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 5),
                Container(
                    color: Colors.white.withOpacity(0.2),
                    child: _buildTableCalendarWithBuilders(),
                    margin: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3)),
                Expanded(child: SizedBox()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return BlocBuilder<NoteCubit, NoteState>(
        cubit: _noteCubit,
        builder: (context, state) => TableCalendar(
              locale: 'vi_VN',
              calendarController: _calendarController,
              events: _noteCubit.events,
              holidays: _holidays,
              initialCalendarFormat: CalendarFormat.month,
              formatAnimation: FormatAnimation.slide,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              availableGestures: AvailableGestures.all,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
                CalendarFormat.week: '',
              },
              initialSelectedDay: DateTime.now(),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                outsideStyle: TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                weekdayStyle: TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                eventDayStyle: TextStyle().copyWith(color: Colors.white),
                weekendStyle: TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                holidayStyle: TextStyle().copyWith(color: Colors.red),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                weekendStyle: TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.white),
                rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                formatButtonVisible: false,
                titleTextStyle: TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
              ),
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, _) {
                  return FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                      color: Colors.deepOrange[300],
                      width: 100,
                      height: 100,
                      child: Text(
                        '${date.day}',
                        style: TextStyle().copyWith(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                },
                todayDayBuilder: (context, date, _) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    color: Colors.amber[400],
                    width: 100,
                    height: 100,
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(fontSize: 18.0, color: Colors.white),
                    ),
                  );
                },
                markersBuilder: (context, date, events, holidays) {
                  final children = <Widget>[];

                  if (events.isNotEmpty) {
                    children.add(
                      Positioned(
                        right: 1,
                        bottom: 1,
                        child: _buildEventsMarker(date, events),
                      ),
                    );
                  }

                  if (holidays.isNotEmpty) {
                    children.add(
                      Positioned(
                        right: -2,
                        top: -2,
                        child: _buildHolidaysMarker(),
                      ),
                    );
                  }

                  return children;
                },
              ),
              onDaySelected: (date, events, holidays) {
                _onDaySelected(date, events, holidays);
                _animationController.forward(from: 0.0);
              },
              onVisibleDaysChanged: _onVisibleDaysChanged,
              onCalendarCreated: _onCalendarCreated,
            ));
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  final Map<DateTime, List> _holidays = {
    DateTime(2021, 1, 1): ['New Year\'s Day'],
    DateTime(2020, 1, 6): ['Epiphany'],
    DateTime(2020, 2, 14): ['Valentine\'s Day'],
    DateTime(2020, 4, 21): ['Easter Sunday'],
    DateTime(2020, 4, 22): ['Easter Monday'],
  };

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    _noteCubit.setSelectedEvent(day);
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  Widget _buildColumnWithData(String time, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(time, style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.w600)),
        Center(child: Text(type, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600))),
      ],
    );
  }
}
