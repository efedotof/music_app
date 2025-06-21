import 'package:flutter/material.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';
import 'tracks_model.dart';

class TracksScreenWidget extends StatelessWidget {
  const TracksScreenWidget({super.key, required this.tracks});
  final List<Tracks> tracks;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(tracks.length,
          (index) => TracksModel(tracks: tracks[index], listTracks: tracks)),
    );
  }
}
