import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/search/cubit/search_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.075,
        decoration: BoxDecoration(
          color: const Color(0xFF2E333D),
          borderRadius: BorderRadius.circular(13),
        ),
        child: TextField(
          controller: controller,
          onSubmitted: (value) {
            context.read<SearchCubit>().searchTracks(value);
          },
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(color: Color(0xFFB8CAE4)),
            prefixIcon: const Icon(Icons.search, color: Color(0xFFB8CAE4)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
            filled: false,
          ),
        ),
      ),
    );
  }
}
