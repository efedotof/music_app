import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music_home/cubit/music_cubit.dart';
import 'package:music_app/features/music_home/cubit/playback_cubit.dart';
import 'package:music_app/features/music_home/cubit/playstop_music_cubit.dart';
import 'package:music_app/music_repository/music_repository.dart';
import 'package:music_app/theme/cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'router/app_route.dart';
import 'theme/theme.dart';
import 'theme/theme/theme_repository.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final preference = await SharedPreferences.getInstance();
  final themeRepository = ThemeRepository(preferences: preference);
  final musicRepository = MusicRepository();

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
        create: (context) => PlaystopMusicCubit(repository: musicRepository),
      ),
    ],
    child: const MusicApp(),
  ));

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