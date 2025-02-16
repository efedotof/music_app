import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/cubit/music_cubit.dart';
import 'package:music_app/features/music_home/cubit/playlist_cubit.dart';

import '../widget/widget.dart';

@RoutePage()
class MusicHomeScreen extends StatelessWidget {
  const MusicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MusicCubit, MusicState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (tracks) {
              // context.read<PlaystopMusicCubit>().setPlaylist(tracks);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<PlaylistCubit, PlaylistState>(
                      builder: (context, state) {
                        return state.when(
                            initial: () =>
                                Center(child: SingleChildScrollView()),
                            loading: () =>
                                Center(child: SingleChildScrollView()),
                            error: (error) => Center(
                                  child: Text(error),
                                ),
                            playlistsLoaded: (playlists) =>
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    children: List.generate(
                                        playlists.length,
                                        (index) => PlaylistCard(
                                            playlist: playlists[index])),
                                  ),
                                ));
                      },
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: List.generate(
                        tracks.length,
                        (index) => TracksModel(tracks: tracks[index],),
                      ),
                    ),
                    const SizedBox(height: 100,)
                  ],
                ),
              );
            },
            error: (e) => Center(child: Text(e)),
          );
        },
      ),
      
    );
  }
}
