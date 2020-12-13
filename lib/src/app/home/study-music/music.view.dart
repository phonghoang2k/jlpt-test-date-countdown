import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/app/home/study-music/music.cubit.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> with TickerProviderStateMixin {
  bool playing = false;
  IconData playBtn = Icons.play_arrow; //khi chua phat nhac
  Timer _countdownTimer;
  Duration start = Duration(seconds: 0);
  AudioPlayer _player;
  AudioCache _cache;
  Duration position = Duration();
  Duration musicLength = Duration();
  int _countdownNum = 3000000;
  MusicCubit _musicCubit = MusicCubit();

  Widget slider() {
    return Container(
      width: 300,
      height: 100,
      child: Slider.adaptive(
          activeColor: Colors.white,
          inactiveColor: Colors.grey[500],
          value: (position.inSeconds / musicLength.inSeconds).toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  // create seek function
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  //
  @override
  void initState() {
    super.initState();
    if (_countdownTimer != null) {
      return;
    }
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdownNum--;
        start = start + Duration(seconds: 10);
        if (_countdownNum == 0) {
          _countdownTimer.cancel();
        }
      });
    });
    //Todo: Init AudioPlayer
    _player = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _player);
    _player.onDurationChanged.listen((Duration d) {
      setState(() {
        musicLength = d;
      });
    });

    _player.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              BlocBuilder<MusicCubit, MusicState>(
                  cubit: _musicCubit,
                  buildWhen: (prev, now) => now is MusicImage,
                  builder: (context, state) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            // colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                            image: DataConfig.musicList[_musicCubit.songIndex].songImage, fit: BoxFit.fitHeight,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              Colors.yellow[800],
                              Colors.yellow[700],
                              Colors.yellow[600],
                              Colors.yellow[400],
                            ],
                          ),
                        ),
                        height: SizeConfig.screenHeight,
                      )),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.5, 0.8, 0.9],
                    colors: [
                      Colors.black38,
                      Colors.black54,
                      Colors.black87,
                      Colors.black,
                    ],
                  ),
                ),
                height: SizeConfig.screenHeight,
              ),
              Positioned(
                  bottom: SizeConfig.blockSizeVertical * 15,
                  child: BlocBuilder<MusicCubit, MusicState>(
                      cubit: _musicCubit,
                      buildWhen: (prev, now) => now is MusicImage,
                      builder: (context, state) => SizedBox(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    child: FittedBox(
                                        child: Text(
                                          DataConfig.musicList[_musicCubit.songIndex].songName,
                                          style:
                                              TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
                                        ),
                                        fit: BoxFit.fitWidth)),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 50,
                                    child: FittedBox(
                                        child: Text(
                                          DataConfig.musicList[_musicCubit.songIndex].artists,
                                          style:
                                              TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                        ),
                                        fit: BoxFit.fitWidth))
                              ],
                            ),
                            BlocBuilder<MusicCubit, MusicState>(
                                cubit: _musicCubit,
                                buildWhen: (prev, now) => now is MusicSong,
                                // ignore: missing_return
                                builder: (context, state) => CircleAvatar(
                                    backgroundColor: AppColor.darkPink,
                                    child: IconButton(
                                        iconSize: 40,
                                        color: Colors.white,
                                        icon: Icon(playBtn),
                                        onPressed: () {
                                          if (!playing) {
                                            _cache.play(DataConfig.musicList[_musicCubit.songIndex].songAsset);
                                            setState(() {
                                              playBtn = Icons.pause;
                                              playing = true;
                                            });
                                          } else {
                                            _player.pause();
                                            setState(() {
                                              playBtn = Icons.play_arrow;
                                              playing = false;
                                            });
                                          }
                                        }),
                                    radius: 30))
                          ]),
                          width: SizeConfig.screenWidth))),
              Positioned(
                  left: 10,
                  top: 45,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
                        iconSize: 25,
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        "Âm nhạc",
                        style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}

class SpinningWheel extends StatefulWidget {
  final double width;
  final double height;
  final AssetImage image;
  final Duration duration;

  SpinningWheel(this.image, {@required this.width, @required this.height, this.duration});

  @override
  _SpinningWheelState createState() => _SpinningWheelState();
}

class _SpinningWheelState extends State<SpinningWheel> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  void _startOrStop() {
    print(widget.duration);
    print('start/stop ${_animationController.status} - ${_animationController.isAnimating}');
    if (_animationController.isAnimating) {
      _animationController.stop();
    } else {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: widget.height,
        width: widget.width,
        child: AnimatedBuilder(
            animation: _animation,
            child: CircleAvatar(
              radius: widget.height,
              backgroundImage: widget.image,
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value,
                child: child,
              );
            }),
      ),
      SizedBox(height: 30),
      RaisedButton(
        child: Text('Start/Stop'),
        onPressed: _startOrStop,
      )
    ]);
  }
}
