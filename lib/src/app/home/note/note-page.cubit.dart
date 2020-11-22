import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';

part 'note-page.state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial()) {
    emit(ColorChange(colorIndex));
    emit(EditMode());
  }

  List<String> headerList = Application.sharePreference.getStringList("header") ?? <String>[];
  List<String> bodyList = Application.sharePreference.getStringList("body") ?? <String>[];
  List<String> colorList = Application.sharePreference.getStringList("color") ?? <String>[];
  List<String> timeList = Application.sharePreference.getStringList("time") ?? <String>[];
  int colorIndex = 0;

  List<int> selectedIndex = <int>[];

  void changeSelectedIndex(int value) {
    if (!selectedIndex.contains(value)) {
      print("add $value");
      selectedIndex.add(value);
      print("list: $selectedIndex");
    } else {
      print("remove $value");
      selectedIndex.remove(value);
      print("list: $selectedIndex");
    }
    emit(ChangeSelectedIndex());
  }

  void addAll() {
    if(selectedIndex.length < headerList.length){
      for(int i = 0; i < headerList.length; i++){
        if (!selectedIndex.contains(i)) {
          print("add $i");
          selectedIndex.add(i);
          print("list: $selectedIndex");
        }
      }
    }else {
      selectedIndex.clear();
    }
    emit(ChangeSelectedIndex());
  }

  void setColorIndex(int value) {
    colorIndex = value;
    print(colorIndex);
    emit(ColorChange(colorIndex));
  }

  void addNote(Map<String, String> information, String time, String color) {
    headerList.add(information["header"]);
    Application.sharePreference.putStringList("header", headerList);
    bodyList.add(information["body"]);
    Application.sharePreference.putStringList("body", bodyList);
    timeList.add(time);
    Application.sharePreference.putStringList("time", timeList);
    colorList.add(color);
    Application.sharePreference.putStringList("color", colorList);
    emit(NoteCreate(information["header"], information["body"], time, color));
    emit(EditMode());
  }

  void deleteNode(int index) {
    headerList.removeAt(index);
    Application.sharePreference.putStringList("header", headerList);
    bodyList.removeAt(index);
    Application.sharePreference.putStringList("body", bodyList);
    colorList.removeAt(index);
    Application.sharePreference.putStringList("color", colorList);
    timeList.removeAt(index);
    Application.sharePreference.putStringList("time", timeList);
  }

  void deleteSelectedList() {
    selectedIndex.sort();
    for (int i = selectedIndex.length - 1; i >= 0; i--) {
      deleteNode(selectedIndex[i]);
    }
    emit(NoteDelete());
  }

  void changeToDeleteMode() {
    print("delete");
    print(selectedIndex);
    selectedIndex = <int>[];
    emit(DeleteMode());
  }

  void changeToEditMode() {
    print("edit");
    print(selectedIndex);
    emit(EditMode());
  }
}
