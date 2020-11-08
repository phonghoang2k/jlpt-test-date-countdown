import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/home.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/note/note-page.cubit.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';

class NotePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotePageState();
  }
}

class _NotePageState extends State<NotePage> {
  HomeCubit _homeCubit = HomeCubit();
  NoteCubit _noteCubit = NoteCubit();
  GlobalKey<FormBuilderState> _formBuilderKey = GlobalKey<FormBuilderState>();

  List<Map<String, dynamic>> _notes = [
    {
      "header": "Làm đề thi",
      "body": "Làm đề thi với crush",
      "time": "11/08/2020 10:49",
      "colorHeader": Colors.green[300],
      "colorBody": Colors.green[100]
    }
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
      children: <Widget>[
        BlocBuilder<HomeCubit, HomeState>(
            cubit: _homeCubit,
            buildWhen: (prev, now) => now is BackgroundImageChanged,
            builder: (context, state) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken),
                      image: DataConfig.imageAssetsLink[_homeCubit.imageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
        Container(
            margin: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 6, 100,
                SizeConfig.blockSizeHorizontal * 6, 20),
            child: BlocBuilder<NoteCubit, NoteState>(
                cubit: _noteCubit,
                buildWhen: (prev, now) => now is NoteCreate,
                builder: (context, state) {
                  if (state is NoteCreate) {
                    _notes.add({
                      "header": state.header,
                      "body": state.body,
                      "time": state.time,
                      "colorHeader": state.colorHeader,
                      "colorBody": state.colorBody
                    });
                  }
                  return GridView.builder(
                      itemCount: _notes.length,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) => _note(
                          header: _notes[index]["header"] as String,
                          body: _notes[index]["body"] as String,
                          time: _notes[index]["time"] as String,
                          colorHeader: _notes[index]["colorHeader"] as Color,
                          colorBody: _notes[index]["colorBody"] as Color));
                })),
        Positioned(
            left: 10,
            top: 45,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
                  iconSize: 25,
                  onPressed: () => Navigator.pop(context),
                ),
                Text("Ghi chú của tôi",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
              ],
            )),
        Positioned(
          child: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.yellow[800],
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: AlertDialog(
                      actionsPadding: EdgeInsets.only(
                          bottom: SizeConfig.safeBlockVertical * 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      title: Center(
                          child: Text("Tạo ghi chú mới",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize:
                                      SizeConfig.safeBlockVertical * 2.5))),
                      content: FormBuilder(
                          key: _formBuilderKey,
                          child: Column(children: [
                            FormBuilderTextField(
                                attribute: "header",
                                validators: [FormBuilderValidators.required()],
                                decoration: InputDecoration(
                                    labelText: "Tiêu đề ghi chú")),
                            FormBuilderTextField(
                                attribute: "body",
                                validators: [FormBuilderValidators.required()],
                                decoration: InputDecoration(
                                    labelText: "Nội dung ghi chú"))
                          ])),
                      actions: <Widget>[
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                        RaisedButton(
                            child: Container(
                              alignment: Alignment.center,
                              width: SizeConfig.safeBlockHorizontal * 22,
                              height: SizeConfig.safeBlockVertical * 5,
                              child: Text(
                                'Lưu lại',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            color: Color(0xFFE3161D),
                            onPressed: () {
                              if (_formBuilderKey.currentState
                                  .saveAndValidate()) {
                                _noteCubit.addNote(
                                    Map<String, String>.from(
                                        _formBuilderKey.currentState.value),
                                    "${DateFormat.yMd().format(DateTime.now()).toString()} ${DateFormat.Hm().format(DateTime.now()).toString()}",
                                    Colors.green,
                                    Colors.greenAccent);
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
                              'Đóng',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          color: Color(0xFF464646),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                      ],
                    ),
                    width: SizeConfig.safeBlockHorizontal * 80,
                  );
                }),
          ),
          bottom: 25,
          right: 25,
        )
      ],
    ));
  }

  Widget _note(
      {String header,
      String time,
      String body,
      Color colorHeader,
      Color colorBody}) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 40,
      child: Column(
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal * 40,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: colorHeader,
            ),
          ),
          Container(
            height: 100,
            width: SizeConfig.blockSizeHorizontal * 40,
            decoration: BoxDecoration(color: colorBody),
            padding: EdgeInsets.only(left: 5, top: 5),
            child: Column(children: [
              Text(header,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black)),
              Text(body,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black)),
            ]),
          )
        ],
      ),
    );
  }
}
