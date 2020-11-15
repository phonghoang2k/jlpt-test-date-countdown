import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/models/music/music.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';

part 'music.state.dart';

class MusicCubit extends Cubit<MusicState> {
  int songIndex = 0;

  MusicCubit() : super(MusicInitial()) {
    emit(MusicSong(DataConfig.musicList[songIndex]));
  }

  void loadNewSong() {
    print(songIndex);
    songIndex = Random().nextInt(DataConfig.musicList.length);
    // Application.sharePreference.putInt("quoteIndex", quoteIndex);
    emit(MusicSong(DataConfig.musicList[songIndex]));
  }
}
