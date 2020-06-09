import 'package:equatable/equatable.dart';

abstract class OnclickState extends Equatable {
  const OnclickState();
}

class OnclickInitial extends OnclickState {
  @override
  List<Object> get props => [];
}

class BackgroundLoaded extends OnclickState {
  final int imageIndex;

  BackgroundLoaded(this.imageIndex);

  @override
  List<Object> get props => [imageIndex];
}

class Loading extends OnclickState {
  const Loading();

  @override
  List<Object> get props => [];
}

class QuoteLoaded extends OnclickState {
  final int quoteIndex;

  QuoteLoaded(this.quoteIndex);

  @override
  List<Object> get props => [quoteIndex];
}
