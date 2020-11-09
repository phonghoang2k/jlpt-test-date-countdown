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
  final String header, body, time;
  final Color colorHeader, colorBody;

  NoteCreate(this.header, this.body, this.time, this.colorHeader, this.colorBody);

  @override
  List<Object> get props => [header, body, time, colorHeader, colorBody];
}
