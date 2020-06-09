import 'package:equatable/equatable.dart';

abstract class OnclickEvent extends Equatable {
  const OnclickEvent();
}

class GetNewsBackground extends OnclickEvent {
  const GetNewsBackground();

  @override
  List<Object> get props => [];
}

class GetNewsQuote extends OnclickEvent {
  const GetNewsQuote();

  @override
  List<Object> get props => [];
}
