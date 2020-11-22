import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'learning-material.state.dart';

class LearningMaterialCubit extends Cubit<LearningMaterialState> {
  LearningMaterialCubit() : super(LearningMaterialInitial());

  List<Color> colorList = [...Colors.accents]..shuffle();
  List<String> subjects = ["Toán", "Lý", "Hóa", "Sinh", "Văn", "Anh", "Sử", "Địa", "GDCD"];
}
