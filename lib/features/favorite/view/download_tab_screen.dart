import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';

import 'package:music_app/features/music_home/widget/widget.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

@RoutePage()
class DownloadTabScreen extends StatefulWidget {
  const DownloadTabScreen({super.key});

  @override
  State<DownloadTabScreen> createState() => _DownloadTabScreenState();
}

class _DownloadTabScreenState extends State<DownloadTabScreen> {
  List<FileSystemEntity> downloadedFiles = [];
  List<Tracks> _tracks = [];

  @override
  void initState() {
    super.initState();
    _loadDownloads();
  }

  Future<void> _loadDownloads() async {
    try {
      Directory dir;
      if (Platform.isAndroid || Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        dir = await getDownloadsDirectory() ??
            await getApplicationDocumentsDirectory();
      }

      final files = dir.listSync().where((f) {
        final ext = f.path.split('.').last.toLowerCase();
        return ['mp3', 'wav', 'aac'].contains(ext);
      }).toList();

      final tracksList = await _loadTracksFromFiles(files);

      setState(() {
        downloadedFiles = files;
        // Если нужно, чтобы именно список Tracks был в состоянии, можно добавить еще поле
        _tracks = tracksList;
      });
    } catch (e) {
      debugPrint('Ошибка при чтении файлов: $e');
    }
  }

  Future<List<Tracks>> _loadTracksFromFiles(
      List<FileSystemEntity> files) async {
    List<Tracks> tracksList = [];

    for (final file in files) {
      if (file is File) {
        final fileStat = await file.stat();
        final fileName = p.basename(file.path);

        final track = Tracks(
          id: file.path,
          size: fileStat.size / (1024 * 1024),
          track: fileName,
          bitrate: 128,
          duration: "00:03:30",
          artistName: "Unknown Artist",
          playbackEnabled: true,
          downloadEnabled: true,
          imageJpg: "",
          imageWebp: "",
          explicit: false,
          artistId: 0,
          isArtistForeignAgent: false,
        );

        tracksList.add(track);
      }
    }

    return tracksList;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _loadDownloads,
        child: downloadedFiles.isEmpty
            ? ListView(
                children: const [
                  SizedBox(
                      height: 300,
                      child: Center(child: Text('Нет загруженных треков'))),
                ],
              )
            : ListView.builder(
                itemCount: _tracks.length,
                itemBuilder: (context, index) {
                  final track = _tracks[index];
                  return TracksModel(
                    tracks: track,
                    listTracks: _tracks,
                    currentTrackId: context
                            .read<PlaystopMusicCubit>()
                            .audioHandler
                            .currentTrack
                            ?.id ??
                        '',
                  );
                },
              ));
  }
}
