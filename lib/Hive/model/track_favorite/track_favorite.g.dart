// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackBoxAdapter extends TypeAdapter<TrackFavoriteBox> {
  @override
  final int typeId = 0;

  @override
  TrackFavoriteBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackFavoriteBox(
      id: fields[0] as String,
      size: fields[1] as double,
      track: fields[2] as String,
      bitrate: fields[3] as int,
      duration: fields[4] as String,
      artistName: fields[5] as String,
      playbackEnabled: fields[6] as bool,
      downloadEnabled: fields[7] as bool,
      imageJpg: fields[8] as String,
      imageWebp: fields[9] as String,
      explicit: fields[10] as bool,
      artistId: fields[11] as int,
      isArtistForeignAgent: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TrackFavoriteBox obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.track)
      ..writeByte(3)
      ..write(obj.bitrate)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.artistName)
      ..writeByte(6)
      ..write(obj.playbackEnabled)
      ..writeByte(7)
      ..write(obj.downloadEnabled)
      ..writeByte(8)
      ..write(obj.imageJpg)
      ..writeByte(9)
      ..write(obj.imageWebp)
      ..writeByte(10)
      ..write(obj.explicit)
      ..writeByte(11)
      ..write(obj.artistId)
      ..writeByte(12)
      ..write(obj.isArtistForeignAgent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackFavoriteBoxImpl _$$TrackFavoriteBoxImplFromJson(
        Map<String, dynamic> json) =>
    _$TrackFavoriteBoxImpl(
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

Map<String, dynamic> _$$TrackFavoriteBoxImplToJson(
        _$TrackFavoriteBoxImpl instance) =>
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
