import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/playback/playback_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

class MainControlsWidget extends StatelessWidget {
  const MainControlsWidget(
      {super.key,
      required this.playstopCubit,
      required this.trackList,
      required this.track});

  final PlaystopMusicCubit playstopCubit;
  final List<Tracks> trackList;
  final Tracks track;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: IconButton(
            icon: Icon(Icons.skip_previous, color: Colors.white, size: 28),
            onPressed: () {
              playstopCubit.playPreviousTrack();
            },
            splashRadius: 24,
          ),
        ),
        BlocBuilder<PlaybackCubit, PlaybackState>(
          builder: (context, playbackState) {
            final isPlaying = playbackState is Playing;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white, size: 28),
                onPressed: () {
                  if (isPlaying) {
                    playstopCubit.pauseTrack();
                    context.read<PlaybackCubit>().pause();
                  } else {
                    playstopCubit.playTrack(playlist: trackList, track: track);
                    context.read<PlaybackCubit>().play();
                  }
                },
                splashRadius: 24,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: IconButton(
            icon: Icon(Icons.skip_next, color: Colors.white, size: 28),
            onPressed: () {
              playstopCubit.playNextTrack();
            },
            splashRadius: 24,
          ),
        )
      ],
    );
  }
}
