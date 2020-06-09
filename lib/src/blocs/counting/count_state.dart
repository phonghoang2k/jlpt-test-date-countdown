import 'package:equatable/equatable.dart';
import 'package:jlpt_testdate_countdown/src/models/date.dart';

abstract class CountState extends Equatable {
  const CountState();
}

class CountInitial extends CountState {
  const CountInitial();

  @override
  List<Object> get props => [];
}

class CountLoading extends CountState {
  const CountLoading();

  @override
  List<Object> get props => [];
}

class CountLoaded extends CountState {
  final Date date;

  const CountLoaded(this.date);

  @override
  List<Object> get props => [date];
}

class CountError extends CountState {
  final String message;

  const CountError(this.message);

  @override
  List<Object> get props => [message];
}
