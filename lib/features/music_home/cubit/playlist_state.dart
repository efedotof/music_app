part of 'playlist_cubit.dart';

@freezed
class PlaylistState with _$PlaylistState {
  const factory PlaylistState.initial() = _Initial;
  const factory PlaylistState.loading() = _Loading;
  const factory PlaylistState.error({required String error}) = _Error;
  const factory PlaylistState.playlistsLoaded({required List<Playlist> playlists}) = _PlaylistLoaded;
}
