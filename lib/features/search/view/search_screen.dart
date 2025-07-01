import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/features/music_home/widget/tracks_model.dart';
import 'package:music_app/features/search/cubit/search_cubit.dart';
import 'package:music_app/features/search/widget/widget.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                        return BlocBuilder<PlaystopMusicCubit,
                            PlaystopMusicState>(
                          builder: (context, state) {
                            return ListView.separated(
                              itemCount: tracks.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(color: Colors.white10),
                              itemBuilder: (context, index) {
                                final track = tracks[index];
                                return TracksModel(
                                  tracks: track,
                                  listTracks: tracks,
                                  currentTrackId: context
                                          .read<PlaystopMusicCubit>()
                                          .audioHandler
                                          .currentTrack
                                          ?.id ??
                                      '',
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
