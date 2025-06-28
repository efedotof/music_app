import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/music_repository/audio_handler/audio_handler_interface.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

part 'playstop_music_state.dart';
part 'playstop_music_cubit.freezed.dart';

class PlaystopMusicCubit extends Cubit<PlaystopMusicState> {
  final AudioHandlerInterface audioHandler;
  List<Tracks> _playlist = [];
  late final StreamSubscription<Tracks> _trackSub;
  late final StreamSubscription<Duration> _positionSub;
  late final StreamSubscription<Duration?> _durationSub;
  Duration? _trackDuration;

  PlaystopMusicCubit({required this.audioHandler})
      : super(const PlaystopMusicState.initial()) {
    _positionSub = audioHandler.positionStream.listen(_onPosition);
    _durationSub =
        audioHandler.durationStream.listen((d) => _trackDuration = d);
    _trackSub = audioHandler.currentTrackStream.listen((track) {
      emit(PlaystopMusicState.currentTrack(trackList: _playlist, track: track));
    });
  }

  void _onPosition(Duration position) {
    if (_trackDuration != null &&
        position.inMilliseconds >= _trackDuration!.inMilliseconds - 200) {
      if (_trackDuration!.inMilliseconds > 0 &&
          position.inMilliseconds <= _trackDuration!.inMilliseconds + 1000) {
        debugPrint('🔁 Автоматический переход к следующему треку');
        audioHandler.skipToNext();
      }
    }
  }

  Future<void> playTrack(
      {required List<Tracks> playlist, required Tracks track}) async {
    try {
      _playlist = playlist;
      await audioHandler.loadPlaylist(playlist);
      await audioHandler.seek(Duration.zero);

      final isLocal = File(track.id).existsSync();
      if (isLocal) {
        await audioHandler.playLocalFile(track.id);
      } else {
        await audioHandler.play();
      }
    } catch (e) {
      emit(PlaystopMusicState.error(error: e.toString()));
    }
  }

  Future<void> playNextTrack() => audioHandler.skipToNext();
  Future<void> playPreviousTrack() => audioHandler.skipToPrevious();
  Future<void> pauseTrack() => audioHandler.pause();
  Future<void> resumeTrack() => audioHandler.play();
  Future<void> stopTrack() => audioHandler.stop();
  void toggleLoop() => audioHandler.toggleLoop();

  @override
  Future<void> close() async {
    await _positionSub.cancel();
    await _durationSub.cancel();
    await _trackSub.cancel();
    await audioHandler.close();
    return super.close();
  }
}
