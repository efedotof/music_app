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

  Future<void> onPlay();

  Future<void> onPause();

  Future<void> onStop();

  Future<void> onSkipToNext();

  Future<void> onSkipToPrevious();

  Future<void> playLocalFile(String filePath);
}
