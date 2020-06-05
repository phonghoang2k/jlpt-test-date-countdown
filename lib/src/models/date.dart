import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Date extends Equatable {
  final Duration timeLeft;
  final DateTime testDate;

  Date({@required this.timeLeft, this.testDate});

  @override
  // TODO: implement props
  List<Object> get props => [timeLeft, testDate];
}
