part of 'track_favorite_cubit.dart';

@freezed
class TrackFavoriteState with _$TrackFavoriteState {
  const factory TrackFavoriteState.initial() = _Initial;
  const factory TrackFavoriteState.success() = _Success;
  const factory TrackFavoriteState.failure(String message) = _Failure;
}
