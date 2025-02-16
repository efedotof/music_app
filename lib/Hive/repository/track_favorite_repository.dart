import 'package:hive/hive.dart';
import 'package:music_app/Hive/model/track_favorite/track_favorite.dart';

import 'track_favorite_interface.dart';

class TrackFavoriteRepository implements TrackFavoriteInterface {
  static const String _boxName = 'trackBox';

  static Future<void> init() async {
    Hive.registerAdapter(TrackBoxAdapter());
    await Hive.openBox<TrackFavoriteBox>(_boxName);
  }

  static Future<void> dispose() async {
    if (Hive.isBoxOpen(_boxName)) {
      await Hive.box<TrackFavoriteBox>(_boxName).close();
    }
    Hive.close();
  }

  @override
  Future<void> addTrack(TrackFavoriteBox track) async {
    final box = Hive.box<TrackFavoriteBox>(_boxName);
    await box.put(track.id, track);
  }

  @override
  TrackFavoriteBox? getTrack(String id) {
    final box = Hive.box<TrackFavoriteBox>(_boxName);
    return box.get(id);
  }

  @override
  Future<void> deleteTrack(String id) async {
    final box = Hive.box<TrackFavoriteBox>(_boxName);
    await box.delete(id);
  }

  @override
  Future<void> clearTracks() async {
    final box = Hive.box<TrackFavoriteBox>(_boxName);
    await box.clear();
  }

  @override
  List<TrackFavoriteBox> getAllTracks() {
    final box = Hive.box<TrackFavoriteBox>(_boxName);
    return box.values.toList();
  }
}
