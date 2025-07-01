import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/download_buttons/download_buttons_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/favorite_button/favorite_button_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';

import 'current_track_widget.dart';

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

            final playstopCubit = context.read<PlaystopMusicCubit>();

            return CurrentTrackWidget(
              playstopCubit: playstopCubit,
              track: track,
              trackList: trackList,
            );
          },
          initial: () => const SizedBox.shrink(),
          error: (error) => Text(
            'Ошибка воспроизведения: $error',
          ),
        );
      },
    );
  }
}
