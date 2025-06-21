import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/Hive/repository/track_favorite_interface.dart';
import 'package:music_app/features/music_home/music_cubit/favorite_button/favorite_button_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

import '../model/track_favorite/track_favorite.dart';

part 'track_favorite_state.dart';
part 'track_favorite_cubit.freezed.dart';

class TrackFavoriteCubit extends Cubit<TrackFavoriteState> {
  TrackFavoriteCubit({required TrackFavoriteInterface trackFavoriteRepository})
      : _trackFavoriteRepository = trackFavoriteRepository,
        super(TrackFavoriteState.initial());

  final TrackFavoriteInterface _trackFavoriteRepository;

  Future<void> addTrack(
      {required BuildContext context, required Tracks track}) async {
    try {
      List<String> trackID =
          await context.read<FavoriteButtonCubit>().getFavorite();

      if (trackID.contains(track.id)) {
        _trackFavoriteRepository.deleteTrack(track.id);
      } else {
        await _trackFavoriteRepository.addTrack(TrackFavoriteBox(
            id: track.id,
            size: track.size,
            track: track.track,
            bitrate: track.bitrate,
            duration: track.duration,
            artistName: track.artistName,
            playbackEnabled: track.playbackEnabled,
            downloadEnabled: track.downloadEnabled,
            imageJpg: track.imageJpg,
            imageWebp: track.imageWebp,
            explicit: track.explicit,
            artistId: track.artistId,
            isArtistForeignAgent: track.isArtistForeignAgent));
      }
      if (context.mounted) {
        context.read<FavoriteButtonCubit>().setFavorite(track: track);
      }
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
