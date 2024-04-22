import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolls/bloc/toll_cubit.dart';
import 'package:tolls/screens/entry_screen.dart';
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
    return BlocProvider(
      create: (context) => TollCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().selectLightTheme(),
        home: const EntryScreen(),
      ),
    );
  }
}
