import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/models/event/event.dart';

part 'note-page.state.dart';

class NoteCubit extends Cubit<NoteState> {
  List<String> headerList = <String>[];
  List<String> bodyList = <String>[];
  List<String> colorList = <String>[];
  List<String> timeList = <String>[];
  int colorIndex = 0;
  Map<DateTime, List<Event>> events = <DateTime, List<Event>>{};
  DateTime selectedDay;
  List<Event> selectedEvents = [];
  List<int> selectedIndex = <int>[];

  NoteCubit() : super(NoteInitial()) {
    emit(ColorChange(colorIndex));
    emit(EditMode());
    print("init NoteCubit");
    headerList = Application.sharePreference.getStringList("header") ?? <String>[];
    bodyList = Application.sharePreference.getStringList("body") ?? <String>[];
    colorList = Application.sharePreference.getStringList("color") ?? <String>[];
    timeList = Application.sharePreference.getStringList("time") ?? <String>[];
    for (int i = 0; i < headerList.length; i++) {
      events[DateTime.parse(timeList[i])] != null
          ? events[DateTime.parse(timeList[i])]
          .add(Event(header: headerList[i], body: bodyList[i], color: int.parse(colorList[i]), index: i))
          : events.putIfAbsent(DateTime.parse(timeList[i]),
              () => [Event(header: headerList[i], body: bodyList[i], color: int.parse(colorList[i]), index: i)]);
    }
    selectedDay = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, DateTime
        .now()
        .day);
    selectedEvents = events[selectedDay];
  }

  void setSelectedEvent(DateTime day) {
    selectedDay = day;
    selectedEvents = events[day];
    emit(ChangeSelectedEvent(selectedEvents));
  }

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
    if (selectedIndex.length < headerList.length) {
      for (int i = 0; i < headerList.length; i++) {
        if (!selectedIndex.contains(i)) {
          print("add $i");
          selectedIndex.add(i);
          print("list: $selectedIndex");
        }
      }
    } else {
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
    print("$information, $time, $color");
    headerList.add(information["header"]);
    Application.sharePreference.putStringList("header", headerList);
    bodyList.add(information["body"]);
    Application.sharePreference.putStringList("body", bodyList);
    timeList.add(time);
    Application.sharePreference.putStringList("time", timeList);
    colorList.add(color);
    Application.sharePreference.putStringList("color", colorList);
    events[DateTime.parse(time)] != null
        ? events[DateTime.parse(time)].add(Event(
        header: information["header"],
        body: information["body"],
        color: int.parse(color),
        index: bodyList.length - 1))
        : events.putIfAbsent(
        DateTime.parse(time),
            () =>
        [
          Event(
              header: information["header"],
              body: information["body"],
              color: int.parse(color),
              index: bodyList.length - 1)
        ]);
    selectedEvents = events[selectedDay];
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
    events = <DateTime, List<Event>>{};
    for (int i = 0; i < headerList.length; i++) {
      events[DateTime.parse(timeList[i])] != null
          ? events[DateTime.parse(timeList[i])]
          .add(Event(header: headerList[i], body: bodyList[i], color: int.parse(colorList[i]), index: i))
          : events.putIfAbsent(DateTime.parse(timeList[i]),
              () => [Event(header: headerList[i], body: bodyList[i], color: int.parse(colorList[i]), index: i)]);
    }
    emit(NoteDelete(events));
  }

  void changeToDeleteMode() {
    print("delete");
    selectedIndex = <int>[];
    emit(DeleteMode());
  }

  void changeToEditMode() {
    print("edit");
    print(selectedIndex);
    emit(EditMode());
  }
}
