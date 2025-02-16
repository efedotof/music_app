import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/music_model/tracks.dart';
import 'package:music_app/music_repository/music_repository.dart';

part 'playstop_music_state.dart';
part 'playstop_music_cubit.freezed.dart';

class PlaystopMusicCubit extends Cubit<PlaystopMusicState> {
  final MusicRepository _repository;
  final AudioPlayer audioPlayer;
  final List<Tracks> _playlist; 
  Tracks? _currentTrack;
  bool _isPaused = false;
  int _currentTrackIndex = 0;
  bool _isLooping = false;

  PlaystopMusicCubit({
    required MusicRepository repository,
    required List<Tracks>
        playlist, 
  })  : _repository = repository,
        _playlist = playlist,
        audioPlayer = AudioPlayer(),
        super(const PlaystopMusicState.initial()) {

    if (_playlist.isNotEmpty) {
      _currentTrack = _playlist[0]; 
    }

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.playing && _currentTrack != null) {
        emit(PlaystopMusicState.currentTrack(track: _currentTrack!));
      } else if (!playerState.playing && _currentTrack != null) {
        _isPaused = true;
        emit(PlaystopMusicState.currentTrack(track: _currentTrack!));
      }

      if (playerState.processingState == ProcessingState.completed) {
        if (_isLooping) {
          playTrack(_currentTrack!, _currentTrack!.id);
        } else {
          playNextTrack();
        }
      }
    });
  }

  Future<void> playTrack(Tracks track, String trackId) async {
    try {
      final tracksMeta = await _repository.fetchTracksFilezMeta([trackId]);

      if (tracksMeta['tracks'] != null && tracksMeta['tracks'].isNotEmpty) {
        final trackMeta = tracksMeta['tracks'].firstWhere(
          (track) => track['id'].toString() == trackId,
          orElse: () => null,
        );

        if (trackMeta != null) {
          final streamingId = trackMeta['streaming'];

          if (streamingId != null) {
            final trackUrl = await _repository.getTrackUrl(streamingId);

            debugPrint('Track URL: $trackUrl');

            if (trackUrl != null) {
              if (audioPlayer.playing) {
                await audioPlayer.stop();
              }

              await audioPlayer.setUrl(trackUrl);
              await audioPlayer.play();
              _isPaused = false;
              _currentTrack = track;
              emit(PlaystopMusicState.currentTrack(track: track));
            } else {
              emit(const PlaystopMusicState.error(
                  error: 'Ошибка загрузки трека.'));
            }
          } else {
            emit(const PlaystopMusicState.error(error: 'ID потока не найден.'));
          }
        } else {
          emit(const PlaystopMusicState.error(
              error: 'Метаданные трека не найдены.'));
        }
      } else {
        emit(const PlaystopMusicState.error(
            error: 'Ошибка загрузки метаданных трека.'));
      }
    } catch (e) {
      emit(PlaystopMusicState.error(error: e.toString()));
    }
  }

  Future<void> playNextTrack() async {
    if (_playlist.isEmpty || _currentTrack == null) return;
    if (_isLooping) {
      await playTrack(_currentTrack!, _currentTrack!.id);
    } else {
      _currentTrackIndex = (_currentTrackIndex + 1) % _playlist.length;
      final nextTrack = _playlist[_currentTrackIndex];
      _currentTrack = nextTrack; 
      await playTrack(nextTrack, nextTrack.id);
    }
  }

  Future<void> playPreviousTrack() async {
    if (_playlist.isEmpty || _currentTrack == null) return;
    _currentTrackIndex =
        (_currentTrackIndex - 1 + _playlist.length) % _playlist.length;
    final previousTrack = _playlist[_currentTrackIndex];
    _currentTrack = previousTrack; 
    await playTrack(previousTrack, previousTrack.id);
  }

  Future<void> pauseTrack() async {
    await audioPlayer.pause();
    _isPaused = true;
    emit(PlaystopMusicState.currentTrack(track: _currentTrack!));
  }

  Future<void> stopTrack() async {
    await audioPlayer.stop();
    _currentTrack = null; 
    _isPaused = false;
    emit(const PlaystopMusicState
        .initial()); 
  }

  Future<void> resumeTrack() async {
    if (_isPaused && _currentTrack != null) {
      final currentPosition = audioPlayer.position;
      await audioPlayer.seek(currentPosition);
      await audioPlayer.play();
      _isPaused = false;
      emit(PlaystopMusicState.currentTrack(track: _currentTrack!));
    }
  }

  bool getStopOrPlay() {
    return audioPlayer.playing;
  }

  void toggleLoop() {
    _isLooping = !_isLooping;
    emit(PlaystopMusicState.currentTrack(track: _currentTrack!));
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
