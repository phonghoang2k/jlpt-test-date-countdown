part of 'learning-material.cubit.dart';

@immutable
abstract class LearningMaterialState extends Equatable {
  const LearningMaterialState();
}

class LearningMaterialInitial extends LearningMaterialState {
  const LearningMaterialInitial();

  @override
  List<Object> get props => [];
}

class LearningMaterialLoading extends LearningMaterialState {
  const LearningMaterialLoading();

  @override
  List<Object> get props => [];
}

class LearningMaterialDataLoaded extends LearningMaterialState {
  final List<Data> data;

  LearningMaterialDataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class LearningMaterialDeleted extends LearningMaterialState {
  const LearningMaterialDeleted();

  @override
  List<Object> get props => [];
}

class LearningMaterialDeleting extends LearningMaterialState {
  const LearningMaterialDeleting();

  @override
  List<Object> get props => [];
}

class LearningMaterialError extends LearningMaterialState {
  final String message;

  const LearningMaterialError(this.message);

  @override
  List<Object> get props => [message];
}
