import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';

part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  int imageIndex = Application.sharePreference.getInt("imageIndex") ?? 0;
  int quoteIndex = Application.sharePreference.getInt("quoteIndex") ?? 0;

  HomeCubit() : super(HomeInitial()) {
    emit(QuoteChanged(DataConfig.quoteString[quoteIndex]));
    emit(BackgroundImageChanged(DataConfig.imageAssetsLink[imageIndex], false));
    emit(BackgroundImageChanged(DataConfig.imageAssetsLink[imageIndex], true));
  }

  void loadNewBackgroundImage() {
    emit(BackgroundImageChanged(DataConfig.imageAssetsLink[imageIndex], false));
    Future.delayed(Duration(seconds: 1), () {
      imageIndex = Random().nextInt(DataConfig.imageAssetsLink.length);
      Application.sharePreference.putInt("imageIndex", imageIndex);
      emit(BackgroundImageChanged(DataConfig.imageAssetsLink[imageIndex], true));
    });
  }

  void loadNewQuote() {
    quoteIndex = Random().nextInt(DataConfig.quoteString.length);
    Application.sharePreference.putInt("quoteIndex", quoteIndex);
    emit(QuoteChanged(DataConfig.quoteString[quoteIndex]));
  }

  @override
  void onChange(Change<HomeState> change) {
    print(change.nextState);
    super.onChange(change);
  }
}
