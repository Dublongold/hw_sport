import 'package:flutter/material.dart';

import 'colors.dart';

const TextStyle whiteColor = TextStyle(color: Colors.white);

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    background: backgroundColor,
  ),
  textTheme: const TextTheme(
    bodySmall: whiteColor,
    bodyLarge: whiteColor,
    bodyMedium: whiteColor,
    headlineSmall: whiteColor,
    headlineMedium: whiteColor,
    headlineLarge: whiteColor,
  ),
  fontFamily: "GothamPro",
  useMaterial3: true,
);