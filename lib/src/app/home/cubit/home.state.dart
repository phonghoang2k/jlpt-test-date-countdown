part of 'home.cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object> get props => [];
}

class BackgroundImageChanged extends HomeState {
  final int imageIndex;

  BackgroundImageChanged(this.imageIndex);

  @override
  List<Object> get props => [imageIndex];
}

class QuoteChanged extends HomeState {
  final int quoteIndex;

  QuoteChanged(this.quoteIndex);

  @override
  List<Object> get props => [quoteIndex];
}
