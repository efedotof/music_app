part of 'playstop_music_cubit.dart';

@freezed
class PlaystopMusicState with _$PlaystopMusicState {
  const factory PlaystopMusicState.initial() = _Initial;
  const factory PlaystopMusicState.currentTrack({required List<Tracks> trackList,   required Tracks track}) =
      _CurrentTrack;
  const factory PlaystopMusicState.error({required String error}) = _Error;
  
}
