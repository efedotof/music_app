// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TracksImpl _$$TracksImplFromJson(Map<String, dynamic> json) => _$TracksImpl(
      id: json['id'] as String,
      size: (json['size'] as num).toDouble(),
      track: json['track'] as String,
      bitrate: (json['bitrate'] as num).toInt(),
      duration: json['duration'] as String,
      artistName: json['artistName'] as String,
      playbackEnabled: json['playbackEnabled'] as bool,
      downloadEnabled: json['downloadEnabled'] as bool,
      imageJpg: json['imageJpg'] as String,
      imageWebp: json['imageWebp'] as String,
      explicit: json['explicit'] as bool,
      artistId: (json['artistId'] as num).toInt(),
      isArtistForeignAgent: json['isArtistForeignAgent'] as bool,
    );

Map<String, dynamic> _$$TracksImplToJson(_$TracksImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'size': instance.size,
      'track': instance.track,
      'bitrate': instance.bitrate,
      'duration': instance.duration,
      'artistName': instance.artistName,
      'playbackEnabled': instance.playbackEnabled,
      'downloadEnabled': instance.downloadEnabled,
      'imageJpg': instance.imageJpg,
      'imageWebp': instance.imageWebp,
      'explicit': instance.explicit,
      'artistId': instance.artistId,
      'isArtistForeignAgent': instance.isArtistForeignAgent,
    };
