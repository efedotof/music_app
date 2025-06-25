import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/Hive/cubit/track_favorite_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/download_buttons/download_buttons_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/favorite_button/favorite_button_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

class ExtraButtonsRepeatLikeDownloadWidget extends StatelessWidget {
  const ExtraButtonsRepeatLikeDownloadWidget(
      {super.key, required this.playstopCubit, required this.track});

  final PlaystopMusicCubit playstopCubit;
  final Tracks track;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.repeat, color: Colors.white70),
          onPressed: () => playstopCubit.toggleLoop(),
        ),
        BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
          builder: (context, state) {
            return IconButton(
              icon: state.when(
                noFavorite: () =>
                    const Icon(Icons.favorite_border, color: Colors.white),
                favorite: () =>
                    const Icon(Icons.favorite, color: Colors.redAccent),
              ),
              onPressed: () {
                context
                    .read<TrackFavoriteCubit>()
                    .addTrack(track: track, context: context);
              },
            );
          },
        ),
        BlocBuilder<DownloadButtonsCubit, DownloadButtonsState>(
          builder: (context, state) {
            return state.when(
              noDownload: () => IconButton(
                icon: const Icon(Icons.download, color: Colors.white),
                onPressed: () {
                  context
                      .read<DownloadButtonsCubit>()
                      .downloadTrack(track: track);
                },
              ),
              downloads: (progress) => SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                  color: Colors.greenAccent,
                ),
              ),
              successDownloads: () => IconButton(
                icon: const Icon(Icons.check, color: Colors.greenAccent),
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
    );
  }
}
