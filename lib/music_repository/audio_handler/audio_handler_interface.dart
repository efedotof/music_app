import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

abstract interface class AudioHandlerInterface {
  Future<void> loadPlaylist(List<Tracks> tracks, {int startIndex = 0});
  Future<void> play();
  Future<void> playLocalFile(String filePath);
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  void toggleLoop();
  Future<void> close();
  void toggleShuffle();

  Stream<Duration> get positionStream;
  Stream<Duration?> get durationStream;
  Stream<Tracks> get currentTrackStream;
  Tracks? get currentTrack;

  Future<void> onPlay();
  Future<void> onPause();
  Future<void> onStop();
  Future<void> onSkipToNext();
  Future<void> onSkipToPrevious();
}
