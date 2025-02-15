import 'package:auto_route/auto_route.dart';
import 'package:music_app/features/favorite/favorite.dart';
import 'package:music_app/features/music_home/music_home.dart';
import 'package:music_app/features/search/search.dart';
import 'package:music_app/features/main_home/main_home.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

 @override
 List<AutoRoute> get routes => [
   AutoRoute(page: MainHomeRoute.page, path: '/', children: [
      AutoRoute(page: MusicHomeRoute.page, path: 'music_home'),
      AutoRoute(page: SearchRoute.page, path: 'search'),
      AutoRoute(page:  FavoriteRoute.page, path: 'favorite'),
   ])
 ];
}