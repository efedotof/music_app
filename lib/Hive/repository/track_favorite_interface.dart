import 'package:music_app/Hive/model/track_favorite/track_favorite.dart';

abstract interface class TrackFavoriteInterface {
  Future<void> addTrack(TrackFavoriteBox track);
  TrackFavoriteBox? getTrack(String id);
  Future<void> deleteTrack(String id);
  Future<void> clearTracks();
  List<TrackFavoriteBox> getAllTracks();
}
