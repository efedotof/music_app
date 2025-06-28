import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/search/cubit/search_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        // color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: (query) {
          context.read<SearchCubit>().searchTracks(query);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Поиск трека, плейлиста...',
          // hintStyle: TextStyle(color: Colors.white54),
          icon: Icon(
            Icons.search,
          ),
          suffixText: 'Отмена',
          // suffixStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
