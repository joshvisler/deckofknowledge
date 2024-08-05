import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(colorSchemeSeed: Colors.black, useMaterial3: true
        //   colorScheme: const ColorScheme(
        // brightness: Brightness.light,
        // primary: Color(0xFF38608f),
        // onPrimary: Color(0xFFFFFFFF),
        // primaryContainer: Color(0xFFd2e4ff),
        // onPrimaryContainer: Color(0xFF001c37),
        // secondary: Color(0xFF535f70),
        // onSecondary: Color(0xFFffffff),
        // secondaryContainer: Color(0xFFd2e4ff),
        // onSecondaryContainer: Color(0xFF101c2b),
        // tertiary: Color(0xFF6c5677),
        // onTertiary: Color(0xFF6c5677),
        // tertiaryContainer: Color(0xFFf4d9ff),
        // onTertiaryContainer: Color(0xFF261431),
        // error: Color(0xFFba1a1a),
        // onError: Color(0xFFffffff),
        // surface: Color(0xFF2e3035),
        // onSurface: Color(0xFFeff0f7),
        // inversePrimary: Color(0XFFa2c9fe)
        //)
        );
  }

  static ThemeData get dark {
    return ThemeData(colorSchemeSeed: Colors.purple, useMaterial3: true);
  }
}
