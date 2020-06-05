import 'package:equatable/equatable.dart';
import 'package:jlpt_testdate_countdown/src/models/date.dart';

abstract class DateState extends Equatable {
  const DateState();
}

class DateInitial extends DateState {
  const DateInitial();

  @override
  List<Object> get props => [];
}

class DateLoading extends DateState {
  const DateLoading();

  @override
  List<Object> get props => [];
}

class DateLoaded extends DateState {
  final Date date;

  const DateLoaded(this.date);

  @override
  List<Object> get props => [date];
}

class DateError extends DateState {
  final String message;

  const DateError(this.message);

  @override
  List<Object> get props => [message];
}
