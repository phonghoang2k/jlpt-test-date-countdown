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
  int _page = 1;

  LearningMaterialCubit(this._repository) : super(LearningMaterialInitial()) {
    loadLearningData(_page);
  }

  List<Color> colorList = [...Colors.accents];
  List<String> subjects = ["Toán", "Lý", "Hóa", "Sinh", "Văn", "Anh", "Sử", "Địa", "GDCD"];
  List<String> subjectNoCapitals = ["toan", "ly", "hoa", "sinh", "van", "anh", "su", "dia", "gdcd"];

  Future<void> loadLearningData(int page) async {
    Map<String, dynamic> params = {"page": page};
    try {
      emit(LearningMaterialLoading());
      List<Data> data = await _repository.fetchLearningBaseOnParams(params);
      learningData = [...learningData, ...data];
      emit(LearningMaterialDataLoaded(learningData));
    } on NetworkException {
      emit(LearningMaterialError("Couldn't fetch data. Is the device online?"));
    }
  }

  Future<void> deleteMaterial(String id) async {
    Map<String, dynamic> params = {"id": id};
    try {
      emit(LearningMaterialDeleting());
      if (await _repository.deleteMaterial(params)) {
        emit(LearningMaterialDeleted());
      } else {
        emit(LearningMaterialError("Change failed"));
      }
    } on NetworkException {
      emit(LearningMaterialError("Error Changing data"));
    }
  }

  void pull() {
    ++_page;
    loadLearningData(_page);
  }

  void reset() {
    _page = 1;
  }
}
