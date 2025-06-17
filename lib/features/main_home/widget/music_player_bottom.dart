import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/Hive/cubit/track_favorite_cubit.dart';
import 'package:music_app/features/music_home/cubit/download_buttons_cubit.dart';
import 'package:music_app/features/music_home/cubit/favorite_button_cubit.dart';
import 'package:music_app/features/music_home/cubit/playback_cubit.dart';
import 'package:music_app/features/music_home/cubit/playstop_music_cubit.dart';

class MusicPlayerBottom extends StatefulWidget {
  const MusicPlayerBottom({super.key});

  @override
  State<MusicPlayerBottom> createState() => _MusicPlayerBottomState();
}

class _MusicPlayerBottomState extends State<MusicPlayerBottom> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaystopMusicCubit, PlaystopMusicState>(
      builder: (context, state) {
        return state.when(
          currentTrack: (trackList, track) {
            context.read<FavoriteButtonCubit>().setFavorite(track: track);
            context.read<DownloadButtonsCubit>().noDownloads();
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              color: Colors.black87,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                            return Column(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onHorizontalDragUpdate: (details) {
                                    final box =
                                        context.findRenderObject() as RenderBox;
                                    final localOffset = box
                                        .globalToLocal(details.globalPosition);
                                    final newPosition =
                                        localOffset.dx / box.size.width;
                                    final newSeekPosition = Duration(
                                        seconds:
                                            (newPosition * duration!.inSeconds)
                                                .toInt());
                                    context
                                        .read<PlaystopMusicCubit>()
                                        .audioPlayer
                                        .seek(newSeekPosition);
                                  },
                                  child: SizedBox(
                                    height: 20,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Container(
                                          height: 5,
                                          width: double.infinity,
                                          color: Colors.grey[800],
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: percentage,
                                          child: Container(
                                            height: 5,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Positioned(
                                          left: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  16) *
                                              percentage,
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(position),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      _formatDuration(
                                          duration ?? Duration.zero),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
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
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: track.imageWebp,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(track.track),
                            subtitle: Text(track.artistName),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<PlaystopMusicCubit>()
                                    .playPreviousTrack();
                                context
                                    .read<FavoriteButtonCubit>()
                                    .setFavorite(track: track);
                              },
                              icon: Icon(Icons.skip_previous),
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
                                      context
                                          .read<PlaystopMusicCubit>()
                                          .pauseTrack();
                                      context.read<PlaybackCubit>().pause();
                                    } else {
                                      context
                                          .read<PlaystopMusicCubit>()
                                          .playTrack(trackList, track);
                                      context.read<PlaybackCubit>().play();
                                    }
                                  },
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<PlaystopMusicCubit>()
                                    .playNextTrack();
                                context
                                    .read<FavoriteButtonCubit>()
                                    .setFavorite(track: track);
                              },
                              icon: Icon(Icons.skip_next),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => context
                                    .read<PlaystopMusicCubit>()
                                    .toggleLoop(),
                                icon: Icon(Icons.repeat_outlined)),
                            BlocBuilder<FavoriteButtonCubit,
                                FavoriteButtonState>(
                              builder: (context, state) {
                                return IconButton(
                                    onPressed: () {
                                      context
                                          .read<TrackFavoriteCubit>()
                                          .addTrack(
                                              track: track, context: context);
                                    },
                                    icon: state.when(
                                        noFavorite: () =>
                                            Icon(Icons.favorite_outline),
                                        favorite: () => Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )));
                              },
                            ),
                            BlocBuilder<DownloadButtonsCubit,
                                    DownloadButtonsState>(
                                builder: (context, state) {
                              return state.when(
                                  noDownload: () => IconButton(
                                        icon: const Icon(Icons.download),
                                        onPressed: () {
                                          context
                                              .read<DownloadButtonsCubit>()
                                              .downloadTrack(track: track);
                                        },
                                      ),
                                  downloads: (double progress) => SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          value: progress,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                  successDownloads: () => IconButton(
                                        icon: const Icon(Icons.check),
                                        onPressed: () {
                                          context
                                              .read<DownloadButtonsCubit>()
                                              .downloadTrack(track: track);
                                        },
                                      ));
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          initial: () => const SizedBox.shrink(),
          error: (error) => Text('Ошибка воспроизведения: $error'),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
