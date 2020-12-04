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
  final AssetImage image;
  final bool isChangedImage;

  BackgroundImageChanged(this.image, this.isChangedImage);

  @override
  List<Object> get props => [image, isChangedImage];
}

class QuoteChanged extends HomeState {
  final String quote;

  QuoteChanged(this.quote);

  @override
  List<Object> get props => [quote];
}
