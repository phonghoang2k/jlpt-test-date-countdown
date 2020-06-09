import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:jlpt_testdate_countdown/settings/configuration.dart';

import './bloc.dart';

class OnclickBloc extends Bloc<OnclickEvent, OnclickState> {
  @override
  OnclickState get initialState => OnclickInitial();

  @override
  Stream<OnclickState> mapEventToState(
    OnclickEvent event,
  ) async* {
    yield Loading();

    if (event is GetNewsBackground) {
      Config.imageIndex = Random().nextInt(Config.imageAssetsLink.length);
      yield BackgroundLoaded(Config.imageIndex);
//      yield* _mapEventUpdateBackgroundToState();
    } else if (event is GetNewsQuote) {
//      yield* _mapEventUpdateQuoteToState();
      Config.quoteIndex = Random().nextInt(Config.quoteString.length);
      yield QuoteLoaded(Config.imageIndex);
    }
  }

//  Stream<OnclickState> _mapEventUpdateBackgroundToState() async* {
//    Config.imageIndex = Random().nextInt(Config.imageAssetsLink.length);
//    yield BackgroundLoaded(Config.imageIndex);
//  }
//
//  Stream<OnclickState> _mapEventUpdateQuoteToState() async* {
//    Config.quoteIndex = Random().nextInt(Config.quoteString.length);
//    yield QuoteLoaded(Config.imageIndex);
//  }
}
