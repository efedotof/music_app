import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_app/features/music_home/cubit/playback_cubit.dart';
import 'package:music_app/features/music_home/cubit/playstop_music_cubit.dart';
import 'package:music_app/features/search/cubit/search_cubit.dart';

import '../widget/widget.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SearchField(),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return state.when(
                    initial: () =>
                        Text('Начните поиск для получения результатов'),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (tracks) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Wrap(
                              runSpacing: 10,
                              children: List.generate(
                                tracks.length,
                                (index) => ListTile(
                                  subtitle: Text(tracks[index].artistName),
                                  leading: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: tracks[index].imageWebp,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  title: Text(tracks[index].track),
                                  onTap: () {
                                    context.read<PlaystopMusicCubit>().playTrack(
                                        tracks[index], tracks[index].id);
                                    context.read<PlaybackCubit>().play();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    error: (e) => Center(child: Text(e)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
