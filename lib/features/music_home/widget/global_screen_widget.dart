import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/playlist/playlist_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

import 'playlist_card.dart';
import 'tracks_model.dart';

class GlobalScreenWidget extends StatelessWidget {
  const GlobalScreenWidget({super.key, required this.tracks});
  final List<Tracks> tracks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Популярные плейлисты',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        BlocBuilder<PlaylistCubit, PlaylistState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(
                  height: 150,
                  child: Center(child: CircularProgressIndicator())),
              loading: () => const SizedBox(
                  height: 150,
                  child: Center(child: CircularProgressIndicator())),
              error: (error) => Center(
                  child:
                      Text(error, style: const TextStyle(color: Colors.red))),
              playlistsLoaded: (playlists) => SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: playlists.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, index) => SizedBox(
                    width: 120,
                    child: PlaylistCard(playlist: playlists[index]),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 40),
        const Text(
          'Популярное сегодня',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: List.generate(
              tracks.length,
              (index) => TracksModel(
                    tracks: tracks[index],
                    listTracks: tracks,
                  )),
        )
      ],
    );
  }
}
