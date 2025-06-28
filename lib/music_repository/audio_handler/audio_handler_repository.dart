import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/music_repository/music/music_repository.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

import 'audio_handler_interface.dart';

class AudioHandlerRepository extends BaseAudioHandler
    with QueueHandler, SeekHandler
    implements AudioHandlerInterface {
  final _player = AudioPlayer();
  final MusicRepository _repository;

  List<Tracks> _playlist = [];
  int _currentTrackIndex = 0;
  bool _isPaused = false;
  bool _isLooping = false;

  final _currentTrackController = StreamController<Tracks>.broadcast();

  AudioHandlerRepository({required MusicRepository repository})
      : _repository = repository {
    _init();

    // Добавляем слушатель для очереди
    queue.stream.listen((queue) {
      _logQueueContent(queue);
    });
  }

  // Метод для логирования содержимого очереди
  void _logQueueContent(List<MediaItem> queue) {
    if (queue.isEmpty) {
      debugPrint('📭 Очередь уведомления ПУСТА');
      return;
    }

    debugPrint('📋 Содержимое очереди уведомления (${queue.length} треков):');
    for (int i = 0; i < queue.length; i++) {
      final item = queue[i];
      final isCurrent = (mediaItem.value?.id == item.id) ? ' [ТЕКУЩИЙ]' : '';
      debugPrint('  ${i + 1}. ${item.title} - ${item.artist}$isCurrent');
    }
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

    _updateControls();
  }

  @override
  Stream<Tracks> get currentTrackStream => _currentTrackController.stream;

  @override
  Stream<Duration> get positionStream => _player.positionStream;
  @override
  Stream<Duration?> get durationStream => _player.durationStream;

  Object _mediaControlToString(MediaControl control) {
    switch (control.action) {
      case MediaAction.play:
        return 'PLAY';
      case MediaAction.pause:
        return 'PAUSE';
      case MediaAction.stop:
        return 'STOP';
      case MediaAction.skipToNext:
        return 'SKIP_TO_NEXT';
      case MediaAction.skipToPrevious:
        return 'SKIP_TO_PREVIOUS';
      case MediaAction.fastForward:
        return 'FAST_FORWARD';
      case MediaAction.rewind:
        return 'REWIND';
      default:
        return control.action;
    }
  }

  void _updateControls() {
    final controlsList = [
      MediaControl.skipToPrevious,
      _player.playing ? MediaControl.pause : MediaControl.play,
      MediaControl.stop,
      MediaControl.skipToNext,
    ];

    final controlsString = controlsList.map(_mediaControlToString).join(', ');
    debugPrint('🎛️ Список MediaControl: [$controlsString]');
    debugPrint('🔄 Обновление контролов уведомления: '
        'Playing: ${_player.playing}, '
        'Index: $_currentTrackIndex');

    playbackState.add(playbackState.value.copyWith(
      controls: controlsList,
      androidCompactActionIndices: const [0, 1, 3],
      processingState: {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    ));
  }

  void _broadcastState(PlaybackEvent event) {
    _updateControls();
  }

  Future<void> _playCurrentTrack() async {
    if (_playlist.isEmpty || _currentTrackIndex >= _playlist.length) {
      debugPrint('❌ Плейлист пуст или индекс за пределами.');
      return;
    }

    final track = _playlist[_currentTrackIndex];
    debugPrint('▶️ Проигрываю трек: ${track.track} (${track.id})');

    final meta = await _fetchTrackMeta(track.id);
    if (meta == null) {
      debugPrint('❌ Метаданные не найдены для трека: ${track.id}');
      return;
    }

    final url = await _repository.getTrackUrl(meta['streaming']);
    if (url == null || url.isEmpty) {
      debugPrint('❌ URL не получен или пустой для трека: ${track.id}');
      return;
    }

    try {
      final item = MediaItem(
        id: track.id,
        title: track.track,
        artist: track.artistName,
        artUri: Uri.tryParse(track.imageWebp),
      );

      mediaItem.add(item);
      queue.add([item]); // Здесь обновляется очередь

      await _player.setUrl(url);
      _currentTrackController.add(track);
      await _player.play();
      _updateControls();
      debugPrint('✅ Воспроизведение начато: $url');
    } catch (e, st) {
      debugPrint('❌ Ошибка при воспроизведении: $e');
      debugPrint(st.toString());
    }
  }

  Future<Map<String, dynamic>?> _fetchTrackMeta(String id) async {
    final meta = await _repository.fetchTracksFilezMeta([id]);
    return meta['tracks']
        ?.firstWhere((t) => t['id'].toString() == id, orElse: () => null);
  }

  @override
  Future<void> loadPlaylist(List<Tracks> tracks) async {
    _playlist = tracks;
    _currentTrackIndex = 0;
    await _playCurrentTrack();
  }

  @override
  Future<void> play() async {
    if (_isPaused) {
      await _player.play();
    } else if (!_player.playing) {
      await _playCurrentTrack();
    }
    _isPaused = false;
    _updateControls();
  }

  @override
  Future<void> pause() async {
    _isPaused = true;
    await _player.pause();
    _updateControls();
  }

  @override
  Future<void> stop() async {
    _isPaused = false;
    await _player.stop();
    _updateControls();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
    _updateControls();
  }

  @override
  Future<void> skipToNext() async {
    if (_playlist.isEmpty) return;
    _currentTrackIndex = (_currentTrackIndex + 1) % _playlist.length;
    debugPrint('⏭ Переход к следующему треку: $_currentTrackIndex');
    await _playCurrentTrack();
  }

  @override
  Future<void> skipToPrevious() async {
    if (_playlist.isEmpty) return;
    _currentTrackIndex =
        (_currentTrackIndex - 1 + _playlist.length) % _playlist.length;
    debugPrint('⏮ Переход к предыдущему треку: $_currentTrackIndex');
    await _playCurrentTrack();
  }

  @override
  Future<void> playLocalFile(String filePath) async {
    await _player.setFilePath(filePath);
    _currentTrackController.add(_playlist[_currentTrackIndex]);
    await _player.play();
    _isPaused = false;
    _updateControls();
  }

  @override
  void toggleLoop() {
    _isLooping = !_isLooping;
  }

  @override
  Future<void> close() async {
    await _currentTrackController.close();
    await _player.dispose();
    // ignore: deprecated_member_use
    await AudioService.stop();
  }

  @override
  Future<void> onPlay() {
    debugPrint('🟢 onPlay() вызван - кнопка PLAY в уведомлении');
    return play();
  }

  @override
  Future<void> onPause() {
    debugPrint('🟠 onPause() вызван - кнопка PAUSE в уведомлении');
    return pause();
  }

  @override
  Future<void> onStop() {
    debugPrint('🔴 onStop() вызван - кнопка STOP в уведомлении');
    return stop();
  }

  @override
  Future<void> onSkipToNext() {
    debugPrint('⏭ onSkipToNext() вызван - кнопка NEXT в уведомлении');
    return skipToNext();
  }

  @override
  Future<void> onSkipToPrevious() {
    debugPrint('⏮ onSkipToPrevious() вызван - кнопка PREV в уведомлении');
    return skipToPrevious();
  }
}
