part of 'detailed-learning.cubit.dart';

@immutable
abstract class DetailedLearningState extends Equatable {
  const DetailedLearningState();
}

class DetailedLearningInitial extends DetailedLearningState {
  const DetailedLearningInitial();

  @override
  List<Object> get props => [];
}

class DetailedLearningLoading extends DetailedLearningState {
  const DetailedLearningLoading();

  @override
  List<Object> get props => [];
}

class DetailedLearningDataLoaded extends DetailedLearningState {
  final List<Data> data;

  DetailedLearningDataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DetailedLearningError extends DetailedLearningState {
  final String message;

  const DetailedLearningError(this.message);

  @override
  List<Object> get props => [message];
}
