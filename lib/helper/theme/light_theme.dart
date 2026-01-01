import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'NewFonts',
  primaryColor: const Color(0xFF695c4c),
  brightness: Brightness.light,
  highlightColor: Colors.white,
  focusColor: const Color(0xFFD09538),
  hintColor: const Color(0xFF9E9E9E),
  colorScheme: const ColorScheme.light(primary: Color(0xADD3C9B8), secondary: Color(0xFF695c4c),
    tertiary: Color(0xFFF9D4A8),tertiaryContainer: Color(0xFFADC9F3),
    onTertiaryContainer: Color(0xFF33AF74),
    primaryContainer: Color(0xFF9AECC6),secondaryContainer: Color(0xFFF2F2F2),),

  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);