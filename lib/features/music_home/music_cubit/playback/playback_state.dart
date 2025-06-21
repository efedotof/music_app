part of 'playback_cubit.dart';

@freezed
class PlaybackState with _$PlaybackState {
   const factory PlaybackState.stopped() = Stopped;
  const factory PlaybackState.playing() = Playing;
  const factory PlaybackState.paused() = Paused;
}
