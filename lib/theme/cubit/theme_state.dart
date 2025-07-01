// theme_state.dart
part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({required Brightness brightness}) = _ThemeState;

  const ThemeState._();

  bool get isDark => brightness == Brightness.dark;
}