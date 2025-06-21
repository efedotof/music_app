import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/Hive/cubit/track_favorite_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/download_buttons/download_buttons_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/favorite_button/favorite_button_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playback/playback_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

class CurrentTrackWidget extends StatelessWidget {
  const CurrentTrackWidget(
      {super.key,
      required this.playstopCubit,
      required this.track,
      required this.trackList});
  final PlaystopMusicCubit playstopCubit;
  final Tracks track;
  final List<Tracks> trackList;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      color: Colors.black87,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<Duration>(
            stream: playstopCubit.audioHandler.positionStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final position = snapshot.data!;
                return StreamBuilder<Duration?>(
                  stream: playstopCubit.audioHandler.durationStream,
                  builder: (context, durationSnapshot) {
                    final duration = durationSnapshot.data ?? Duration.zero;
                    final percentage = duration.inSeconds > 0
                        ? position.inSeconds / duration.inSeconds
                        : 0.0;

                    return Column(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onHorizontalDragUpdate: (details) {
                            final box = context.findRenderObject() as RenderBox;
                            final localOffset =
                                box.globalToLocal(details.globalPosition);
                            final newPosition = localOffset.dx / box.size.width;
                            final newSeekPosition = Duration(
                                seconds:
                                    (newPosition * duration.inSeconds).toInt());
                            playstopCubit.audioHandler.seek(newSeekPosition);
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
                                  left:
                                      (MediaQuery.of(context).size.width - 16) *
                                          percentage,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(position),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              _formatDuration(duration),
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
                    title: Text(track.track,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(track.artistName,
                        style: const TextStyle(color: Colors.white70)),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        playstopCubit.playPreviousTrack();
                        context
                            .read<FavoriteButtonCubit>()
                            .setFavorite(track: track);
                      },
                      icon:
                          const Icon(Icons.skip_previous, color: Colors.white),
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
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (playbackState is Playing) {
                              playstopCubit.pauseTrack();
                              context.read<PlaybackCubit>().pause();
                            } else {
                              playstopCubit.playTrack(trackList, track);
                              context.read<PlaybackCubit>().play();
                            }
                          },
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        playstopCubit.playNextTrack();
                        context
                            .read<FavoriteButtonCubit>()
                            .setFavorite(track: track);
                      },
                      icon: const Icon(Icons.skip_next, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => playstopCubit.toggleLoop(),
                      icon: const Icon(Icons.repeat_outlined,
                          color: Colors.white),
                    ),
                    BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            context
                                .read<TrackFavoriteCubit>()
                                .addTrack(track: track, context: context);
                          },
                          icon: state.when(
                            noFavorite: () => const Icon(Icons.favorite_outline,
                                color: Colors.white),
                            favorite: () =>
                                const Icon(Icons.favorite, color: Colors.red),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<DownloadButtonsCubit, DownloadButtonsState>(
                      builder: (context, state) {
                        return state.when(
                          noDownload: () => IconButton(
                            icon:
                                const Icon(Icons.download, color: Colors.white),
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
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              context
                                  .read<DownloadButtonsCubit>()
                                  .downloadTrack(track: track);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
