import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/type.dart';
import 'package:jlpt_testdate_countdown/src/models/learning_data/learning_data.dart';
import 'package:jlpt_testdate_countdown/src/repositories/learning-material.repository.dart';
import 'package:jlpt_testdate_countdown/src/utils/exception.dart';

part 'detailed-learning.state.dart';

class DetailLearningCubit extends Cubit<DetailedLearningState> {
  final LearningMaterialRepository _repository;
  final Params params;
  List<Data> learningData = <Data>[];
  int _take = 5;

  DetailLearningCubit(this._repository, {this.params}) : super(DetailedLearningInitial()) {
    loadLearningDataBaseOnParam(subject: params.subject, type: params.type, take: _take);
  }

  List<Color> colorList = [...Colors.accents];
  List<String> subjects = ["Toán", "Lý", "Hóa", "Sinh", "Văn", "Anh", "Sử", "Địa", "GDCD"];

  Future<void> loadLearningDataBaseOnParam({String subject, String type, int take}) async {
    Map<String, dynamic> params = {"subject": subject, "type": type, "take": take};
    try {
      emit(DetailedLearningLoading());
      learningData = await _repository.fetchLearningBaseOnParams(params);
      emit(DetailedLearningDataLoaded(learningData));
    } on NetworkException {
      emit(DetailedLearningError("Couldn't fetch data. Is the device online?"));
    }
  }

  void pull() {
    _take += 5;
    loadLearningDataBaseOnParam(subject: params.subject, type: params.type, take: _take);
  }

  void reset() {
    _take = 5;
  }
}
