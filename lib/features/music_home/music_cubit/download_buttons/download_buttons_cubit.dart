import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';
import 'package:music_app/music_repository/music/music_interface.dart';

part 'download_buttons_state.dart';
part 'download_buttons_cubit.freezed.dart';

class DownloadButtonsCubit extends Cubit<DownloadButtonsState> {
  DownloadButtonsCubit({required MusicInterface interface})
      : _interface = interface,
        super(DownloadButtonsState.noDownload());
  final MusicInterface _interface;

  Future<Map<String, dynamic>?> _fetchTrackMeta(String trackId) async {
    final tracksMeta = await _interface.fetchTracksFilezMeta([trackId]);
    return tracksMeta['tracks']?.firstWhere(
      (track) => track['id'].toString() == trackId,
      orElse: () => null,
    );
  }

  void noDownloads() {
    emit(DownloadButtonsState.noDownload());
  }

  Future<void> downloadTrack({required Tracks track}) async {
    try {
      final trackMeta = await _fetchTrackMeta(track.id);
      if (trackMeta != null) {
        final trackUrl = await _interface.getTrackUrl(trackMeta['streaming']);
        if (trackUrl != null) {
          emit(const DownloadButtonsState.downloads(progress: 0.0));
          String filename = "${track.track}_${track.artistName}";
          await _interface.downloadTrack(
            downloadUrl: trackUrl,
            fileName: filename,
            onProgress: (progress) {
              emit(DownloadButtonsState.downloads(progress: progress));
            },
          );

          emit(const DownloadButtonsState.successDownloads());
        } else {
          debugPrint('Произошло исключение: песня не найдена');
        }
      }
    } catch (e) {
      debugPrint('Произошло исключение: $e');
      emit(const DownloadButtonsState.noDownload());
    }
  }
}
