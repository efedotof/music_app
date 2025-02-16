import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/music_model/tracks.dart';
import 'package:music_app/music_repository/music_repository.dart';

part 'music_state.dart';
part 'music_cubit.freezed.dart';

class MusicCubit extends Cubit<MusicState> {
  MusicCubit({required MusicRepository repository})
      : _repository = repository,
        super(MusicState.initial()) {
    getRecomendationTrack();
  }
  final MusicRepository _repository;

  Future<void> getRecomendationTrack() async {
    try {
      emit(const MusicState.loading());
      final tracks = await _repository.getRecommendedTracks();
      debugPrint(tracks.toString());
      if (tracks.isNotEmpty) {
        emit(MusicState.loaded(tracks: tracks));
      } else {
        emit(const MusicState.error(error: 'Ничего не найдено, сорри'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(MusicState.error(error: e.toString()));
    }
  }
}
