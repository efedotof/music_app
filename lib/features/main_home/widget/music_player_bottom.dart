import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/Hive/cubit/track_favorite_cubit.dart';
import 'package:music_app/Hive/model/track_favorite/track_favorite.dart';
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
          currentTrack: (track) => Container(
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
                            onPressed: () => context
                                .read<PlaystopMusicCubit>()
                                .playPreviousTrack(),
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
                                        .playTrack(track, track.id);
                                    context.read<PlaybackCubit>().play();
                                  }
                                },
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () => context
                                .read<PlaystopMusicCubit>()
                                .playNextTrack(),
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
                          IconButton(
                              onPressed: () => context
                                  .read<TrackFavoriteCubit>()
                                  .addTrack(TrackFavoriteBox(
                                      id: track.id,
                                      size: track.size,
                                      track: track.track,
                                      bitrate: track.bitrate,
                                      duration: track.duration,
                                      artistName: track.artistName,
                                      playbackEnabled: track.playbackEnabled,
                                      downloadEnabled: track.downloadEnabled,
                                      imageJpg: track.imageJpg,
                                      imageWebp: track.imageWebp,
                                      explicit: track.explicit,
                                      artistId: track.artistId,
                                      isArtistForeignAgent:
                                      track.isArtistForeignAgent)),
                              icon: Icon(Icons.favorite_outline)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.download_outlined)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          initial: () => const SizedBox.shrink(),
          error: (error) => Text('Ошибка воспроизведения: $error'),
        );
      },
    );
  }
}
