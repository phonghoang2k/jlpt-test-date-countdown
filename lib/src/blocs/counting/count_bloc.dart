import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/blocs/counting/bloc.dart';
import 'package:jlpt_testdate_countdown/src/resources/repository.dart';

class CountBloc extends Bloc<CountEvent, CountState> {
  final DateRepository dateRepository;

  CountBloc(this.dateRepository);

  @override
  CountState get initialState => CountInitial();

  @override
  Stream<CountState> mapEventToState(
    CountEvent event,
  ) async* {
    yield CountLoading();

    if (event is GetDate) {
      final date = dateRepository.fetchTime(event.testDate);
      yield CountLoaded(date);
    }
  }
}
