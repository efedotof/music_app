import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/main_home/widget/music_player_bottom.dart';
import 'package:music_app/features/music_home/widget/tracks_model.dart';
import 'package:music_app/features/playlist/cubit/playlist_track_cubit.dart';
import 'package:music_app/music_repository/music_model/playlist/playlist.dart';

@RoutePage()
class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key, required this.playlist});
  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.title),
        backgroundColor: Colors.transparent,
        actions: [],
      ),
      body: SingleChildScrollView(
          child: BlocBuilder<PlaylistTrackCubit, PlaylistTrackState>(
        builder: (context, state) {
          return state.when(
              initial: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              error: (error) => Center(
                    child: Text(error),
                  ),
              tracklists: (tracks) => Wrap(
                    children: List.generate(
                        tracks.length,
                        (index) => TracksModel(
                              tracks: tracks[index],
                              listTracks: tracks,
                            )),
                  ));
        },
      )),
      bottomNavigationBar: MusicPlayerBottom(),
    );
  }
}
