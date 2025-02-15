import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/cubit/music_cubit.dart';
import 'package:music_app/features/music_home/cubit/playback_cubit.dart';
import 'package:music_app/features/music_home/cubit/playstop_music_cubit.dart';

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
              context.read<PlaystopMusicCubit>().setPlaylist(tracks);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SearchField(),
                      ],
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: List.generate(
                        tracks.length,
                        (index) => TracksModel(tracks: tracks, index: index),
                      ),
                    )
                  ],
                ),
              );
            },
            error: (e) => Center(child: Text(e)),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<PlaystopMusicCubit, PlaystopMusicState>(
        builder: (context, state) {
          return state.when(
            currentTrack: (track) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Полоска прогресса с изменяемым курсором
                StreamBuilder<Duration>(
                  stream: context
                      .read<PlaystopMusicCubit>()
                      .audioPlayer
                      .positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final position = snapshot.data!;
                      return StreamBuilder<Duration?>(
                        stream: context
                            .read<PlaystopMusicCubit>()
                            .audioPlayer
                            .durationStream
                            .map((duration) => duration ?? Duration.zero),
                        builder: (context, durationSnapshot) {
                          final duration = durationSnapshot.data;
                          final percentage =
                              duration != null && duration.inSeconds > 0
                                  ? position.inSeconds / duration.inSeconds
                                  : 0.0;

                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                final width = MediaQuery.of(context).size.width;

                                final newPosition =
                                    details.localPosition.dx / width;

                                final newSeekPosition = duration != null
                                    ? Duration(
                                        seconds:
                                            (newPosition * duration.inSeconds)
                                                .toInt())
                                    : Duration.zero;
                                context
                                    .read<PlaystopMusicCubit>()
                                    .audioPlayer
                                    .seek(newSeekPosition);
                              },
                              child: Container(
                                height: 5,
                                width: double.infinity,
                                color: Colors.black26,
                                alignment: Alignment.centerLeft,
                                child: FractionallySizedBox(
                                  widthFactor: percentage,
                                  child: Container(
                                    height: 5,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(height: 5, color: Colors.grey);
                    }
                  },
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://zaycev.net${track.imageWebp}"),
                        maxRadius: 20,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(track.track),
                          subtitle: Text(track.artistName),
                        ),
                      ),
                      BlocBuilder<PlaybackCubit, PlaybackState>(
                        builder: (context, playbackState) {
                          return IconButton(
                            icon: Icon(
                              playbackState.maybeWhen(
                                playing: () => Icons.pause,
                                paused: () => Icons.play_arrow,
                                orElse: () => Icons.play_arrow,
                              ),
                            ),
                            onPressed: () {
                              if (playbackState is Playing) {
                                context.read<PlaystopMusicCubit>().pauseTrack();
                                context.read<PlaybackCubit>().pause();
                              } else {
                                context
                                    .read<PlaystopMusicCubit>()
                                    .playTrack(track, track.id);
                                context.read<PlaybackCubit>().play();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            initial: () => const SizedBox.shrink(),
            error: (error) => Text('Ошибка воспроизведения: $error'),
          );
        },
      ),
    );
  }
}
