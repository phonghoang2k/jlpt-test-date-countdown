
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note-page.state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial()) {}

  void addNote(Map<String, String> information, String time, Color colorHeader, Color colorBody) {
    emit(NoteCreate(information["header"], information["body"], time, colorHeader, colorBody));
  }
}
