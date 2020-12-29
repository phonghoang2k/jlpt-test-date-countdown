import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/models/target_date/target_date.dart';
import 'package:jlpt_testdate_countdown/src/repositories/counter.repository.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/exception.dart';

part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FakeDateRepository _dateRepository;
  int imageIndex = Application.sharePreference.getInt("imageIndex") ?? 0;
  int quoteIndex = Application.sharePreference.getInt("quoteIndex") ?? 0;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  HomeCubit(this._dateRepository) : super(HomeInitial()) {
    emit(QuoteChanged(DataConfig.quoteString[quoteIndex]));
    emit(BackgroundImageChanged(DataConfig.imageAssetsLink[imageIndex], false));
    emit(BackgroundImageChanged(DataConfig.imageAssetsLink[imageIndex], true));
  }

  void loadNewBackgroundImage() {
    emit(BackgroundImageChanged(DataConfig.imageAssetsLink[imageIndex], false));
    Future.delayed(Duration(seconds: 1), () {
      if (imageIndex < DataConfig.imageAssetsLink.length - 1) {
        imageIndex++;
      } else {
        DataConfig.imageAssetsLink.shuffle();
        imageIndex = 0;
      }
      Application.sharePreference.putInt("imageIndex", imageIndex);
      emit(BackgroundImageChanged(DataConfig.imageAssetsLink[imageIndex], true));
    });
  }

  void loadNewQuote() {
    quoteIndex = Random().nextInt(DataConfig.quoteString.length);
    Application.sharePreference.putInt("quoteIndex", quoteIndex);
    emit(QuoteChanged(DataConfig.quoteString[quoteIndex]));
  }

  Future<void> loadDateData() async {
    try {
      emit(TargetDatesLoading());
      var targetDateData = await _dateRepository.fetchAllLearningMaterial();
      emit(TargetDatesLoaded(targetDateData));
    } on NetworkException {
      emit(HomeError("Couldn't fetch data. Is the device online?"));
    }
  }

  @override
  void onChange(Change<HomeState> change) {
    print(change.nextState);
    super.onChange(change);
  }

  void changeTargetDate(Map<String, dynamic> value) {
    DataConfig.testDate = value["date"] as TargetDate;
    emit(TargetDateLoaded(DataConfig.testDate));
  }
}
