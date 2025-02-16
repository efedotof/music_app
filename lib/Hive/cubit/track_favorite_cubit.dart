import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/Hive/repository/track_favorite_interface.dart';

import '../model/track_favorite/track_favorite.dart';

part 'track_favorite_state.dart';
part 'track_favorite_cubit.freezed.dart';

class TrackFavoriteCubit extends Cubit<TrackFavoriteState> {
  TrackFavoriteCubit({required TrackFavoriteInterface trackFavoriteRepository})
      : _trackFavoriteRepository = trackFavoriteRepository,
        super(TrackFavoriteState.initial());

  final TrackFavoriteInterface _trackFavoriteRepository;

  Future<void> addTrack(TrackFavoriteBox track) async {
    try {
      await _trackFavoriteRepository.addTrack(track);
      emit(TrackFavoriteState.success());
    } catch (e) {
      emit(TrackFavoriteState.failure(e.toString()));
    }
  }

  Future<void> removeTrack(String trackId) async {
    try {
      await _trackFavoriteRepository.deleteTrack(trackId);
      emit(TrackFavoriteState.success());
    } catch (e) {
      emit(TrackFavoriteState.failure(e.toString()));
    }
  }

  Future<void> clearAllTracks() async {
    try {
      await _trackFavoriteRepository.clearTracks();
      emit(TrackFavoriteState.success());
    } catch (e) {
      emit(TrackFavoriteState.failure(e.toString()));
    }
  }
}
