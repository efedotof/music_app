import 'package:shared_preferences/shared_preferences.dart';

import 'theme_interface.dart';

class ThemeRepository implements ThemeInterface {
  ThemeRepository({required this.preferences});

  final SharedPreferences preferences;

  static const _isDarkThemeSelectedKey = 'dark_theme_selected_key';

  @override
  bool isDarkTheme() {
    return preferences.getBool(_isDarkThemeSelectedKey) ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }
}
