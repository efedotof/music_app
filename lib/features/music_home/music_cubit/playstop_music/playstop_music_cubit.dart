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
  int _currentTrackIndex = 0;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  Duration? _trackDuration;

  PlaystopMusicCubit({required this.audioHandler})
      : super(const PlaystopMusicState.initial()) {
    _listenToPositionStream();
  }

  void _listenToPositionStream() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();

    _durationSubscription = audioHandler.durationStream.listen((duration) {
      _trackDuration = duration;
    });

    _positionSubscription = audioHandler.positionStream.listen((position) {
      if (_trackDuration != null &&
          position.inMilliseconds >= _trackDuration!.inMilliseconds - 200) {
        playNextTrack();
      }
    });
  }

  Future<void> playTrack(
      {required List<Tracks> playlist, required Tracks track}) async {
    try {
      _playlist = playlist;
      _currentTrackIndex = playlist.indexOf(track);
      debugPrint("открываем текущий трек в нижнем меню");

      emit(PlaystopMusicState.currentTrack(
        trackList: _playlist,
        track: _playlist[_currentTrackIndex],
      ));

      await audioHandler.loadPlaylist(_playlist);
      await audioHandler.seek(Duration.zero);

      _listenToPositionStream();

      final isLocalFile = File(track.id).existsSync();
      if (isLocalFile) {
        await audioHandler.playLocalFile(track.id);
      } else {
        await audioHandler.play();
      }
    } catch (e) {
      emit(PlaystopMusicState.error(error: e.toString()));
    }
  }

  Future<void> playNextTrack() async {
    if (_playlist.isEmpty) return;

    _currentTrackIndex = (_currentTrackIndex + 1) % _playlist.length;

    final nextTrack = _playlist[_currentTrackIndex];
    final isLocalFile = File(nextTrack.id).existsSync();

    emit(PlaystopMusicState.currentTrack(
      trackList: _playlist,
      track: nextTrack,
    ));

    if (isLocalFile) {
      await audioHandler.playLocalFile(nextTrack.id);
    } else {
      await audioHandler.skipToNext();
    }
  }

  Future<void> playPreviousTrack() async {
    if (_playlist.isEmpty) return;

    _currentTrackIndex =
        (_currentTrackIndex - 1 + _playlist.length) % _playlist.length;

    final prevTrack = _playlist[_currentTrackIndex];
    final isLocalFile = File(prevTrack.id).existsSync();

    emit(PlaystopMusicState.currentTrack(
      trackList: _playlist,
      track: prevTrack,
    ));

    if (isLocalFile) {
      await audioHandler.playLocalFile(prevTrack.id);
    } else {
      await audioHandler.skipToPrevious();
    }
  }

  Future<void> pauseTrack() async {
    await audioHandler.pause();

    emit(PlaystopMusicState.currentTrack(
      trackList: _playlist,
      track: _playlist[_currentTrackIndex],
    ));
  }

  Future<void> resumeTrack() async {
    await audioHandler.play();

    emit(PlaystopMusicState.currentTrack(
      trackList: _playlist,
      track: _playlist[_currentTrackIndex],
    ));
  }

  Future<void> stopTrack() async {
    await audioHandler.stop();
    emit(const PlaystopMusicState.initial());
  }

  void toggleLoop() {
    audioHandler.toggleLoop();
    emit(PlaystopMusicState.currentTrack(
      trackList: _playlist,
      track: _playlist[_currentTrackIndex],
    ));
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _durationSubscription?.cancel();
    await audioHandler.close();
    return super.close();
  }

  Future<void> playLocalFiles(
      {required List<Tracks> filePaths, required String filePath}) async {
    try {
      if (filePaths.isEmpty) return;
      _playlist = List<Tracks>.from(filePaths);

      _currentTrackIndex =
          _playlist.indexWhere((track) => track.id == filePath);
      if (_currentTrackIndex == -1) {
        _currentTrackIndex = 0;
      }
      emit(PlaystopMusicState.currentTrack(
        trackList: _playlist,
        track: _playlist[_currentTrackIndex],
      ));
      await audioHandler.loadPlaylist(_playlist);
      await audioHandler.playLocalFile(_playlist[_currentTrackIndex].id);
    } catch (e) {
      emit(PlaystopMusicState.error(error: e.toString()));
    }
  }
}
