// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

/// generated route for
/// [DownloadTabScreen]
class DownloadTabRoute extends PageRouteInfo<void> {
  const DownloadTabRoute({List<PageRouteInfo>? children})
      : super(
          DownloadTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'DownloadTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DownloadTabScreen();
    },
  );
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoriteScreen();
    },
  );
}

/// generated route for
/// [FavoriteTabScreen]
class FavoriteTabRoute extends PageRouteInfo<void> {
  const FavoriteTabRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoriteTabScreen();
    },
  );
}

/// generated route for
/// [MainHomeScreen]
class MainHomeRoute extends PageRouteInfo<void> {
  const MainHomeRoute({List<PageRouteInfo>? children})
      : super(
          MainHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainHomeScreen();
    },
  );
}

/// generated route for
/// [MusicHomeScreen]
class MusicHomeRoute extends PageRouteInfo<void> {
  const MusicHomeRoute({List<PageRouteInfo>? children})
      : super(
          MusicHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MusicHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MusicHomeScreen();
    },
  );
}

/// generated route for
/// [PlaylistScreen]
class PlaylistRoute extends PageRouteInfo<PlaylistRouteArgs> {
  PlaylistRoute({
    Key? key,
    required Playlist playlist,
    List<PageRouteInfo>? children,
  }) : super(
          PlaylistRoute.name,
          args: PlaylistRouteArgs(
            key: key,
            playlist: playlist,
          ),
          initialChildren: children,
        );

  static const String name = 'PlaylistRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlaylistRouteArgs>();
      return PlaylistScreen(
        key: args.key,
        playlist: args.playlist,
      );
    },
  );
}

class PlaylistRouteArgs {
  const PlaylistRouteArgs({
    this.key,
    required this.playlist,
  });

  final Key? key;

  final Playlist playlist;

  @override
  String toString() {
    return 'PlaylistRouteArgs{key: $key, playlist: $playlist}';
  }
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchScreen();
    },
  );
}
