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
  final String header, body, time,color;

  NoteCreate(this.header, this.body, this.time, this.color);

  @override
  List<Object> get props => [header, body, time, color];
}

class NoteDelete extends NoteState {

  const NoteDelete();

  @override
  List<Object> get props => [];
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
