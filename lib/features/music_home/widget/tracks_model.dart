import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/playback/playback_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

class TracksModel extends StatelessWidget {
  const TracksModel({
    super.key,
    required this.tracks,
    required this.listTracks,
  });

  final Tracks tracks;
  final List<Tracks> listTracks;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<PlaybackCubit>().play();
        context
            .read<PlaystopMusicCubit>()
            .playTrack(playlist: listTracks, track: tracks);
      },
      subtitle: Text(tracks.artistName),
      leading: ClipOval(
        child: CachedNetworkImage(
          imageUrl: tracks.imageWebp,
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
      title: Text(tracks.track),
    );
  }
}
