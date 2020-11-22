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

// class LearningMaterialImage extends LearningMaterialState {
//   final AssetImage image;
//
//   LearningMaterialImage(this.image);
//
//   @override
//   List<Object> get props => [image];
// }
