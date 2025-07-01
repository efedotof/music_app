import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:music_app/features/favorite/favorite.dart';
import 'package:music_app/features/music_home/music_home.dart';
import 'package:music_app/features/playlist/playlist.dart';
import 'package:music_app/features/search/search.dart';
import 'package:music_app/features/main_home/main_home.dart';
import 'package:music_app/music_repository/music_model/playlist/playlist.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainHomeRoute.page, path: '/', children: [
          AutoRoute(page: MusicHomeRoute.page, path: 'music_home'),
          AutoRoute(page: SearchRoute.page, path: 'search'),
          AutoRoute(page: FavoriteRoute.page, path: 'favorite', children: [
            AutoRoute(page: FavoriteTabRoute.page, path: 'favorite_tab'),
            AutoRoute(page: DownloadTabRoute.page, path: 'download_tab'),
          ]),
        ]),
        AutoRoute(page: PlaylistRoute.page, path: '/playlist'),
      ];
}
