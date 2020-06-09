import 'package:equatable/equatable.dart';

abstract class CountEvent extends Equatable {
  const CountEvent();
}

class GetDate extends CountEvent {
  final DateTime testDate;

  const GetDate(this.testDate);

  @override
  List<Object> get props => [testDate];
}
