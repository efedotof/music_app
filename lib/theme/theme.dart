

import 'package:flutter/material.dart';


final _primatyColor = Colors.white;

final dartTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: _primatyColor, brightness: Brightness.dark),

  scaffoldBackgroundColor: Color(0xFF1F2127),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF42B483),
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xFF1F2127),
    elevation: 0,
  ),
);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: _primatyColor, brightness: Brightness.light),
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF42B483),
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xFFF5F5F5),
    elevation: 0,
  )
);