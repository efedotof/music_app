import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/playback/playback_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

import 'rotating_image.dart';

class TracksModel extends StatefulWidget {
  const TracksModel({
    super.key,
    required this.tracks,
    required this.listTracks,
    required this.currentTrackId,
  });

  final Tracks tracks;
  final List<Tracks> listTracks;
  final String currentTrackId;

  @override
  State<TracksModel> createState() => _TracksModelState();
}

class _TracksModelState extends State<TracksModel>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final isCurrent = widget.tracks.id == widget.currentTrackId;

    return ListTile(
      onTap: () {
        context.read<PlaybackCubit>().play();
        context
            .read<PlaystopMusicCubit>()
            .playTrack(playlist: widget.listTracks, track: widget.tracks);
      },
      subtitle: Text(widget.tracks.artistName),
      leading: RotatingImage(
        imageUrl: widget.tracks.imageWebp,
        rotating: isCurrent,
      ),
      title: Text(
        widget.tracks.track,
        style: TextStyle(
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          color: isCurrent ? Colors.blue : null,
        ),
      ),
    );
  }
}
