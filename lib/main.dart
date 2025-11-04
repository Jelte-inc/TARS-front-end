import 'package:flutter/material.dart';
import 'package:tars_front_end/core/theme/app_theme.dart';
import 'package:tars_front_end/presentation/screens/terminal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Terminal(), theme: darkTheme);
  }
}
