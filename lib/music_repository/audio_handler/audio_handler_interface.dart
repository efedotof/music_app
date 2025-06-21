import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

abstract interface class AudioHandlerInterface {
  Future<void> loadPlaylist(List<Tracks> tracks);
  Future<void> play();
  Future<void> pause();
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  Future<void> seek(Duration position);
  void toggleLoop();
  Future<void> close();
  Future<void> stop();

  Stream<Duration> get positionStream;
  Stream<Duration?> get durationStream;

  Future<void> handlePlay();
  Future<void> handlePause();
  Future<void> handleStop();
  Future<void> handleSkipToNext();
  Future<void> handleSkipToPrevious();
  Future<void> handleSeek(Duration position);
  Future<void> playLocalFile(String filePath);
}
