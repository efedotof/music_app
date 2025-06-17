import 'package:music_app/music_model/playlist.dart';
import 'package:music_app/music_model/tracks.dart';

abstract interface class MusicInterface {
  Future<List<Tracks>> getRecommendedTracks();
  Future<List<Tracks>> search(String query);
  Future<String> getToken();
  Future<Map<String, dynamic>> fetchTracksFilezMeta(List<String> trackIds);
  Future<String?> getTrackUrl(String trackId);
  Future<List<String>> fetchPlaylistNames({int page = 1, int limit = 20});
  Future<List<Playlist>> fetchPlaylistsInfo(List<String> playlistUrls);
  Future<List<Tracks>> getTracksByUrl(String url);
  Future<void> downloadTrack({
    required String downloadUrl,
    required String fileName,
    required void Function(double progress)? onProgress,
  });
}
