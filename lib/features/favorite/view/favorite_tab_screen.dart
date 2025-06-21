import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Hive/model/track_favorite/track_favorite.dart';
import 'package:music_app/features/music_home/widget/widget.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';

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

        final trackList = tracks.map((track) {
          return Tracks(
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
            isArtistForeignAgent: track.isArtistForeignAgent,
          );
        }).toList();

        return ListView.builder(
          itemCount: trackList.length,
          itemBuilder: (context, index) {
            final track = trackList[index];
            return TracksModel(
              tracks: track,
              listTracks: trackList,
            );
          },
        );
      },
    );
  }
}
