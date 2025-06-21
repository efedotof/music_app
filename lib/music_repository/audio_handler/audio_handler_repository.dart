import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/music_repository/music/music_repository.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

import 'audio_handler_interface.dart';

class AudioHandlerRepository extends BaseAudioHandler
    implements AudioHandlerInterface {
  final _player = AudioPlayer();
  final MusicRepository _repository;

  List<Tracks> _playlist = [];
  int _currentTrackIndex = 0;
  bool _isPaused = false;
  bool _isLooping = false;
  Duration _lastPosition = Duration.zero;

  AudioHandlerRepository({required MusicRepository repository})
      : _repository = repository {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    _player.playbackEventStream.listen(_broadcastState);

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (_isLooping) {
          _player.seek(Duration.zero);
          _player.play();
        } else {
          skipToNext();
        }
      }
    });

    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        _player.playing ? MediaControl.pause : MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [1, 2, 3],
    ));
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(playbackState.value.copyWith(
      playing: _player.playing,
      controls: [
        MediaControl.skipToPrevious,
        _player.playing ? MediaControl.pause : MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      processingState: {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    ));
  }

  @override
  Future<void> loadPlaylist(List<Tracks> tracks) async {
    _playlist = tracks;
    _currentTrackIndex = 0;
    await _playCurrentTrack();
  }

  Future<void> _playCurrentTrack() async {
    if (_playlist.isEmpty) return;

    final currentTrack = _playlist[_currentTrackIndex];
    final trackMeta = await _fetchTrackMeta(currentTrack.id);

    if (trackMeta != null) {
      final url = await _repository.getTrackUrl(trackMeta['streaming']);
      if (url != null) {
        mediaItem.add(MediaItem(
          id: currentTrack.id,
          title: currentTrack.track,
          artist: currentTrack.artistName,
          artUri: Uri.tryParse(trackMeta['artwork'] ?? ''),
        ));
        await _player.setUrl(url);
        if (_isPaused && _lastPosition != Duration.zero) {
          await _player.seek(_lastPosition);
        }
        await _player.play();
        _isPaused = false;
      }
    }
  }

  Future<Map<String, dynamic>?> _fetchTrackMeta(String id) async {
    final meta = await _repository.fetchTracksFilezMeta([id]);
    return meta['tracks']?.firstWhere(
      (t) => t['id'].toString() == id,
      orElse: () => null,
    );
  }

  @override
  Future<void> handlePlay() => play();

  @override
  Future<void> handlePause() => pause();

  @override
  Future<void> handleStop() => stop();

  @override
  Future<void> handleSkipToNext() => skipToNext();

  @override
  Future<void> handleSkipToPrevious() => skipToPrevious();

  @override
  Future<void> handleSeek(Duration position) => seek(position);

  @override
  Future<void> play() async {
    if (_isPaused && _lastPosition != Duration.zero) {
      await _player.seek(_lastPosition);
    }
    await _player.play();
    _isPaused = false;
  }

  @override
  Future<void> pause() async {
    _lastPosition = _player.position;
    await _player.pause();
    _isPaused = true;
  }

  @override
  Future<void> stop() async {
    _lastPosition = Duration.zero;
    await _player.stop();
    _isPaused = false;
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() async {
    if (_playlist.isEmpty) return;
    _currentTrackIndex = (_currentTrackIndex + 1) % _playlist.length;
    await _playCurrentTrack();
  }

  @override
  Future<void> skipToPrevious() async {
    if (_playlist.isEmpty) return;
    _currentTrackIndex =
        (_currentTrackIndex - 1 + _playlist.length) % _playlist.length;
    await _playCurrentTrack();
  }

  @override
  void toggleLoop() {
    _isLooping = !_isLooping;
  }

  @override
  Future<void> playLocalFile(String filePath) async {
    try {
      await _player.setFilePath(filePath);
      await _player.play();
      _isPaused = false;
    } catch (e) {
      debugPrint("Ошибка при воспроизведении локального файла: $e");
    }
  }

  @override
  Future<void> close() async {
    await _player.dispose();
    await AudioService.stop();
  }

  @override
  Stream<Duration> get positionStream => _player.positionStream;

  @override
  Stream<Duration?> get durationStream => _player.durationStream;
}
