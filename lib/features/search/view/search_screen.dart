import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_app/features/music_home/music_cubit/playback/playback_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/features/search/cubit/search_cubit.dart';
import 'package:music_app/features/search/widget/widget.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchField(),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(
                          child: Text(
                        'Начните поиск...',
                        style: TextStyle(color: Colors.white54),
                      )),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e) => Center(
                          child: Text(
                        e,
                        style: const TextStyle(color: Colors.redAccent),
                      )),
                      loaded: (tracks) {
                        return ListView.separated(
                          itemCount: tracks.length,
                          separatorBuilder: (_, __) =>
                              const Divider(color: Colors.white10),
                          itemBuilder: (context, index) {
                            final track = tracks[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: track.imageWebp,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                  ),
                                ),
                              ),
                              title: Text(
                                track.track,
                              ),
                              subtitle: Text(
                                track.artistName,
                              ),
                              onTap: () {
                                context
                                    .read<PlaystopMusicCubit>()
                                    .playTrack(playlist: tracks, track: track);
                                context.read<PlaybackCubit>().play();
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
