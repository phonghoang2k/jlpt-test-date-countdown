import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/app/home/study-music/music.cubit.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow; //khi chua phat nhac

  AudioPlayer _player;
  AudioCache _cache;
  Duration position = Duration();
  Duration musicLength = Duration();

  MusicCubit _musicCubit = MusicCubit();

  Widget slider() {
    return Container(
      width: 300,
      child: Slider.adaptive(
          activeColor: Colors.black87,
          inactiveColor: Colors.grey[500],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  // create   seek function
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _player);

    //handle audioplayer time
    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  //ui design

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Colors.red[600],
                  ]),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 48,
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Container(
                        margin: EdgeInsets.only(left: 90),
                        child: Text(
                          'Music Beats',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Center(
                        child: Text(
                          'Listen to my favorite song',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<MusicCubit, MusicState>(
                        cubit: _musicCubit,
                        buildWhen: (prev, now) => now is MusicImage,
                        builder: (context, state) => Center(
                              child: CircleAvatar(
                                radius: 150,
                                backgroundImage: DataConfig
                                    .imageMusic[_musicCubit.imageIndex],
                              ),
                            )),
                    SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Text(
                        'Daddy Challenge',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Text(
                          'LIU GRACE x KAYLIN x HELIX',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                              width: 500,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "${position.inMinutes}: ${position.inSeconds.remainder(60)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  slider(),
                                  Text(
                                      "${musicLength.inMinutes}: ${musicLength.inSeconds.remainder(60)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    iconSize: 40,
                                    color: Colors.black,
                                    icon: Icon(Icons.skip_previous),
                                    onPressed: () {}),
                                BlocBuilder<MusicCubit, MusicState>(
                                    cubit: _musicCubit,
                                    buildWhen: (prev, now) => now is MusicSong,
                                    // ignore: missing_return
                                    builder: (context, state) => IconButton(
                                        iconSize: 60,
                                        color: Colors.black,
                                        icon: Icon(playBtn),
                                        onPressed: () {
                                          if (!playing) {
                                            _cache.play(DataConfig.songMusic[
                                                _musicCubit.songIndex]);
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
                                    iconSize: 40,
                                    color: Colors.black,
                                    icon: Icon(Icons.skip_next),
                                    onPressed: () {
                                      _musicCubit.loadNewSong();
                                      _musicCubit.loadNewSongImage();
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
