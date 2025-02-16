import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/main_home/widget/music_player_bottom.dart';
import 'package:music_app/features/music_home/cubit/playstop_music_cubit.dart';
import 'package:music_app/router/app_route.dart';

@RoutePage()
class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [MusicHomeRoute(), SearchRoute(), FavoriteRoute()],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: Stack(
            children: [
              child,
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BlocBuilder<PlaystopMusicCubit, PlaystopMusicState>(
                  builder: (context, state) {
                    return const MusicPlayerBottom();
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar:
              BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  tabsRouter.setActiveIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      label: 'Home', icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: 'Search', icon: Icon(Icons.search)),
                  BottomNavigationBarItem(
                      label: 'Favorite', icon: Icon(Icons.favorite)),
                ],
              ),
        );
      },
    );
  }
}
