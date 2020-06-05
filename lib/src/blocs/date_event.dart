import 'package:equatable/equatable.dart';

abstract class DateEvent extends Equatable {
  const DateEvent();
}

class GetDate extends DateEvent {
  final DateTime testDate;

  const GetDate(this.testDate);

  @override
  // TODO: implement props
  List<Object> get props => [testDate];
}
