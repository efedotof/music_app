import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'playback_state.dart';
part 'playback_cubit.freezed.dart';

class PlaybackCubit extends Cubit<PlaybackState> {
  PlaybackCubit() : super(PlaybackState.stopped());
   void play() {
    emit(const PlaybackState.playing());
  }

  void pause() {
    emit(const PlaybackState.paused());
  }

  bool isPlaying() {
    return state.maybeWhen(
      playing: () => true,
      orElse: () => false,
    );
  }
}
