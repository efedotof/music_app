import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:music_app/router/app_route.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        FavoriteTabRoute(),
        DownloadTabRoute(),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            leading: const AutoLeadingButton(),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: 'Favorite', icon: Icon(Icons.favorite)),
                Tab(text: 'Download', icon: Icon(Icons.download)),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
