// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaylistImpl _$$PlaylistImplFromJson(Map<String, dynamic> json) =>
    _$PlaylistImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      url: json['url'] as String,
      description: json['description'] as String,
      imageUrl: json['square200'] as String? ?? '',
      trackCount: (json['trackCount'] as num).toInt(),
    );

Map<String, dynamic> _$$PlaylistImplToJson(_$PlaylistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'description': instance.description,
      'square200': instance.imageUrl,
      'trackCount': instance.trackCount,
    };
