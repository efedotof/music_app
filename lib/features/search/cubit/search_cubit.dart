import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/music_model/tracks.dart';
import 'package:music_app/music_repository/music_repository.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required MusicRepository repository}) : _repository = repository, super(SearchState.initial());

  final MusicRepository _repository;
  
  Future<void> searchTracks(String query) async {
    if (query.isEmpty) {
      emit(SearchState.initial());
      return;
    }

    try {
      emit(const SearchState.loading());
      final tracks = await _repository.search(query);
      if (tracks.isNotEmpty) {
        emit(SearchState.loaded(tracks: tracks));
      } else {
        emit(const SearchState.error(error: 'Ничего не найдено, сорри'));
      }
    } catch (e) {
      emit(SearchState.error(error: e.toString()));
    }
  }



}
