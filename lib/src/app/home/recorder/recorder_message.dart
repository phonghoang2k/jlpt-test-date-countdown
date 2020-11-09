import 'dart:io' as io;
import 'dart:math';

import 'package:audio_recorder/audio_recorder.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/home.cubit.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Recorder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RecorderState();
  }
}

class RecorderState extends State<Recorder> {
  Recording _recording = Recording();
  HomeCubit _homeCubit = HomeCubit();
  bool _isRecording = false;
  Random random = Random();
  TextEditingController _controller = TextEditingController();
  LocalFileSystem localFileSystem = LocalFileSystem();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  // ignore: always_declare_return_types
  _start() async {
    try {
      print('Start Recording...');
      bool permission = await checkPermission();
      if (permission) {
        if (_controller.text != null && _controller.text != "") {
          String path = _controller.text;
          if (!_controller.text.contains('/')) {
            io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
            path = '${appDocDirectory.path}/${_controller.text}';
          }
          print("Start recording: $path");
          await AudioRecorder.start(path: path, audioOutputFormat: AudioOutputFormat.AAC);
        } else {
          print('AudioRecorder start');
          await AudioRecorder.start();
        }
        bool isRecording = await AudioRecorder.isRecording;
        setState(() {
          _recording = Recording(duration: Duration(), path: "");
          _isRecording = isRecording;
        });
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  // ignore: always_declare_return_types
  _stop() async {
    var recording = await AudioRecorder.stop();
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder.isRecording;
    File file = localFileSystem.file(recording.path);
    print("  File length: ${await file.length()}");
    setState(() {
      _recording = recording;
      _isRecording = isRecording;
    });
    _controller.text = recording.path;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
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
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
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
            children: <Widget>[
              SizedBox(height: 200),
              FlatButton(
                onPressed: _isRecording ? null : _start,
                child: Text("Start"),
                color: Colors.green,
              ),
              FlatButton(
                onPressed: _isRecording ? _stop : null,
                child: Text("Stop"),
                color: Colors.red,
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter a custom path',
                ),
              ),
              Text("File path of the record: ${_recording.path}",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
              Text("Format: ${_recording.audioOutputFormat}",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
              Text("Extension : ${_recording.extension}",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
              Text("Audio recording duration : ${_recording.duration.toString()}",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
