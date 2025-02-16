import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Hive/model/track_favorite/track_favorite.dart';
import 'package:music_app/features/music_home/widget/widget.dart';
import 'package:music_app/music_model/tracks.dart';

@RoutePage()
class FavoriteTabScreen extends StatelessWidget {
  const FavoriteTabScreen({super.key});

  static const String _favoriteBox = 'trackBox';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TrackFavoriteBox>>(
      valueListenable: Hive.box<TrackFavoriteBox>(_favoriteBox).listenable(),
      builder: (context, box, _) {
        final tracks = box.values.toList();

        if (tracks.isEmpty) {
          return const Center(child: Text("Нет сохраненных треков"));
        }

        return ListView.builder(
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            final track = tracks[index];

            final trackModels = Tracks(
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
                isArtistForeignAgent: track.isArtistForeignAgent);

            return TracksModel(
              tracks: trackModels,
            );
            // return ListTile(
            //   leading: Image.network(track.imageJpg, width: 50, height: 50, fit: BoxFit.cover),
            //   title: Text(track.track),
            //   subtitle: Text(track.artistName),
            //   trailing: IconButton(
            //     icon: const Icon(Icons.delete, color: Colors.red),
            //     onPressed: () => box.delete(track.id),
            //   ),
            // );
          },
        );
      },
    );
  }
}
