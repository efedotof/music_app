import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/music_cubit/music/music_cubit.dart';
import 'package:music_app/music_repository/music_model/playlist/playlist.dart';
import 'package:music_app/music_repository/music_model/tracks/tracks.dart';
import 'package:music_app/theme/cubit/theme_cubit.dart';

import '../widget/widget.dart';

@RoutePage()
class MusicHomeScreen extends StatefulWidget {
  const MusicHomeScreen({super.key});

  @override
  State<MusicHomeScreen> createState() => _MusicHomeScreenState();
}

class _MusicHomeScreenState extends State<MusicHomeScreen> {
  int selectedFilterIndex = 0;

  final List<String> filters = ['Все', 'Плейлисты', 'Треки'];

  Future<void> _fetchDataByIndex(int index) async {
    final cubit = context.read<MusicCubit>();
    switch (index) {
      case 0:
        await cubit.getGlobal();
        break;
      case 1:
        await cubit.getPlayList();
        break;
      case 2:
        await cubit.getRecomendationTrack();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                  onPressed: () {
                    _setTheme(context, themeState.isDark ? false : true);
                  },
                  icon: themeState.isDark
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode));
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: NotificationListener<ScrollNotification>(
          onNotification: (_) => true,
          child: RefreshIndicator(
            color: Colors.white,
            backgroundColor: Colors.grey[900],
            onRefresh: () => _fetchDataByIndex(selectedFilterIndex),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final isSelected = selectedFilterIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedFilterIndex = index);
                            _fetchDataByIndex(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.purple : Colors.grey[800],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                filters[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[400],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<MusicCubit, MusicState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white)),
                        loading: () => const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white)),
                        tracksScreen: (tracks) =>
                            TracksScreenWidget(tracks: tracks),
                        error: (e) => Center(
                          child: Text(
                            e,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                        playListScreen: (List<Playlist> playlists) =>
                            PlaylistScreenWidget(playlists: playlists),
                        globalScreen:
                            (List<Tracks> tracks, List<Playlist> playlists) =>
                                GlobalScreenWidget(tracks: tracks),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setTheme(BuildContext context, bool value) {
    context.read<ThemeCubit>().setThemeBrightness(
          value ? Brightness.dark : Brightness.light,
        );
  }
}
