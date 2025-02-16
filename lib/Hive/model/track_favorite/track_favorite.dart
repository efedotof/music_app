import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'track_favorite.freezed.dart';
part 'track_favorite.g.dart';

@freezed
@HiveType(typeId: 0, adapterName: 'TrackBoxAdapter') 
class TrackFavoriteBox with _$TrackFavoriteBox {
  const factory TrackFavoriteBox({
    @HiveField(0) required String id,
    @HiveField(1) required double size,
    @HiveField(2) required String track,
    @HiveField(3) required int bitrate,
    @HiveField(4) required String duration,
    @HiveField(5) required String artistName,
    @HiveField(6) required bool playbackEnabled,
    @HiveField(7) required bool downloadEnabled,
    @HiveField(8) required String imageJpg,
    @HiveField(9) required String imageWebp,
    @HiveField(10) required bool explicit,
    @HiveField(11) required int artistId,
    @HiveField(12) required bool isArtistForeignAgent,
  }) = _TrackFavoriteBox;

  factory TrackFavoriteBox.fromJson(Map<String, dynamic> json) => _$TrackFavoriteBoxFromJson(json);
}
