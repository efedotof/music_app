import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/music_model/tracks.dart';
import 'package:music_app/music_repository/music_repository.dart';

part 'playstop_music_state.dart';
part 'playstop_music_cubit.freezed.dart';

class PlaystopMusicCubit extends Cubit<PlaystopMusicState> {
  final MusicRepository _repository;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPaused = false;
  bool _isLooping = false;
  int _currentTrackIndex = 0;
  List<Tracks> _playlist = [];
  Duration _lastPosition = Duration.zero;

  AudioPlayer get audioPlayer => _audioPlayer;

  PlaystopMusicCubit({
    required MusicRepository repository,
  })  : _repository = repository,
        super(const PlaystopMusicState.initial()) {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNextTrack();
      }
    });
  }

  Future<void> playTrack(List<Tracks> playlist, Tracks track) async {
    try {
      _playlist = playlist;
      _currentTrackIndex = playlist.indexOf(track);

      final trackMeta = await _fetchTrackMeta(track.id);

      if (trackMeta != null) {
        final trackUrl = await _repository.getTrackUrl(trackMeta['streaming']);

        if (trackUrl != null) {
          if (_audioPlayer.playing) await _audioPlayer.stop();

          await _audioPlayer.setUrl(trackUrl);

          if (_isPaused && _lastPosition != Duration.zero) {
            await _audioPlayer.seek(_lastPosition);
          }

          await _audioPlayer.play();

          emit(PlaystopMusicState.currentTrack(
              trackList: playlist, track: track));
          _isPaused = false;
        } else {
          emit(const PlaystopMusicState.error(error: 'Ошибка загрузки трека.'));
        }
      } else {
        emit(const PlaystopMusicState.error(
            error: 'Метаданные трека не найдены.'));
      }
    } catch (e) {
      emit(PlaystopMusicState.error(error: e.toString()));
    }
  }

  Future<Map<String, dynamic>?> _fetchTrackMeta(String trackId) async {
    final tracksMeta = await _repository.fetchTracksFilezMeta([trackId]);
    return tracksMeta['tracks']?.firstWhere(
      (track) => track['id'].toString() == trackId,
      orElse: () => null,
    );
  }

  Future<void> playNextTrack() async {
    if (_playlist.isEmpty) return;
    _currentTrackIndex = (_currentTrackIndex + 1) % _playlist.length;
    await playTrack(_playlist, _playlist[_currentTrackIndex]);
  }

  Future<void> playPreviousTrack() async {
    if (_playlist.isEmpty) return;
    _currentTrackIndex =
        (_currentTrackIndex - 1 + _playlist.length) % _playlist.length;
    await playTrack(_playlist, _playlist[_currentTrackIndex]);
  }

  Future<void> pauseTrack() async {
    _lastPosition = _audioPlayer.position;
    await _audioPlayer.pause();
    _isPaused = true;
    emit(PlaystopMusicState.currentTrack(
        trackList: _playlist, track: _playlist[_currentTrackIndex]));
  }

  Future<void> stopTrack() async {
    _lastPosition = Duration.zero; // Сброс позиции
    await _audioPlayer.stop();
    emit(const PlaystopMusicState.initial());
  }

  Future<void> resumeTrack() async {
    if (_isPaused) {
      await _audioPlayer.seek(_lastPosition); // ← восстановление позиции
      await _audioPlayer.play();
      _isPaused = false;
      emit(PlaystopMusicState.currentTrack(
          trackList: _playlist, track: _playlist[_currentTrackIndex]));
    }
  }

  void toggleLoop() {
    _isLooping = !_isLooping;
    emit(PlaystopMusicState.currentTrack(
        trackList: _playlist, track: _playlist[_currentTrackIndex]));
  }

  @override
  Future<void> close() async {
    await _audioPlayer.dispose();
    return super.close();
  }
}
