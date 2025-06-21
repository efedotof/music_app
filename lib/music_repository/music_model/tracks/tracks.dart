import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracks.freezed.dart';
part 'tracks.g.dart';

@freezed
class Tracks with _$Tracks {
  const factory Tracks({
    required String id, 
    required double size,
    required String track,
    required int bitrate,
    required String duration,
    required String artistName,
    required bool playbackEnabled,
    required bool downloadEnabled,
    required String imageJpg,
    required String imageWebp,
    required bool explicit,
    required int artistId,
    required bool isArtistForeignAgent,
    
  }) = _Tracks;

  factory Tracks.fromJson(Map<String, dynamic> json) => _$TracksFromJson(json);
}