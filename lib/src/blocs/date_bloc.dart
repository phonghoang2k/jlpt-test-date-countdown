import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jlpt_testdate_countdown/src/resources/repository.dart';

import './bloc.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  final DateRepository dateRepository;

  DateBloc(this.dateRepository);

  @override
  DateState get initialState => DateInitial();

  @override
  Stream<DateState> mapEventToState(
    DateEvent event,
  ) async* {
    yield DateLoading();

    if (event is GetDate) {
      try {
        final date = dateRepository.fetchTime(event.testDate);
        yield DateLoaded(date);
      } on Error {
        yield DateError("??????");
      }
    }
  }
}
