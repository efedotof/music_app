import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Hive/cubit/track_favorite_cubit.dart';
import 'package:music_app/Hive/repository/track_favorite_repository.dart';
import 'package:music_app/features/music_home/music_cubit/favorite_button/favorite_button_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/music/music_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playback/playback_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playlist/playlist_cubit.dart';
import 'package:music_app/features/music_home/music_cubit/playstop_music/playstop_music_cubit.dart';
import 'package:music_app/features/playlist/cubit/playlist_track_cubit.dart';
import 'package:music_app/features/search/cubit/search_cubit.dart';
import 'package:music_app/music_repository/audio_handler/audio_handler_repository.dart';
import 'package:music_app/music_repository/music/music_repository.dart';
import 'package:music_app/theme/cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/music_home/music_cubit/download_buttons/download_buttons_cubit.dart';
import 'music_repository/logger_service/logger_service.dart';
import 'router/app_route.dart';
import 'theme/theme.dart';
import 'theme/theme/theme_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final musicRepository = MusicRepository();
  final audioHandler = await AudioService.init(
    builder: () => AudioHandlerRepository(repository: musicRepository),
    config: const AudioServiceConfig(
      androidResumeOnClick: true,
      androidNotificationChannelId: 'com.efedotov.channel.audio',
      androidNotificationChannelName: 'Music Playback',
      androidNotificationOngoing: true,
      notificationColor: Colors.black,
      androidNotificationClickStartsActivity: true,
      androidStopForegroundOnPause: true,
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidShowNotificationBadge: true,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final preference = await SharedPreferences.getInstance();
  final themeRepository = ThemeRepository(preferences: preference);

  final trackFavoriteRepository = TrackFavoriteRepository();
  await TrackFavoriteRepository.init();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    LogService.error('Flutter Error', details.exception, details.stack);
  };

  runZonedGuarded(() {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(themeInterface: themeRepository),
        ),
        BlocProvider(
          create: (context) => MusicCubit(repository: musicRepository),
        ),
        BlocProvider(
          create: (context) => PlaybackCubit(),
        ),
        BlocProvider(
          create: (context) => PlaystopMusicCubit(
            audioHandler: audioHandler,
          ),
        ),
        BlocProvider(
            create: (context) => PlaylistCubit(repository: musicRepository)),
        BlocProvider(
            create: (context) =>
                DownloadButtonsCubit(interface: musicRepository)),
        BlocProvider(
            create: (context) => SearchCubit(repository: musicRepository)),
        BlocProvider(
            create: (context) =>
                PlaylistTrackCubit(repository: musicRepository)),
        BlocProvider(
          create: (context) => FavoriteButtonCubit(
              trackFavoriteInterface: trackFavoriteRepository),
        ),
        BlocProvider(
            create: (context) => TrackFavoriteCubit(
                trackFavoriteRepository: trackFavoriteRepository)),
      ],
      child: const MusicApp(),
    ));
  }, (error, stackTrace) {
    LogService.error('Zoned Error', error, stackTrace);
  });
}

class MusicApp extends StatefulWidget {
  const MusicApp({super.key});

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: state.isDark ? lightTheme : dartTheme,
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
