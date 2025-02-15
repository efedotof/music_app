import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/cubit/playback_cubit.dart';
import 'package:music_app/features/music_home/cubit/playstop_music_cubit.dart';
import 'package:music_app/music_model/tracks.dart';

class TracksModel extends StatelessWidget {
  const TracksModel({super.key, required this.tracks, required this.index});

  final List<Tracks> tracks;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(tracks[index].artistName),
      leading: ClipOval(
        child: CachedNetworkImage(
          imageUrl: "https://zaycev.net/${tracks[index].imageWebp}",
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
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Text(tracks[index].track),
      onTap: () {
        context
            .read<PlaystopMusicCubit>()
            .playTrack(tracks[index], tracks[index].id);
        context.read<PlaybackCubit>().play();
      },
    );
  }
}
