import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';


@RoutePage()
class DownloadTabScreen extends StatelessWidget {
  const DownloadTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Center(child: Text('Downloads'),);
  }
}
