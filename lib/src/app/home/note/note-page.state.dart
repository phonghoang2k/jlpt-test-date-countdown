part of 'note-page.cubit.dart';

@immutable
abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  const NoteInitial();

  @override
  List<Object> get props => [];
}

class NoteLoading extends NoteState {
  const NoteLoading();

  @override
  List<Object> get props => [];
}

class NoteCreate extends NoteState {
  final String header, body, time, color;
  final List<Event> events;

  NoteCreate(this.header, this.body, this.time, this.color,{this.events});

  @override
  List<Object> get props => [header, body, time, color,events];
}

class NoteDelete extends NoteState {
  final  List<Event>events;
  NoteDelete(this.events);

  @override
  List<Object> get props => [events];
}

class ColorChange extends NoteState {
  final int colorIndex;

  ColorChange(this.colorIndex);

  @override
  List<Object> get props => [colorIndex];
}

class DeleteMode extends NoteState {
  const DeleteMode();

  @override
  List<Object> get props => [];
}

class EditMode extends NoteState {
  const EditMode();

  @override
  List<Object> get props => [];
}

class ChangeSelectedIndex extends NoteState {
  const ChangeSelectedIndex();

  @override
  List<Object> get props => [];
}

class ChangeSelectedEvent extends NoteState {
  final List<Event> events;
  const ChangeSelectedEvent(this.events);

  @override
  List<Object> get props => [events];
}