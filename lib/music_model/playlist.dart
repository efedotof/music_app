import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist.freezed.dart';
part 'playlist.g.dart';

@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    required int id,
    required String title,
    required String url,
    required String description,
    @JsonKey(name: 'square200', defaultValue: '') required String imageUrl,
    required int trackCount,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);
}
