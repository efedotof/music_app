part of 'music_cubit.dart';

@freezed
class MusicState with _$MusicState {
  const factory MusicState.initial() = _Initial;
  const factory MusicState.loading() = _Loading;
  const factory MusicState.loaded({required List<Tracks> tracks}) = _Loaded;
  const factory MusicState.error({required String error}) = _Error;
}
