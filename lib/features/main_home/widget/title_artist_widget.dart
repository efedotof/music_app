import 'package:flutter/material.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

class TitleArtistWidget extends StatelessWidget {
  const TitleArtistWidget({super.key, required this.track});

  final Tracks track;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(track.track,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
          const SizedBox(height: 4),
          Text(track.artistName,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }
}
