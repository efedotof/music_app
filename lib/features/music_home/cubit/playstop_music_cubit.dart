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
  Tracks? _currentTrack; 
  bool _isPaused = false; 
  List<Tracks> _playlist = []; 
  int _currentTrackIndex = 0; 

  PlaystopMusicCubit({required MusicRepository repository})
      : _repository = repository,
        audioPlayer = AudioPlayer(),
        super(const PlaystopMusicState.initial()) {
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.playing && _currentTrack != null) {
        emit(PlaystopMusicState.currentTrack(track: _currentTrack!));
      } else if (!playerState.playing && _currentTrack != null) {
        _isPaused = true; 
        emit(PlaystopMusicState.currentTrack(track: _currentTrack!));
      }


      if (playerState.processingState == ProcessingState.completed) {
        _playNextTrack();
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
              emit(const PlaystopMusicState.error(error: 'Ошибка загрузки трека.'));
            }
          } else {
            emit(const PlaystopMusicState.error(error: 'ID потока не найден.'));
          }
        } else {
          emit(const PlaystopMusicState.error(error: 'Метаданные трека не найдены.'));
        }
      } else {
        emit(const PlaystopMusicState.error(error: 'Ошибка загрузки метаданных трека.'));
      }
    } catch (e) {
      emit(PlaystopMusicState.error(error: e.toString()));
    }
  }


  Future<void> _playNextTrack() async {
    if (_playlist.isEmpty) return; 
    _currentTrackIndex = (_currentTrackIndex + 1) % _playlist.length; 
    final nextTrack = _playlist[_currentTrackIndex];
    await playTrack(nextTrack, nextTrack.id); 
  }


  void setPlaylist(List<Tracks> playlist) {
    _playlist = playlist; 
    _currentTrackIndex = 0; 
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
    emit(const PlaystopMusicState.initial()); 
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

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}