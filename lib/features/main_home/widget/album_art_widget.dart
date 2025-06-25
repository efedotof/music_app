import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

class AlbumArtWidget extends StatelessWidget {
  const AlbumArtWidget({super.key, required this.track});

  final Tracks track;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: track.imageWebp,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder: (_, __) => const CircularProgressIndicator(strokeWidth: 2),
        errorWidget: (_, __, ___) =>
            const Icon(Icons.music_note, color: Colors.white),
      ),
    );
  }
}
