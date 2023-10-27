import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: palette[2],
  textTheme: GoogleFonts.robotoTextTheme(TextTheme(
    titleLarge: const TextStyle(color: Colors.white),
    titleMedium: const TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: palette[2]),
    bodyLarge: const TextStyle(color: Colors.white),
    /**/ bodyMedium: const TextStyle(color: Colors.white),
    bodySmall: const TextStyle(color: Colors.white),
    /**/ labelLarge: TextStyle(color: palette[2]),
    /**/ labelMedium: TextStyle(color: palette[3]),
    labelSmall: const TextStyle(color: Colors.grey),
  )),
  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.dark(
      primary: palette[1],
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: palette[3],
    dividerColor: Colors.white54,
    indicatorColor: palette[3],
  ),
);

var palette = <Color>[
  //const Color.fromARGB(255, 111, 51, 206),
  Color(0xFF613E9E),
  Color(0xFF815BBE),
  //Colors.purple[700]!,
  //const Color(0xFF845EC2),
  const Color(0xFFA178DF), // !IMPORTANT COLOR
  const Color(0xFFBE93FD),
  const Color(0xFFDCB0FF),
  const Color(0xFFFACCFF)
];
