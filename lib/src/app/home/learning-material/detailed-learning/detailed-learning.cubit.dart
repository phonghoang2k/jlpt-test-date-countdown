import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/models/learning_data/learning_data.dart';
import 'package:jlpt_testdate_countdown/src/repositories/learning-material.repository.dart';
import 'package:jlpt_testdate_countdown/src/utils/exception.dart';

part 'detailed-learning.state.dart';

class DetailLearningCubit extends Cubit<DetailedLearningState> {
  final LearningMaterialRepository _repository;
  List<Data> learningData = <Data>[];

  DetailLearningCubit(this._repository) : super(DetailedLearningInitial());

  List<Color> colorList = [...Colors.accents];
  List<String> subjects = ["Toán", "Lý", "Hóa", "Sinh", "Văn", "Anh", "Sử", "Địa", "GDCD"];

  Future<void> loadLearningDataBaseOnParam({String subject, String type}) async {
    Map<String, dynamic> params = {"subject": subject, "type": type};
    try {
      emit(DetailedLearningLoading());
      learningData = await _repository.fetchLearningBaseOnParams(params);
      emit(DetailedLearningDataLoaded(learningData));
    } on NetworkException {
      emit(DetailedLearningError("Couldn't fetch data. Is the device online?"));
    }
  }
}
