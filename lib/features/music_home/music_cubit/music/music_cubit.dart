import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/music_repository/music_model/playlist/playlist.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';
import 'package:music_app/music_repository/music/music_repository.dart';

part 'music_state.dart';
part 'music_cubit.freezed.dart';

class MusicCubit extends Cubit<MusicState> {
  MusicCubit({required MusicRepository repository})
      : _repository = repository,
        super(MusicState.initial()) {
    getGlobal();
  }
  final MusicRepository _repository;

  Future<void> getGlobal() async {
    try {
      emit(const MusicState.loading());
      final tracks = await _repository.getRecommendedTracks();
      final playlistsName = await _repository.fetchPlaylistNames();
      final playlists = await _repository.fetchPlaylistsInfo(playlistsName);

      if (tracks.isNotEmpty && playlists.isNotEmpty) {
        emit(MusicState.globalScreen(traks: tracks, playlists: playlists));
      } else {
        emit(const MusicState.error(error: 'Ничего не найдено, сорри'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(MusicState.error(error: e.toString()));
    }
  }

  Future<void> getRecomendationTrack() async {
    try {
      emit(const MusicState.loading());
      final tracks = await _repository.getRecommendedTracks();
      debugPrint(tracks.toString());
      if (tracks.isNotEmpty) {
        emit(MusicState.tracksScreen(tracks: tracks));
      } else {
        emit(const MusicState.error(error: 'Ничего не найдено, сорри'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(MusicState.error(error: e.toString()));
    }
  }

  Future<void> getPlayList() async {
    try {
      emit(const MusicState.loading());
      final playlistsName = await _repository.fetchPlaylistNames();
      final playlists = await _repository.fetchPlaylistsInfo(playlistsName);
      if (playlists.isNotEmpty) {
        emit(MusicState.playListScreen(playlists: playlists));
      } else {
        emit(const MusicState.error(error: 'Ничего не найдено, сорри'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(MusicState.error(error: e.toString()));
    }
  }
}
