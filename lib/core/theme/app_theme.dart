import 'package:flutter/material.dart';

ThemeData get darkTheme {
  return ThemeData(
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: const Color.fromARGB(255, 0, 255, 251),
        fontSize: 20,
      ),
    ),
  );
}
