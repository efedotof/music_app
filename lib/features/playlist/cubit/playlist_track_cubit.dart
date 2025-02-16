import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/music_model/tracks.dart';
import 'package:music_app/music_repository/music_repository.dart';

part 'playlist_track_state.dart';
part 'playlist_track_cubit.freezed.dart';

class PlaylistTrackCubit extends Cubit<PlaylistTrackState> {
  PlaylistTrackCubit({required MusicRepository repository}) : _repository = repository, super(PlaylistTrackState.initial());
  final MusicRepository _repository;

  Future<void> getTrackslists({required String url}) async {
    try {
      emit(const PlaylistTrackState.loading());
      final tracks = await _repository.getTracksByUrl(url);
      if (tracks.isNotEmpty) {
        emit(PlaylistTrackState.tracklists(trackslist: tracks));
      } else {
        emit(const PlaylistTrackState.error(error: 'Плейлисты не найдены'));
      }
    } catch (e) {
      emit(PlaylistTrackState.error(error: e.toString()));
    }
  }

}
