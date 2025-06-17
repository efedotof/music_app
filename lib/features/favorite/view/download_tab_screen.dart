import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

@RoutePage()
class DownloadTabScreen extends StatefulWidget {
  const DownloadTabScreen({super.key});

  @override
  State<DownloadTabScreen> createState() => _DownloadTabScreenState();
}

class _DownloadTabScreenState extends State<DownloadTabScreen> {
  List<FileSystemEntity> downloadedFiles = [];

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
        return ['mp3', 'wav', 'aac'].contains(ext); // аудиофайлы
      }).toList();

      setState(() {
        downloadedFiles = files;
      });
    } catch (e) {
      debugPrint('Ошибка при чтении файлов: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return downloadedFiles.isEmpty
        ? const Center(child: Text('Нет загруженных треков'))
        : ListView.builder(
            itemCount: downloadedFiles.length,
            itemBuilder: (context, index) {
              final file = downloadedFiles[index];
              final fileName = file.path.split(Platform.pathSeparator).last;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(fileName),
                  subtitle: Text(file.path),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      // TODO: реализация проигрывания
                    },
                  ),
                ),
              );
            },
          );
  }
}
