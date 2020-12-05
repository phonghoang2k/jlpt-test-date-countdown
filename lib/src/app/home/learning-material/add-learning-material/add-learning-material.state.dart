part of 'add-learning-material.cubit.dart';

@immutable
abstract class AddLearningState extends Equatable {
  const AddLearningState();
}

class AddLearningInitial extends AddLearningState {
  const AddLearningInitial();

  @override
  List<Object> get props => [];
}

class AddLearningSubmitted extends AddLearningState {
  const AddLearningSubmitted();

  @override
  List<Object> get props => [];
}

class AddLearningDataSubmitting extends AddLearningState {
  const AddLearningDataSubmitting();

  @override
  List<Object> get props => [];
}

class AddLearningError extends AddLearningState {
  final String message;

  const AddLearningError(this.message);

  @override
  List<Object> get props => [message];
}
