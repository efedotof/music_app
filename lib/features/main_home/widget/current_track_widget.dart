import 'package:flutter/material.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';
import 'album_art_widget.dart';
import 'extra_buttons_repeat_like_download_widget.dart';
import 'main_controls_widget.dart';
import 'title_artist_widget.dart';

class CurrentTrackWidget extends StatefulWidget {
  const CurrentTrackWidget({
    super.key,
    required this.playstopCubit,
    required this.track,
    required this.trackList,
  });

  final PlaystopMusicCubit playstopCubit;
  final Tracks track;
  final List<Tracks> trackList;

  @override
  State<CurrentTrackWidget> createState() => _CurrentTrackWidgetState();
}

class _CurrentTrackWidgetState extends State<CurrentTrackWidget>
    with TickerProviderStateMixin {
  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101010), Color(0xFF181818)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ClipRect(
                child: isMore
                    ? ExtraButtonsRepeatLikeDownloadWidget(
                        playstopCubit: widget.playstopCubit,
                        track: widget.track,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMore = !isMore;
                    });
                  },
                  child: AlbumArtWidget(
                    track: widget.track,
                  ),
                ),
                const SizedBox(width: 12),
                TitleArtistWidget(
                  track: widget.track,
                ),
                const SizedBox(width: 12),
                MainControlsWidget(
                  playstopCubit: widget.playstopCubit,
                  trackList: widget.trackList,
                  track: widget.track,
                ),
                const SizedBox(height: 8),
              ],
            ),
            const SizedBox(height: 12),
            StreamBuilder<Duration>(
              stream: widget.playstopCubit.audioHandler.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;

                return StreamBuilder<Duration?>(
                  stream: widget.playstopCubit.audioHandler.durationStream,
                  builder: (context, durationSnapshot) {
                    final duration = durationSnapshot.data ?? Duration.zero;
                    final percentage = duration.inSeconds > 0
                        ? position.inSeconds / duration.inSeconds
                        : 0.0;

                    return Column(
                      children: [
                        GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            final box = context.findRenderObject() as RenderBox;
                            final localOffset =
                                box.globalToLocal(details.globalPosition);
                            final newPosition = localOffset.dx / box.size.width;
                            final seekTo = Duration(
                                seconds:
                                    (newPosition * duration.inSeconds).toInt());
                            widget.playstopCubit.audioHandler.seek(seekTo);
                          },
                          child: SizedBox(
                            height: 24,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final barWidth = constraints.maxWidth;
                                final knobPosition = barWidth * percentage;

                                return Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      height: 5,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: percentage,
                                      child: Container(
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: (knobPosition - 6)
                                          .clamp(0.0, barWidth - 12),
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.greenAccent,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDuration(position),
                                style: TextStyle(
                                    color: Colors.grey[300], fontSize: 12)),
                            Text(_formatDuration(duration),
                                style: TextStyle(
                                    color: Colors.grey[300], fontSize: 12)),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ])),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
