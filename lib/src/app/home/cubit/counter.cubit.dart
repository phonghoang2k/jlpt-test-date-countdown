import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/models/date/date.dart';
import 'package:jlpt_testdate_countdown/src/repositories/counter.repository.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';

part 'counter.state.dart';

class CounterCubit extends Cubit<CounterState> {
  Timer timer;
  final dateRepository = Modular.get<FakeDateRepository>();

  CounterCubit() : super(CounterInitial()) {
    loadCountTime();
  }

  void loadCountTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateCount dateCount = dateRepository.fetchTime(DataConfig.testDate);
      emit(OneSecondPassed(dateCount));
    });
  }

}
