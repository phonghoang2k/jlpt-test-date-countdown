import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';

part 'music.state.dart';

class MusicCubit extends Cubit<MusicState> {
  int imageIndex = 0;
  int songIndex = 0;

  MusicCubit() : super(MusicInitial()) {
    emit(MusicImage(DataConfig.imageMusic[imageIndex]));
    emit(MusicSong(DataConfig.songMusic[songIndex]));
  }

  void loadNewSongImage() {
    print(imageIndex);
    imageIndex = Random().nextInt(DataConfig.imageMusic.length);
    emit(MusicImage(DataConfig.imageMusic[imageIndex]));
  }

  void loadNewSong() {
    print(songIndex);
    songIndex = Random().nextInt(DataConfig.songMusic.length);
    // Application.sharePreference.putInt("quoteIndex", quoteIndex);
    emit(MusicSong(DataConfig.songMusic[songIndex]));
  }
}
