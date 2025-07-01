part of 'music_cubit.dart';

@freezed
class MusicState with _$MusicState {
  const factory MusicState.initial() = _Initial;
  const factory MusicState.loading() = _Loading;
  const factory MusicState.tracksScreen({required List<Tracks> tracks}) =
      _Loaded;
  const factory MusicState.error({required String error}) = _Error;
  const factory MusicState.playListScreen({required List<Playlist> playlists}) =
      _PlayListScreen;

  const factory MusicState.globalScreen(
      {required List<Tracks> traks,
      required List<Playlist> playlists}) = _GlobalScreen;
}
