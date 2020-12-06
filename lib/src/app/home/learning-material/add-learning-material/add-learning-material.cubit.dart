import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/add-learning-material/type.dart';
import 'package:jlpt_testdate_countdown/src/repositories/learning-material.repository.dart';
import 'package:jlpt_testdate_countdown/src/utils/exception.dart';

part 'add-learning-material.state.dart';

class AddLearningCubit extends Cubit<AddLearningState> {
  final LearningMaterialRepository _repository;

  AddLearningCubit(this._repository) : super(AddLearningInitial());

  List<SubjectTypeConvert> subjectConvert = <SubjectTypeConvert>[
    SubjectTypeConvert(output: "toan", input: "Toán"),
    SubjectTypeConvert(output: "ly", input: "Lý"),
    SubjectTypeConvert(output: "hoa", input: "Hóa"),
    SubjectTypeConvert(output: "sinh", input: "Sinh"),
    SubjectTypeConvert(output: "gdcd", input: "GDCD"),
    SubjectTypeConvert(output: "van", input: "Văn"),
    SubjectTypeConvert(output: "anh", input: "Anh"),
    SubjectTypeConvert(output: "su", input: "Sử"),
    SubjectTypeConvert(output: "dia", input: "Địa"),
  ];
  List<SubjectTypeConvert> typeConvert = <SubjectTypeConvert>[
    SubjectTypeConvert(output: "de thi", input: "Đề thi"),
    SubjectTypeConvert(output: "tai lieu", input: "Tài liệu"),
  ];

  Future<void> createNewMaterial(Map<String, dynamic> data) async {
    Map<String, dynamic> params = {
      "name": data["name"],
      "link": data["link"],
      "linkavt": data["linkavt"],
      "source": data["source"],
      "subject": (data["subject"] as SubjectTypeConvert).output,
      "type": (data["subject"] as SubjectTypeConvert).output
    };
    try {
      emit(AddLearningDataSubmitting());
      if (await _repository.createMaterial(params)) {
        emit(AddLearningSubmitted());
      } else {
        emit(AddLearningError("Change failed"));
      }
    } on NetworkException {
      emit(AddLearningError("Error Changing data"));
    }
  }

  Future<void> editMaterial(Map<String, dynamic> data, {String id}) async {
    Map<String, dynamic> params = {
      "name": data["name"],
      "link": data["link"],
      "linkavt": data["linkavt"],
      "source": data["source"],
      "subject": (data["subject"] as SubjectTypeConvert).output,
      "type": (data["subject"] as SubjectTypeConvert).output
    };
    try {
      emit(AddLearningDataSubmitting());
      if (await _repository.editMaterial(id, params)) {
        emit(AddLearningSubmitted());
      } else {
        Fluttertoast.showToast(
          msg: "Thất bại",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        emit(AddLearningError("Change failed"));
      }
    } on NetworkException {
      emit(AddLearningError("Error Changing data"));
    }
  }
}
