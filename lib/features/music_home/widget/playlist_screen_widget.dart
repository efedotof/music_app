import 'package:flutter/material.dart';
import 'package:music_app/features/music_home/widget/widget.dart';
import 'package:music_app/music_repository/music_model/playlist/playlist.dart';

class PlaylistScreenWidget extends StatelessWidget {
  const PlaylistScreenWidget({super.key, required this.playlists});
  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(playlists.length, (index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 24,
              child: PlaylistCard(playlist: playlists[index]),
            );
          }),
        ),
      ],
    );
  }
}
