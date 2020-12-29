import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/counter.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/home.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/home.module.dart';
import 'package:jlpt_testdate_countdown/src/models/date/date.dart';
import 'package:jlpt_testdate_countdown/src/models/target_date/target_date.dart';
import 'package:jlpt_testdate_countdown/src/repositories/counter.repository.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';
import 'package:share/share.dart';

import 'cubit/home.cubit.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  CarouselController buttonCarouselController = CarouselController();
  HomeCubit _homeCubit = HomeCubit(FakeDateRepository());
  CounterCubit _counterCubit = Modular.get<CounterCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          BlocBuilder<HomeCubit, HomeState>(
              cubit: _homeCubit,
              buildWhen: (prev, now) => now is BackgroundImageChanged,
              builder: (context, state) => state is BackgroundImageChanged
                  ? AnimatedOpacity(
                      opacity: state.isChangedImage ? 1 : 0.2,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                        image: DataConfig.imageAssetsLink[_homeCubit.imageIndex],
                        fit: BoxFit.cover,
                      ))))
                  : SizedBox()),
          Container(
              child: Column(children: <Widget>[
            SizedBox(height: SizeConfig.safeBlockVertical * 5),
            Row(
              children: <Widget>[
                SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/app_icon.png', width: SizeConfig.safeBlockHorizontal * 10),
                  decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3)),
                ),
                Spacer(),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 5),
            Container(
                child: Column(children: <Widget>[
              Text("CÒN", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.safeBlockVertical * 25,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    FlatButton(
                      child: BlocBuilder<CounterCubit, CounterState>(
                        cubit: _counterCubit,
                        builder: (context, state) =>
                            (state is OneSecondPassed) ? buildCarouselSlider(state.dateCount) : Center(child: CircularProgressIndicator()),
                      ),
                      splashColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      onPressed: () => Modular.link.pushNamed(HomeModule.detailCountdown),
                    ),
                    Row(
                      children: [
                        IconButton(icon: Icon(Icons.arrow_left, color: Colors.white), iconSize: 50, onPressed: () {}),
                        Spacer(),
                        IconButton(icon: Icon(Icons.arrow_right, color: Colors.white), iconSize: 50, onPressed: () {})
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.timer, color: Colors.white, size: 25),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                  BlocBuilder<HomeCubit, HomeState>(
                    cubit: _homeCubit,
                    buildWhen: (prev, now) => now is TargetDateLoaded,
                    builder: (context, state) => Text(
                      "Ngày thi ${DataConfig.testDate.name}:",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              Text(
                "${DateFormat('dd-MM-yyyy').format(DataConfig.testDate.date)}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 10),
              BlocBuilder<HomeCubit, HomeState>(
                  cubit: _homeCubit,
                  buildWhen: (prev, now) => now is QuoteChanged,
                  builder: (context, state) => GestureDetector(
                      child: Padding(
                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5, right: SizeConfig.blockSizeHorizontal * 5),
                          child: Text(
                            DataConfig.quoteString[_homeCubit.quoteIndex],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                      onTap: () => _homeCubit.loadNewQuote(),
                      onPanUpdate: (details) {
                        if (details.delta.dx > 0) {
                          _homeCubit.loadNewQuote();
                        } else {
                          _homeCubit.loadNewQuote();
                        }
                      }))
            ]))
          ]))
        ]),
        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.view_list,
            animatedIconTheme: IconThemeData(size: 22.0, color: Colors.white),
            backgroundColor: AppColor.brown2,
            overlayColor: Colors.transparent,
            visible: true,
            curve: Curves.bounceIn,
            children: [
              SpeedDialChild(
                child: Icon(Icons.share, color: Colors.white),
                backgroundColor: AppColor.brown1,
                labelBackgroundColor: AppColor.brown1,
                label: 'Chia sẻ',
                labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                onTap: () => Share.share('check out my new Facebook page https://www.facebook.com/dudidauthatngau', subject: 'See yaa'),
              ),
              SpeedDialChild(
                child: Icon(Icons.alarm, color: Colors.white),
                backgroundColor: AppColor.brown1,
                label: 'Đếm ngược chi tiết',
                onTap: () => Modular.link.pushNamed(HomeModule.detailCountdown),
                labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                labelBackgroundColor: AppColor.brown1,
              ),
              SpeedDialChild(
                child: Icon(Icons.paste, color: Colors.white),
                backgroundColor: AppColor.brown1,
                onTap: () => Modular.link.pushNamed(HomeModule.note),
                label: 'Ghi chú của tôi',
                labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                labelBackgroundColor: AppColor.brown1,
              ),
              SpeedDialChild(
                child: Icon(Icons.article_outlined, color: Colors.white),
                backgroundColor: AppColor.brown1,
                label: 'Tài liệu học tập',
                onTap: () => Modular.link.pushNamed(HomeModule.learningMaterial),
                labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                labelBackgroundColor: AppColor.brown1,
              ),
              SpeedDialChild(
                child: Icon(Icons.music_note_outlined, color: Colors.white),
                backgroundColor: AppColor.brown1,
                onTap: () => Modular.link.pushNamed(HomeModule.music),
                label: 'Âm nhạc',
                labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                labelBackgroundColor: AppColor.brown1,
              ),
              SpeedDialChild(
                  child: Icon(Icons.photo_library_outlined, color: Colors.white),
                  backgroundColor: AppColor.brown1,
                  labelBackgroundColor: AppColor.brown1,
                  label: 'Thay đổi ảnh nền',
                  labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                  onTap: () => _homeCubit.loadNewBackgroundImage()),
              SpeedDialChild(
                  child: Icon(Icons.calendar_today, color: Colors.white),
                  backgroundColor: AppColor.brown1,
                  labelBackgroundColor: AppColor.brown1,
                  label: 'Thay đổi ngày thi',
                  labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                  onTap: () => {_homeCubit.loadDateData(), showDialog(context: context, builder: (context) => changeDateDialog())}),
            ]));
  }

  CarouselSlider buildCarouselSlider(DateCount date) => CarouselSlider(
        items: [
          buildColumnWithData(date, "THÁNG"),
          buildColumnWithData(date, "TUẦN"),
          buildColumnWithData(date, "NGÀY"),
          buildColumnWithData(date, "GIỜ"),
          buildColumnWithData(date, "PHÚT"),
          buildColumnWithData(date, "GIÂY"),
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

  AlertDialog changeDateDialog() {
    return AlertDialog(
      backgroundColor: Colors.black54,
      title: Text("Chọn ngày thi", style: TextStyle(color: Colors.white)),
      content: IntrinsicHeight(
        child: FormBuilder(
          key: _homeCubit.fbKey,
          child: BlocBuilder<HomeCubit, HomeState>(
            cubit: _homeCubit,
            builder: (context, state) => (state is TargetDatesLoaded)
                ? FormBuilderDropdown(
                    attribute: "date",
                    // initialValue: widget.data != null ? _cubit.subjectConvert.firstWhere((element) => element.output == widget.data.subject) : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                      labelText: "Chọn ngày đếm ngược",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    dropdownColor: Colors.black54,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    validators: [FormBuilderValidators.required()],
                    items: state.targetDates.map((TargetDate item) => DropdownMenuItem(value: item, child: Text("${item.name}"))).toList(),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              if (_homeCubit.fbKey.currentState.saveAndValidate()) {
                _homeCubit.changeTargetDate(_homeCubit.fbKey.currentState.value);
                Navigator.of(context).pop();
              }
            },
            child: Text("Lưu", style: TextStyle(color: Colors.white))),
        FlatButton(onPressed: () => Navigator.pop(context), child: Text("Hủy", style: TextStyle(color: Colors.white))),
      ],
    );
  }

  Column buildColumnWithData(DateCount date, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("${counting(date, type)}", style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.w600)),
        SizedBox(height: SizeConfig.blockSizeVertical * 3),
        Text(type, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
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
