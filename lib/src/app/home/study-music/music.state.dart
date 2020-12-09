part of 'music.cubit.dart';

@immutable
abstract class MusicState extends Equatable {
  const MusicState();
}

class MusicInitial extends MusicState {
  const MusicInitial();

  @override
  List<Object> get props => [];
}

class MusicLoading extends MusicState {
  const MusicLoading();

  @override
  List<Object> get props => [];
}

class MusicImage extends MusicState {
  final AssetImage image;
  MusicImage(this.image);

  @override
  List<Object> get props => [image];
}

class MusicSong extends MusicState {
  final Music song;

  MusicSong(this.song);

  @override
  List<Object> get props => [song];
}
