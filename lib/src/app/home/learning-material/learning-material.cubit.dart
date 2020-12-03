import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/models/learning_data/learning_data.dart';
import 'package:jlpt_testdate_countdown/src/repositories/learning-material.repository.dart';
import 'package:jlpt_testdate_countdown/src/utils/exception.dart';

part 'learning-material.state.dart';

class LearningMaterialCubit extends Cubit<LearningMaterialState> {
  final LearningMaterialRepository _repository;
  List<Data> learningData = <Data>[];

  LearningMaterialCubit(this._repository) : super(LearningMaterialInitial()) {
    loadLearningData();
  }

  List<Color> colorList = [...Colors.accents]..shuffle();
  List<String> subjects = ["Toán", "Lý", "Hóa", "Sinh", "Văn", "Anh", "Sử", "Địa", "GDCD"];

  Future<void> loadLearningData() async {
    try {
      emit(LearningMaterialLoading());
      learningData = await _repository.fetchAllLearningMaterial();
      emit(LearningMaterialDataLoaded(learningData));
    } on NetworkException {
      emit(LearningMaterialError("Couldn't fetch data. Is the device online?"));
    }
  }
}
