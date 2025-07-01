import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';
import 'tracks_model.dart';

class TracksScreenWidget extends StatelessWidget {
  const TracksScreenWidget({super.key, required this.tracks});
  final List<Tracks> tracks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: List.generate(
              tracks.length,
              (index) => TracksModel(
                    tracks: tracks[index],
                    listTracks: tracks,
                    currentTrackId: context
                            .read<PlaystopMusicCubit>()
                            .audioHandler
                            .currentTrack
                            ?.id ??
                        '',
                  )),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        )
      ],
    );
  }
}
