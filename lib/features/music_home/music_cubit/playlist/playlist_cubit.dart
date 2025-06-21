import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/music_repository/music_model/playlist/playlist.dart';
import 'package:music_app/music_repository/music/music_repository.dart';

part 'playlist_state.dart';
part 'playlist_cubit.freezed.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit({required MusicRepository repository})
      : _repository = repository,
        super(PlaylistState.initial()) {
    getPlaylists();
  }
  final MusicRepository _repository;

  Future<void> getPlaylists() async {
    try {
      emit(const PlaylistState.loading());
      final playlistsName = await _repository.fetchPlaylistNames();
      final playlists = await _repository.fetchPlaylistsInfo(playlistsName);
      if (playlists.isNotEmpty) {
        emit(PlaylistState.playlistsLoaded(playlists: playlists));
      } else {
        emit(const PlaylistState.error(error: 'Плейлисты не найдены'));
      }
    } catch (e) {
      emit(PlaylistState.error(error: e.toString()));
    }
  }
}
