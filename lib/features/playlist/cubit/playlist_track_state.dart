part of 'playlist_track_cubit.dart';

@freezed
class PlaylistTrackState with _$PlaylistTrackState {
  const factory PlaylistTrackState.initial() = _Initial;
  const factory PlaylistTrackState.loading() = _Loading;
  const factory PlaylistTrackState.error({required String error}) = _Error;
  const factory PlaylistTrackState.tracklists({required List<Tracks> trackslist}) = _TracksList;
}
