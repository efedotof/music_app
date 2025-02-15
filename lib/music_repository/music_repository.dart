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
      final response = await _dio.get('$address/index/recommended?limit=10');
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        final data = response.data;

        final List<dynamic> trackIds = data['trackIds'];
        final Map<String, dynamic> tracksInfo = data['tracksInfo'];
        debugPrint(trackIds.toString());

        List<Tracks> tracksList = [];
        debugPrint(tracksList.toString());
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
  Future<List<Tracks>> search(String query) async {
    try {
      final response = await _dio.get('$address/search?q=$query&limitTrack=10');

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
}
