import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/home.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/note/note-page.cubit.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';
import 'package:table_calendar/table_calendar.dart';

class NotePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotePageState();
  }
}

class _NotePageState extends State<NotePage> with SingleTickerProviderStateMixin {
  HomeCubit _homeCubit = HomeCubit();
  NoteCubit _noteCubit = NoteCubit();

  bool deleteMode = true;
  final TextEditingController textController = TextEditingController();
  GlobalKey<FormBuilderState> _formBuilderKey = GlobalKey<FormBuilderState>();
  final _colors = [0xffd4d9e1, 0xffF1E219, 0xff00A506, 0xffd0484e, 0xff2AFFF1];

  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime(2021, 1, 1);
    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      _selectedDay.add(Duration(days: 3)): {'Event A9', 'Event B9'}.toList(),
      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
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
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

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
                      colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                      image: DataConfig.imageAssetsLink[_homeCubit.imageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
        Container(
            margin: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 6, 100, SizeConfig.blockSizeHorizontal * 6, 20),
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              // _buildTableCalendar(),
              _buildTableCalendarWithBuilders(),
              const SizedBox(height: 8.0),
              Expanded(child: _buildEventList()),
            ])),
        Positioned(
            left: 10,
            top: 45,
            child: SizedBox(
                width: SizeConfig.screenWidth,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
                      iconSize: 25,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text("Ghi chú của tôi", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600)),
                    Expanded(child: SizedBox()),
                    BlocBuilder<NoteCubit, NoteState>(
                        cubit: _noteCubit,
                        builder: (context, state) => state is DeleteMode || state is ChangeSelectedIndex
                            ? SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 30,
                                child: Row(children: [
                                  Checkbox(
                                      value: _noteCubit.selectedIndex.length == _noteCubit.headerList.length,
                                      activeColor: Colors.red,
                                      checkColor: Colors.white,
                                      onChanged: (value) => setState(() => _noteCubit.addAll())),
                                  Text('Tất cả', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600))
                                ]))
                            : SizedBox()),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 7,
                    )
                  ],
                ))),
        BlocBuilder<NoteCubit, NoteState>(
            cubit: _noteCubit,
            builder: (context, state) => state is DeleteMode || state is ChangeSelectedIndex
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 26,
                      height: SizeConfig.blockSizeVertical * 6,
                      margin: EdgeInsets.only(bottom: 12),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.red,
                        onPressed: () {
                          _noteCubit.deleteSelectedList();
                          _noteCubit.changeToEditMode();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Expanded(child: SizedBox()),
                            Text("Xoá", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    ))
                : Positioned(
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Colors.yellow[800],
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // actionsPadding: EdgeInsets.only(
                              //     bottom: SizeConfig.safeBlockVertical * 40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              title: Center(
                                  child: Text("Tạo ghi chú mới", style: TextStyle(fontWeight: FontWeight.w800, fontSize: SizeConfig.safeBlockVertical * 2.5))),
                              content: SingleChildScrollView(
                                child: FormBuilder(
                                    key: _formBuilderKey,
                                    child: Column(children: [
                                      FormBuilderTextField(
                                          attribute: "header",
                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                          validators: [FormBuilderValidators.required()],
                                          decoration: InputDecoration(labelText: "Tiêu đề ghi chú")),
                                      FormBuilderTextField(
                                          attribute: "body",
                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                          validators: [FormBuilderValidators.required()],
                                          decoration: InputDecoration(
                                            labelText: "Nội dung ghi chú",
                                            hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                                          )),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 3),
                                      BlocBuilder<NoteCubit, NoteState>(
                                          cubit: _noteCubit,
                                          builder: (context, state) => Container(
                                                  child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Chọn màu', style: TextStyle(color: Colors.black, fontSize: 13)),
                                                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: _colors
                                                        .map((color) => InkWell(
                                                              onTap: () => _noteCubit.setColorIndex(_colors.indexOf(color)),
                                                              child: AnimatedContainer(
                                                                duration: Duration(milliseconds: 300),
                                                                width: (_colors.indexOf(color) == _noteCubit.colorIndex)
                                                                    ? SizeConfig.safeBlockHorizontal * 10
                                                                    : SizeConfig.safeBlockHorizontal * 8,
                                                                height: (_colors.indexOf(color) == _noteCubit.colorIndex)
                                                                    ? SizeConfig.safeBlockHorizontal * 10
                                                                    : SizeConfig.safeBlockHorizontal * 8,
                                                                decoration: BoxDecoration(
                                                                    color: Color(color),
                                                                    border: (_colors.indexOf(color) == 4) ? Border.all(color: Colors.black38) : null,
                                                                    borderRadius: BorderRadius.circular(5)),
                                                              ),
                                                            ))
                                                        .toList(),
                                                  )
                                                ],
                                              ))),
                                    ])),
                              ),
                              actions: <Widget>[
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                                RaisedButton(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.safeBlockHorizontal * 22,
                                      height: SizeConfig.safeBlockVertical * 5,
                                      child: Text(
                                        'Lưu',
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    color: Color(0xFFE3161D),
                                    onPressed: () {
                                      if (_formBuilderKey.currentState.saveAndValidate()) {
                                        _noteCubit.addNote(
                                            Map<String, String>.from(_formBuilderKey.currentState.value),
                                            "${DateFormat.yMd().format(DateTime.now()).toString()} ${DateFormat.Hm().format(DateTime.now()).toString()}",
                                            _colors[_noteCubit.colorIndex].toString());
                                        Navigator.of(context).pop();
                                      }
                                    }),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
                                RaisedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.safeBlockHorizontal * 22,
                                    height: SizeConfig.safeBlockVertical * 5,
                                    child: Text(
                                      'Thoát',
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  color: Color(0xFF464646),
                                ),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                              ],
                            );
                          }),
                    ),
                    bottom: 25,
                    right: 25,
                  ))
      ],
    ));
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'vi_VN',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.week,
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
        outsideStyle: TextStyle().copyWith(color: Colors.white),
        weekdayStyle: TextStyle().copyWith(color: Colors.white),
        eventDayStyle: TextStyle().copyWith(color: Colors.white),
        weekendStyle: TextStyle().copyWith(color: Colors.white),
        holidayStyle: TextStyle().copyWith(color: Colors.red),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        weekendStyle: TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.white),
        rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.white),
        formatButtonVisible: false,
        titleTextStyle: TextStyle().copyWith(color: Colors.white),
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
                style: TextStyle().copyWith(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w700),
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
              style: TextStyle().copyWith(fontSize: 16.0, color: Colors.white),
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
    );
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

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(12.0), color: Colors.white.withOpacity(0.6)),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                  onTap: () {
                    print('$event tapped!');
                  },
                ),
              ))
          .toList(),
    );
  }

  Widget _note({int index, String header, String time, String body, String color}) {
    return BlocBuilder<NoteCubit, NoteState>(
        cubit: _noteCubit,
        builder: (context, state) => GestureDetector(
            onTap: () {
              state is DeleteMode || state is ChangeSelectedIndex ? setState(() => _noteCubit.changeSelectedIndex(index)) : null;
            },
            onLongPress: () {
              _noteCubit.changeToDeleteMode();
              _noteCubit.changeSelectedIndex(index);
            },
            child: Container(
                width: SizeConfig.blockSizeHorizontal * 40,
                child: Stack(children: [
                  Column(
                    children: [
                      Container(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            time,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(color: Color(int.parse(color)), borderRadius: BorderRadius.circular(3))),
                      Container(
                          height: 104,
                          width: SizeConfig.blockSizeHorizontal * 40,
                          decoration: BoxDecoration(color: Color(int.parse(color))),
                          child: Stack(children: [
                            Container(height: 100, width: SizeConfig.blockSizeHorizontal * 40, decoration: BoxDecoration(color: Colors.white.withOpacity(0.5))),
                            Column(children: [
                              Center(
                                  child: Text(header,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black))),
                              Text(body, maxLines: 3, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black)),
                            ])
                          ]))
                    ],
                  ),
                  state is! EditMode && state is! ColorChange
                      ? Positioned(
                          child: Checkbox(
                              value: _noteCubit.selectedIndex.contains(index), onChanged: (value) => setState(() => _noteCubit.changeSelectedIndex(index))),
                          right: 7,
                          top: -10,
                        )
                      : SizedBox()
                ]))));
  }
}
