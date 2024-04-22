import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tolls/screens/cost_sheet.dart';
import 'package:tolls/screens/entry_screen.dart';
import 'package:tolls/screens/exit_screen.dart';
import 'package:tolls/utils/app_theme.dart';

void main() {
  runApp(const ETollApp());
}

class ETollApp extends StatelessWidget {
  const ETollApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().selectLightTheme(),
      home: const EntryScreen(),
    );
  }
}
