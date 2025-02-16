import 'package:music_app/music_model/playlist.dart';

import 'music_interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app/config.dart';
import 'package:music_app/music_model/tracks.dart';

class MusicRepository implements MusicInterface {
  final Dio _dio = Dio();
  final String address = musicAddress;

  @override
  Future<List<Tracks>> getRecommendedTracks() async {
    try {
      final response = await _dio.get('$address/index/recommended?limit=40');

      if (response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> trackIds = data['trackIds'] ?? [];
        final Map<String, dynamic> tracksInfo = data['tracksInfo'] ?? {};

        List<Tracks> tracksList = [];

        for (var id in trackIds) {
          final trackJson = tracksInfo[id.toString()];

          if (trackJson != null) {
            tracksList.add(Tracks.fromJson({
              'id': id.toString(),
              'size': trackJson['size'] ?? 0.0,
              'track': trackJson['track'] ?? 'Unknown Track',
              'bitrate': trackJson['bitrate'] ?? 128,
              'duration': trackJson['duration'] ?? '00:00',
              'artistName': trackJson['artistName'] ?? 'Unknown Artist',
              'playbackEnabled': trackJson['playbackEnabled'] ?? false,
              'downloadEnabled': trackJson['downloadEnabled'] ?? false,
              'imageJpg': trackJson['imageJpg'] ?? '',
              'imageWebp': trackJson['imageWebp'] ?? '',
              'explicit': trackJson['explicit'] ?? false,
              'artistId': trackJson['artistId'] ?? 0,
              'isArtistForeignAgent':
                  trackJson['isArtistForeignAgent'] ?? false,
            }));
          }
        }

        return tracksList;
      } else {
        throw Exception('Ошибка загрузки треков: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка при выполнении запроса: $e');
    }
  }

  @override
  Future<List<Tracks>> search(String query) async {
    try {
      final response = await _dio.get('$address/search?q=$query&limitTrack=50');

      if (response.statusCode == 200) {
        final data = response.data;

        final List<dynamic> trackIds = data['tracks']['trackIds'];
        final Map<String, dynamic> tracksInfo = data['tracks']['tracksInfo'];

        List<Tracks> tracksList = [];
        for (var id in trackIds) {
          if (tracksInfo.containsKey(id.toString())) {
            var trackJson = tracksInfo[id.toString()];
            trackJson['id'] = id.toString();
            tracksList.add(Tracks.fromJson(trackJson));
          }
        }

        return tracksList;
      } else {
        throw Exception('Ошибка загрузки треков: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка при выполнении запроса: $e');
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final response = await _dio.get('http://api.zaycev.net/external/hello');

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        return token;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Future<Map<String, dynamic>> fetchTracksFilezMeta(
      List<String> trackIds) async {
    const url = 'https://zaycev.net/api/external/track/filezmeta';

    final body = {
      'subscription': false,
      'trackIds': trackIds,
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        debugPrint('Ответ API: $data');

        if (data is Map<String, dynamic> && data.containsKey('tracks')) {
          return data;
        } else {
          debugPrint('Ошибка: ответ не содержит ключа "tracks".');
          return {'tracks': []};
        }
      } else {
        throw Exception('Ошибка загрузки треков: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка при выполнении запроса: $e');
    }
  }

  @override
  Future<String?> getTrackUrl(String trackId) async {
    try {
      final response = await _dio.get(
        'https://zaycev.net/api/external/track/play/$trackId',
      );

      if (response.statusCode == 200) {
        final data = response.data;

        debugPrint(': $data');

        if (data is Map<String, dynamic> && data.containsKey('url')) {
          return data['url'];
        } else {
          debugPrint('Ошибка: ответ не содержит ключа "url".');
          return null;
        }
      } else {
        throw Exception('Ошибка загрузки трека: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка при выполнении запроса: $e');
    }
  }

  @override
  Future<List<String>> fetchPlaylistNames(
      {int page = 1, int limit = 20}) async {
    try {
      final response = await _dio
          .get('$playlistAPI?type=category&limit=$limit&page=$page&query=all');
      if (response.statusCode == 200) {
        return List<String>.from(response.data['list']);
      } else {
        throw Exception('Ошибка загрузки плейлистов: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка запроса: $e');
    }
  }

  @override
  Future<List<Playlist>> fetchPlaylistsInfo(List<String> playlistUrls) async {
    try {
      final response =
          await _dio.get('$playlistAPI/info?urls=${playlistUrls.join(',')}');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return data.values.map((json) => Playlist.fromJson(json)).toList();
      } else {
        throw Exception(
            'Ошибка загрузки информации о плейлистах: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка запроса: $e');
    }
  }

  @override
  Future<List<Tracks>> getTracksByUrl(String url) async {
    try {
      final response = await _dio.get(
        '$fetchPlayListTrack$url',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final Map<String, dynamic> tracksInfo = data['tracksInfo'] ?? {};

        List<Tracks> tracksList = [];
        tracksInfo.forEach((id, trackJson) {
          tracksList.add(Tracks.fromJson({
            'id': id,
            'size': trackJson['size'] ?? 0.0,
            'track': trackJson['track'] ?? 'Unknown Track',
            'bitrate': trackJson['bitrate'] ?? 128,
            'duration': trackJson['duration'] ?? '00:00',
            'artistName': trackJson['artistName'] ?? 'Unknown Artist',
            'playbackEnabled': trackJson['playbackEnabled'] ?? false,
            'downloadEnabled': trackJson['downloadEnabled'] ?? false,
            'imageJpg': trackJson['imageJpg'] ?? '',
            'imageWebp': trackJson['imageWebp'] ?? '',
            'explicit': trackJson['explicit'] ?? false,
            'artistId': trackJson['artistId'] ?? 0,
            'isArtistForeignAgent': trackJson['isArtistForeignAgent'] ?? false,
          }));
        });
        return tracksList;
      } else {
        throw Exception('Ошибка загрузки треков: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка при выполнении запроса: $e');
    }
  }
}
