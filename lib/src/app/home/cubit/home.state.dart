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

class TargetDatesLoading extends HomeState {
  const TargetDatesLoading();

  @override
  List<Object> get props => [];
}

class TargetDatesLoaded extends HomeState {
  final List<TargetDate> targetDates;

  const TargetDatesLoaded(this.targetDates);

  @override
  List<Object> get props => [targetDates];
}

class TargetDateLoaded extends HomeState {
  final TargetDate targetDate;

  const TargetDateLoaded(this.targetDate);

  @override
  List<Object> get props => [targetDate];
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

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
