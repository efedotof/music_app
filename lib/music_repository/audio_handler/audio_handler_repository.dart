import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/music_repository/logger_service/logger_service.dart';
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
  bool _isShuffling = false;
  List<int> _shuffleIndices = [];
  Duration? _lastPosition;
  Completer<void>? _stopCompleter;

  final _currentTrackController = StreamController<Tracks>.broadcast();

  AudioHandlerRepository({required MusicRepository repository})
      : _repository = repository {
    _init();
    queue.stream.listen((queue) {
      _logQueueContent(queue);
    });
  }

  void _logQueueContent(List<MediaItem> queue) {
    if (queue.isEmpty) {
      LogService.log('📭 Очередь уведомления ПУСТА');
      return;
    }

    LogService.log(
        '📋 Содержимое очереди уведомления (${queue.length} треков):');
    for (int i = 0; i < queue.length; i++) {
      final item = queue[i];
      final isCurrent = (mediaItem.value?.id == item.id) ? ' [ТЕКУЩИЙ]' : '';
      LogService.log('  ${i + 1}. ${item.title} - ${item.artist}$isCurrent');
    }
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    _player.playbackEventStream.listen(_broadcastState);
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed && !_isPaused) {
        if (_isLooping) {
          _player.seek(Duration.zero);
          _player.play();
        } else {
          skipToNext();
        }
      }

      // Обработка завершения остановки
      if (_stopCompleter != null &&
          state.processingState == ProcessingState.idle) {
        _stopCompleter?.complete();
        _stopCompleter = null;
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

  void _updateControls() {
    final controlsList = [
      MediaControl.skipToPrevious,
      if (_player.playing) MediaControl.pause else MediaControl.play,
      MediaControl.stop,
      MediaControl.skipToNext,
    ];

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
      queueIndex: _currentTrackIndex,
      systemActions: {
        MediaAction.play,
        MediaAction.pause,
        MediaAction.stop,
        MediaAction.skipToNext,
        MediaAction.skipToPrevious,
        MediaAction.seek,
      },
    ));
  }

  void _broadcastState(PlaybackEvent event) {
    _updateControls();
  }

  Future<void> _playCurrentTrack({Duration? seekPosition}) async {
    if (_playlist.isEmpty || _currentTrackIndex >= _playlist.length) {
      LogService.log('❌ Плейлист пуст или индекс за пределами.');
      return;
    }

    final effectiveIndex =
        _isShuffling ? _shuffleIndices[_currentTrackIndex] : _currentTrackIndex;

    final track = _playlist[effectiveIndex];
    LogService.log('▶️ Проигрываю трек: ${track.track} (${track.id})');

    try {
      final meta = await _fetchTrackMeta(track.id);
      if (meta == null) {
        LogService.log('❌ Метаданные не найдены для трека: ${track.id}');
        return;
      }

      final url = await _repository.getTrackUrl(meta['streaming']);
      if (url == null || url.isEmpty) {
        LogService.log('❌ URL не получен или пустой для трека: ${track.id}');
        return;
      }

      final item = MediaItem(
        id: track.id,
        title: track.track,
        artist: track.artistName,
        artUri: Uri.tryParse(track.imageWebp),
      );

      queue.add([item]);
      mediaItem.add(item);
      playbackState.add(playbackState.value.copyWith(
        queueIndex: 0,
      ));

      await _player.setUrl(url);
      _currentTrackController.add(track);

      final positionToSeek = seekPosition ?? _lastPosition;
      if (positionToSeek != null) {
        await _player.seek(positionToSeek);
        _lastPosition = null;
      }

      await _player.play();
      _updateControls();

      LogService.log('✅ Воспроизведение начато: $url');
    } catch (e, st) {
      LogService.error('❌ Ошибка при воспроизведении', e, st);
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
    _shuffleIndices = List.generate(_playlist.length, (i) => i)..shuffle();
    await _playCurrentTrack();
  }

  @override
  Future<void> play() async {
    try {
      if (_isPaused) {
        await _player.play();
        _isPaused = false;
      } else if (!_player.playing) {
        await _playCurrentTrack(seekPosition: _lastPosition);
      }
      _updateControls();
    } catch (e, st) {
      LogService.error('Ошибка в методе play()', e, st);
    }
  }

  @override
  Future<void> pause() async {
    try {
      _isPaused = true;
      await _player.pause();
      _updateControls();
    } catch (e, st) {
      LogService.error('Ошибка в методе pause()', e, st);
    }
  }

  @override
  Future<void> stop() async {
    try {
      _lastPosition = _player.position;
      LogService.log('⏹ Сохранена позиция: $_lastPosition');

      // Ждем полной остановки плеера
      _stopCompleter = Completer<void>();
      await _player.stop();
      await _stopCompleter?.future;

      _isPaused = false;
      _updateControls();
    } catch (e, st) {
      LogService.error('Ошибка в методе stop()', e, st);
    }
  }

  @override
  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
      _updateControls();
    } catch (e, st) {
      LogService.error('Ошибка в методе seek()', e, st);
    }
  }

  @override
  Future<void> skipToNext() async {
    try {
      if (_playlist.isEmpty) return;
      _currentTrackIndex = (_currentTrackIndex + 1) % _playlist.length;
      LogService.log('⏭ Переход к следующему треку: $_currentTrackIndex');
      await _playCurrentTrack();
    } catch (e, st) {
      LogService.error('Ошибка в методе skipToNext()', e, st);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    try {
      if (_playlist.isEmpty) return;
      _currentTrackIndex =
          (_currentTrackIndex - 1 + _playlist.length) % _playlist.length;
      LogService.log('⏮ Переход к предыдущему треку: $_currentTrackIndex');
      await _playCurrentTrack();
    } catch (e, st) {
      LogService.error('Ошибка в методе skipToPrevious()', e, st);
    }
  }

  @override
  Future<void> playLocalFile(String filePath) async {
    try {
      await _player.setFilePath(filePath);
      _currentTrackController.add(_playlist[_currentTrackIndex]);
      await _player.play();
      _isPaused = false;
      _updateControls();
    } catch (e, st) {
      LogService.error('Ошибка при воспроизведении локального файла', e, st);
    }
  }

  @override
  void toggleLoop() {
    _isLooping = !_isLooping;
    LogService.log('🔁 Режим повтора: $_isLooping');
  }

  @override
  void toggleShuffle() {
    _isShuffling = !_isShuffling;
    if (_isShuffling) {
      _shuffleIndices = List.generate(_playlist.length, (i) => i)..shuffle();
      LogService.log(
          '🔀 Режим перемешивания включен. Новый порядок: $_shuffleIndices');
    } else {
      LogService.log(
          '➡️ Режим перемешивания выключен. Восстановлен обычный порядок.');
    }
  }

  @override
  Future<void> close() async {
    await _currentTrackController.close();
    await _player.dispose();
    await AudioService.stop();
    LogService.log('🛑 Аудио-сервис закрыт');
  }

  @override
  Future<void> onPlay() {
    LogService.log('🟢 onPlay() вызван - кнопка PLAY в уведомлении');
    return play();
  }

  @override
  Future<void> onPause() {
    LogService.log('🟠 onPause() вызван - кнопка PAUSE в уведомлении');
    return pause();
  }

  @override
  Future<void> onStop() {
    LogService.log('🔴 onStop() вызван - кнопка STOP в уведомлении');
    return stop();
  }

  @override
  Future<void> onSkipToNext() {
    LogService.log('⏭ onSkipToNext() вызван - кнопка NEXT в уведомлении');
    return skipToNext();
  }

  @override
  Future<void> onSkipToPrevious() {
    LogService.log('⏮ onSkipToPrevious() вызван - кнопка PREV в уведомлении');
    return skipToPrevious();
  }
}
