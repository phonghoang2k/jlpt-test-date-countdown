import 'dart:async';
import 'dart:ui';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
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
    print(position);
    print(musicLength);
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
      body: Stack(
        children: [
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
          Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: 48),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Music Beats',
                        style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Listen to my favorite song',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<MusicCubit, MusicState>(
                        cubit: _musicCubit,
                        buildWhen: (prev, now) => now is MusicImage,
                        builder: (context, state) => Center(
                            child:
                            // playing
                            //     ? SpinningWheel(
                            //         DataConfig.musicList[_musicCubit.songIndex].songImage,
                            //         height: 120.0,
                            //         width: 120.0,
                            //         duration: musicLength,
                            //       )
                            //     :
                          CircleAvatar(
                                    radius: 120,
                                    backgroundImage: DataConfig.musicList[_musicCubit.songIndex].songImage,
                                  ))),
                    SizedBox(height: 18),
                    Center(
                      child: Text(
                        DataConfig.musicList[_musicCubit.songIndex].songName,
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Center(
                          child: Text(
                            DataConfig.musicList[_musicCubit.songIndex].artists,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Text("${position.inMinutes}: ${position.inSeconds.remainder(60)}",
                                  //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                  // slider(),
                                  // Text("${musicLength.inMinutes}: ${musicLength.inSeconds.remainder(60)}",
                                  //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    iconSize: 30,
                                    color: Colors.black,
                                    icon: Icon(Icons.skip_previous),
                                    onPressed: () {}),
                                BlocBuilder<MusicCubit, MusicState>(
                                    cubit: _musicCubit,
                                    buildWhen: (prev, now) => now is MusicSong,
                                    // ignore: missing_return
                                    builder: (context, state) => IconButton(
                                        iconSize: 40,
                                        color: Colors.black,
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
                                        })),
                                IconButton(
                                    iconSize: 30,
                                    color: Colors.black,
                                    icon: Icon(Icons.skip_next),
                                    onPressed: () {
                                      _musicCubit.loadNewSong();
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 45,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
              iconSize: 25,
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
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

    _animationController = AnimationController(
      vsync: this,
      duration:Duration(seconds: 20)
    );
    _animation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));}

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
