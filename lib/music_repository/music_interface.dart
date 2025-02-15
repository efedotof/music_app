import 'package:music_app/music_model/tracks.dart';

abstract interface class MusicInterface {
  Future<List<Tracks>> getRecommendedTracks();
  Future<List<Tracks>> search(String query);
  Future<String> getToken();
  Future<Map<String, dynamic>> fetchTracksFilezMeta(List<String> trackIds);
  Future<String?> getTrackUrl(String trackId);
}
