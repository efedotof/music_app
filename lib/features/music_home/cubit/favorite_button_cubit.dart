import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/Hive/repository/track_favorite_interface.dart';
import 'package:music_app/music_model/tracks.dart';

part 'favorite_button_state.dart';
part 'favorite_button_cubit.freezed.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit({required this.trackFavoriteInterface})
      : super(FavoriteButtonState.noFavorite());

  final TrackFavoriteInterface trackFavoriteInterface;

  Future<void> setFavorite({required Tracks track}) async {
    try {
      final favoriteTrackIds = await getFavorite();

      if (favoriteTrackIds.contains(track.id)) {
        emit(const FavoriteButtonState.favorite());
      } else {
        emit(const FavoriteButtonState.noFavorite());
      }
    } catch (e) {
      debugPrint('Ошибка в setFavorite: $e');
    }
  }

  void emitToEmpty() {
    emit(const FavoriteButtonState.noFavorite());
  }

  Future<List<String>> getFavorite() async {
    try {
      final trackList = trackFavoriteInterface.getAllTracks();
      final trackIds = trackList.map((track) => track.id).toList();
      debugPrint('Список избранных ID: $trackIds');
      return trackIds;
    } catch (e) {
      debugPrint('Ошибка в getFavorite: $e');
      return [];
    }
  }
}
